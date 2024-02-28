import 'package:get/get.dart';
import 'package:treeme/modules/contacts/data/data_sources/my_contact_data_source.dart';
import 'package:treeme/modules/contacts/presentation/manager/my_contact_controller.dart';

import '../netwrok/web_connection.dart';
import '../utils/connectivity_check/i_connectivity_checker.dart';

class MyContactBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IMyContactsDataSource>(
      () => MyContactDataSource(
          Get.find<WebServiceConnections>(), Get.find<IConnectivityChecker>()),
    );
    Get.lazyPut(() => MyContactController(Get.find<IMyContactsDataSource>(), Get.find()));
  }
}
