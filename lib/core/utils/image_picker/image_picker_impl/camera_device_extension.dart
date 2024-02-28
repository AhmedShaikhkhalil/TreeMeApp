import 'package:image_picker/image_picker.dart' as image_picker;

import '../image_picker.dart';

extension CameraDeviceToImagePickerCameraDevice on CameraDevice {
  image_picker.CameraDevice toImagePickerCameraDevice() {
    switch (this) {
      case CameraDevice.front:
        return image_picker.CameraDevice.front;
      case CameraDevice.rear:
        return image_picker.CameraDevice.rear;
    }
  }
}
