import 'dart:ui';

class ImageOverly {
  String? id;
  String? selectedImage;
  double imagePositionX = 0.0;
  double imagePositionY = 0.0;
  double imageScale = 1.0;
  double startRange = 10;
  double endRange = 50;
  Offset position = Offset(0, 0);
  double scale = 1;
  bool isSelected = false;

  ImageOverly(this.selectedImage, this.imagePositionX, this.imagePositionY,
      this.imageScale, this.position, this.scale, this.isSelected, this.id);
}
