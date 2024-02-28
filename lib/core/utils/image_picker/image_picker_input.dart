import 'package:equatable/equatable.dart';
import 'image_picker.dart';

class ImagePickerInput extends Equatable {
  const ImagePickerInput({
    this.source,
    this.quality,
    this.maxHeight,
    this.maxWidth,
    this.preferredCameraDevice,
  });

  final ImageSource? source;
  final int? quality;
  final double? maxWidth;
  final double? maxHeight;
  final CameraDevice? preferredCameraDevice;

  @override
  List<Object?> get props => <Object?>[
        source,
        quality,
        maxWidth,
        maxHeight,
        preferredCameraDevice,
      ];
}
