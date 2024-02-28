import 'package:get/get.dart';
import 'i_show_bottom_sheet.dart';
import 'show_bottom_sheet_input.dart';

class ShowBottomSheetHelperImpl implements IShowBottomSheetHelper {
  @override
  Future<T?> showBottomSheet<T>(ShowBottomSheetInput input) {
    return Get.bottomSheet(
      input.bottomsheet,
      backgroundColor: input.backgroundColor,
      elevation: input.elevation,
      persistent: input.persistent,
      shape: input.shape,
      clipBehavior: input.clipBehavior,
      barrierColor: input.barrierColor,
      ignoreSafeArea: input.ignoreSafeArea,
      isScrollControlled: input.isScrollControlled,
      useRootNavigator: input.useRootNavigator,
      isDismissible: input.isDismissible,
      enableDrag: input.enableDrag,
      settings: input.settings,
      enterBottomSheetDuration: input.enterBottomSheetDuration,
      exitBottomSheetDuration: input.exitBottomSheetDuration,
    );
  }
}
