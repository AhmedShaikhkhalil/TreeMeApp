import 'dart:ui';

class ImageOverly {
  int id;
  String? selectedImage;
  double imagePositionX = 0.0;
  double imagePositionY = 0.0;
  double imageScale = 1.0;
  double startRange = 10;
  double endRange = 50;
  Offset position = const Offset(0, 0);
  double scale = 1;
  Size size;
  bool isSelected = false;

  ImageOverly(this.selectedImage, this.imagePositionX, this.imagePositionY,
      this.imageScale, this.position, this.scale, this.isSelected, this.id,
      {this.size = const Size(100, 100)});
}
