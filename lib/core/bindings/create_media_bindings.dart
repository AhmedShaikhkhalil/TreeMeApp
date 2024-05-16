import 'package:get/get.dart';

import '../../modules/create_event/data/data_sources/create_new_event_data_source.dart';
import '../../modules/create_event/presentation/manager/create_event_controller.dart';
import '../../modules/create_media/presentation/manager/create_media_controller.dart';
import '../netwrok/web_connection.dart';
import '../utils/connectivity_check/i_connectivity_checker.dart';

class CreateMediaBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ICreateEventDataSource>(
      () => CreateEventDataSource(
          Get.find<WebServiceConnections>(), Get.find<IConnectivityChecker>()),
    );

    Get.lazyPut(() =>
        CreateEventController(Get.find<ICreateEventDataSource>(), Get.find()));
    @override
    void dependencies() {
      Get.lazyPut(() => CreateMediaController(
          createEventController: Get.find<CreateEventController>()));
    }
  }
}
