import "../../domain/entities/connection_status.dart";

sealed class ConnectivityEvent {}

class CheckConnectivity extends ConnectivityEvent {}

class UpdateConnectionStatus extends ConnectivityEvent {
  UpdateConnectionStatus(this.status);
  final ConnectionStatus status;
}

class SetConnectionRequired extends ConnectivityEvent {
  SetConnectionRequired(this.required);
  final bool required;
}

class ConnectivityState {
  const ConnectivityState({
    this.status = ConnectionStatus.offline,
    this.requiresConnection = true,
  });
  final ConnectionStatus status;
  final bool requiresConnection;

  ConnectivityState copyWith({
    ConnectionStatus? status,
    bool? requiresConnection,
  }) {
    return ConnectivityState(
      status: status ?? this.status,
      requiresConnection: requiresConnection ?? this.requiresConnection,
    );
  }
}
