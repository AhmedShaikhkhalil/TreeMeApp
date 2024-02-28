import 'image_picker.dart';

abstract class IImagePicker {
  Future<IImageFile?> pickImage({ImagePickerInput? input});
}
