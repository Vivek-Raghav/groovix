import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../domain/entities/connection_status.dart";
import "../../domain/repositories/connectivity_repository.dart";
import "events_states.dart";

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc({required ConnectivityRepository repository})
      : _repository = repository,
        super(const ConnectivityState(status: ConnectionStatus.online)) {
    on<CheckConnectivity>(_onCheckConnectivity);
    on<UpdateConnectionStatus>(_onUpdateConnectionStatus);
    on<SetConnectionRequired>(_onSetConnectionRequired);

    // Initialize and listen to connectivity changes
    _initConnectivity();

    // Add periodic connectivity check
    _startPeriodicCheck();
  }

  final ConnectivityRepository _repository;
  StreamSubscription<ConnectionStatus>? _subscription;
  Timer? _periodicCheckTimer;

  // Add retry mechanism
  Future<void> _initConnectivity() async {
    int retryCount = 0;
    const maxRetries = 3;

    while (retryCount < maxRetries) {
      try {
        // First do an immediate connectivity check
        final isConnected = await _repository.checkConnection();
        add(UpdateConnectionStatus(
          isConnected ? ConnectionStatus.online : ConnectionStatus.offline,
        ));

        // Then start listening to the stream
        await _subscription?.cancel(); // Cancel any existing subscription
        _subscription = _repository.connectionStream.listen(
              (status) {
            add(UpdateConnectionStatus(status));
          },
          onError: (error) {
            debugPrint("Connectivity stream error: $error");
            add(UpdateConnectionStatus(ConnectionStatus.offline));
            _scheduleReconnection();
          },
        );

        break; // Success, exit the retry loop
      } catch (e) {
        retryCount++;
        if (retryCount == maxRetries) {
          debugPrint("Failed to initialize connectivity after $maxRetries attempts");
          add(UpdateConnectionStatus(ConnectionStatus.offline));
        } else {
          await Future.delayed(Duration(seconds: retryCount * 2));
        }
      }
    }
  }

  void _startPeriodicCheck() {
    _periodicCheckTimer?.cancel();
    _periodicCheckTimer = Timer.periodic(
      const Duration(minutes: 1),
          (_) => add(CheckConnectivity()),
    );
  }

  void _scheduleReconnection() {
    Future.delayed(const Duration(seconds: 5), _initConnectivity);
  }

  Future<void> _onCheckConnectivity(
      CheckConnectivity event,
      Emitter<ConnectivityState> emit,
      ) async {
    try {
      final isConnected = await _repository.checkConnection();
      final newStatus = isConnected ? ConnectionStatus.online : ConnectionStatus.offline;

      if (state.status != newStatus) {
        emit(state.copyWith(status: newStatus));
      }
    } catch (e) {
      debugPrint("Error checking connectivity: $e");
      emit(state.copyWith(status: ConnectionStatus.offline));
      _scheduleReconnection();
    }
  }

  void _onUpdateConnectionStatus(
      UpdateConnectionStatus event,
      Emitter<ConnectivityState> emit,
      ) {
    if (state.status != event.status) {
      emit(state.copyWith(status: event.status));
    }
  }

  void _onSetConnectionRequired(
      SetConnectionRequired event,
      Emitter<ConnectivityState> emit,
      ) {
    emit(state.copyWith(requiresConnection: event.required));
  }

  Future<bool> checkConnection() => _repository.checkConnection();

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    _periodicCheckTimer?.cancel();
    return super.close();
  }
}