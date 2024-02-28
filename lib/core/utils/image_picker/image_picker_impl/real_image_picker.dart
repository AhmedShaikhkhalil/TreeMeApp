import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:treeme/core/utils/image_picker/i_image_file.dart';
import 'package:treeme/core/utils/image_picker/i_image_picker.dart';
import 'package:treeme/core/utils/image_picker/image_picker_input.dart';

import 'camera_device_extension.dart';
import 'image_file_impl.dart';
import 'image_source_extension.dart';

class ImagePickerImpl extends IImagePicker {
  final image_picker.ImagePicker picker = image_picker.ImagePicker();

  @override
  Future<IImageFile?> pickImage({ImagePickerInput? input}) async {
    final image_picker.XFile? result = await picker.pickImage(
      source: input?.source?.toImagePickerImageSource() ??
          image_picker.ImageSource.camera,
      maxWidth: input?.maxWidth,
      maxHeight: input?.maxHeight,
      imageQuality: input?.quality,
      preferredCameraDevice:
          input?.preferredCameraDevice?.toImagePickerCameraDevice() ??
              image_picker.CameraDevice.rear,
    );
    if (result == null) {
      return null;
    }
    return ImageFileImpl(result);
  }
}
