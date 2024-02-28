import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:treeme/core/helpers/page_loading_dialog/page_loading_dialog.dart';
import 'package:treeme/core/netwrok/web_connection.dart';
import 'package:treeme/core/utils/connectivity_check/connectivity_checker_impl.dart';
import 'package:treeme/core/utils/connectivity_check/i_connectivity_checker.dart';
import 'package:treeme/core/utils/image_picker/i_image_picker.dart';
import 'package:treeme/core/utils/image_picker/image_picker_impl/real_image_picker.dart';
import 'package:treeme/core/utils/services/storage.dart';

import '../../modules/splash/presentation/manager/splash_controller.dart';
import '../helpers/show_bottom_sheet/i_show_bottom_sheet.dart';
import '../helpers/show_bottom_sheet/show_bottom_sheet_impl.dart';

class MainBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => Storage(),
    );

    Get.lazyPut(
      () => Dio(),
    );
    Get.put(
      () => Dio(),
      permanent: true,
    );
    Get.put<IPageLoadingDialog>(
      PageLoadingDialog(),
      permanent: true,
    );
    Get.put<IShowBottomSheetHelper>(
      ShowBottomSheetHelperImpl(),
      permanent: true,
    );
    Get.put<IConnectivityChecker>(
      ConnectivityCheckerImpl(),
    );
    Get.put<WebServiceConnections>(
      WebServiceConnections(
        Get.find<Dio>(),
        Get.find<Storage>(),
        Get.find(),
      ),
      permanent: true,
    );
    // Get.put<IShowDialogHelper>(
    //   ShowDialogHelperImpl(),
    //   permanent: true,
    // // );
    // Get.put<IShowBottomSheetHelper>(
    //   ShowBottomSheetHelperImpl(),
    //   permanent: true,
    // );

    // Get.put<IShowSnakBar>(
    //   ShowSnakBarImpl(),
    //   permanent: true,
    // );
    Get.put<IImagePicker>(
      ImagePickerImpl(),
      permanent: true,
    );
    Get.lazyPut(() => SplashController(Get.find()));
  }
}
