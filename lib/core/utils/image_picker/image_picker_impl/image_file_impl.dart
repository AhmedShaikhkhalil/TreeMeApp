import 'dart:typed_data';

import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:treeme/core/utils/image_picker/i_image_file.dart';

class ImageFileImpl extends IImageFile {
  ImageFileImpl(this._file);
  final image_picker.XFile _file;
  @override
  Future<Uint8List> readAsBytes() {
    return _file.readAsBytes();
  }

  @override
  String get path => _file.path;
  @override
  String get name => _file.name;
}
