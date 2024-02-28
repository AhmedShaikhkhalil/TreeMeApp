import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:treeme/core/utils/image_picker/image_source.dart';

extension ImageSourceToImagePickerImageSource on ImageSource {
  image_picker.ImageSource toImagePickerImageSource() {
    switch (this) {
      case ImageSource.camera:
        return image_picker.ImageSource.camera;
      case ImageSource.gallery:
        return image_picker.ImageSource.gallery;
    }
  }
}
