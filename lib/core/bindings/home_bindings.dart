import 'package:get/get.dart';
import 'package:treeme/modules/home/data/data_sources/home_data_source.dart';
import 'package:treeme/modules/home/presentation/manager/home_controller.dart';

import '../netwrok/web_connection.dart';
import '../utils/connectivity_check/i_connectivity_checker.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHomeDataSource>(
      () => HomeDataSource(
          Get.find<WebServiceConnections>(), Get.find<IConnectivityChecker>()),
    );
    Get.lazyPut(() => HomeController(Get.find<IHomeDataSource>()));
  }
}
