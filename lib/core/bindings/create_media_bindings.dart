import 'package:get/get.dart';

import '../../modules/create_media/presentation/manager/create_media_controller.dart';

class CreateMediaBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateMediaController());
  }
}
