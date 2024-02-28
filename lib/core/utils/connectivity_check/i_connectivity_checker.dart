abstract class IConnectivityChecker {
  Future<bool> isConnected();
  Stream<bool> monitorConnection();
}
