

import 'package:get/get.dart';
import 'package:treeme/modules/profile/presentation/manager/profile_controller.dart';

class ProfileBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());

   }

}