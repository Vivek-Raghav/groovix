enum ConnectionStatus {
  online,
  offline;

  bool get isOnline => this == ConnectionStatus.online;
}
