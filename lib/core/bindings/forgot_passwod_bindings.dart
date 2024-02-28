import 'package:get/get.dart';
import 'package:treeme/core/netwrok/web_connection.dart';
import 'package:treeme/core/utils/connectivity_check/i_connectivity_checker.dart';
import 'package:treeme/modules/auth/data/data_sources/auth_data_source.dart';
import 'package:treeme/modules/auth/presentation/manager/forgot_password_controller.dart';

class ForgotPasswordBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAuthDataSource>(
      () => AuthDataSource(
          Get.find<WebServiceConnections>(), Get.find<IConnectivityChecker>()),
    );
    Get.lazyPut(() => ForgotPasswordController(Get.find<IAuthDataSource>()));
  }
}
