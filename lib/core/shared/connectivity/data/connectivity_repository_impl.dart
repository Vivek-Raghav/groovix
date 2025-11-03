import "package:connectivity_plus/connectivity_plus.dart";
import "package:groovix/core/core_index.dart";

import "../domain/entities/connection_status.dart";
import "../domain/repositories/connectivity_repository.dart";

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  ConnectivityRepositoryImpl({Connectivity? connectivity}) : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Stream<ConnectionStatus> get connectionStream {
    return Stream.fromFuture(_connectivity.checkConnectivity())
        .asyncExpand((_) {
          return _connectivity.onConnectivityChanged;
        })
        .map(_mapConnectionStatus)
        .distinct();
  }

  @override
  Future<bool> checkConnection() async {
    try {
      final results = await _connectivity.checkConnectivity();
      final status = _mapConnectionStatus(results);
      debugPrint("CONNECTION CHECKING: $status");
      return status.isOnline;
    } catch (e) {
      return false;
    }
  }

  ConnectionStatus _mapConnectionStatus(List<ConnectivityResult> results) {
    // Consider online if we have any valid connection
    if (results.any((result) => result != ConnectivityResult.none)) {
      return ConnectionStatus.online;
    }
    return ConnectionStatus.offline;
  }
}
