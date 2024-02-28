import 'package:get/get.dart';
import 'package:treeme/core/netwrok/web_connection.dart';
import 'package:treeme/core/utils/connectivity_check/connectivity_check.dart';
import 'package:treeme/modules/auth/data/data_sources/auth_data_source.dart';

import '../../modules/auth/presentation/manager/sign_up_controller.dart';

class SignUpBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAuthDataSource>(
      () => AuthDataSource(
          Get.find<WebServiceConnections>(), Get.find<IConnectivityChecker>()),
    );
    Get.lazyPut(() => SignUpController(Get.find<IAuthDataSource>(), Get.find()));
  }
}
