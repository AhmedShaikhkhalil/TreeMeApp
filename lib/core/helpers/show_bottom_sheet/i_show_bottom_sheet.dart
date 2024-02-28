import 'show_bottom_sheet_input.dart';

abstract class IShowBottomSheetHelper {
  Future<T?> showBottomSheet<T>(ShowBottomSheetInput input);
}
