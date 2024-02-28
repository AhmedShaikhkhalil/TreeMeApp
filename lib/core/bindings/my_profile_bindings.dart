import 'package:get/get.dart';
import 'package:treeme/core/utils/image_picker/i_image_picker.dart';
import 'package:treeme/modules/my_profile/data/data_sources/edit_profile_data_source.dart';
import 'package:treeme/modules/my_profile/presentation/manager/my_profile_controller.dart';

import '../netwrok/web_connection.dart';
import '../utils/connectivity_check/i_connectivity_checker.dart';

class MyProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IEditProfileDataSource>(
      () => EditProfileDataSource(
          Get.find<WebServiceConnections>(), Get.find<IConnectivityChecker>()),
    );
    Get.lazyPut(() => MyProfileController(Get.find<IImagePicker>(), Get.find()));
  }
}
