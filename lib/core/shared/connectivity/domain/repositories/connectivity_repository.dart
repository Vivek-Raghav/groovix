import "../../domain/entities/connection_status.dart";

abstract class ConnectivityRepository {
  Stream<ConnectionStatus> get connectionStream;
  Future<bool> checkConnection();
}
