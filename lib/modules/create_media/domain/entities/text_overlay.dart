import 'dart:ui';

class TextOverlay {
  int? id;
  String text;
  double fontSize;
  double? scaleFactor;
  Color textColor;
  String fontFamily;
  bool isSelected;
  Offset? position = const Offset(0.0, 0);
  double startTime = 0;
  double endTime = 10;
  Size? size;
  TextOverlay(
      {required this.text,
      required this.fontSize,
      required this.textColor,
      required this.fontFamily,
      this.isSelected = false,
      this.id,
      this.size,
      this.position});
}
