import 'package:get/get.dart';

import '../../modules/auth/data/data_sources/auth_data_source.dart';
import '../../modules/auth/presentation/manager/login_controller.dart';
import '../netwrok/web_connection.dart';
import '../utils/connectivity_check/i_connectivity_checker.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAuthDataSource>(
      () => AuthDataSource(
          Get.find<WebServiceConnections>(), Get.find<IConnectivityChecker>()),
    );
    Get.lazyPut(() => LoginController(Get.find<IAuthDataSource>(), Get.find()));
  }
}
