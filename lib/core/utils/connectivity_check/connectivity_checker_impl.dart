import 'package:cross_connectivity/cross_connectivity.dart' as impl;
import 'connectivity_check.dart';

class ConnectivityCheckerImpl implements IConnectivityChecker {
  final _connectivity = impl.Connectivity();

  @override
  Future<bool> isConnected() async {
    return await _connectivity.isConnected.first;
  }

  @override
  Stream<bool> monitorConnection() {
    return _connectivity.isConnected;
  }
}
