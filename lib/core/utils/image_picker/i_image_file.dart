import 'dart:typed_data';

abstract class IImageFile {
  Future<Uint8List> readAsBytes();
  String get path;
  String get name;
}
