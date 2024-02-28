import 'dart:ui';

class TextOverlay {
  String? id;
  String text;
  double fontSize;
  double? scaleFactor;
  Color textColor;
  String fontFamily;
  bool isSelected;
  Offset? position = const Offset(0.0, 0);
  double? startTime;
  double? endTime;
  TextOverlay(
      {required this.text,
      required this.fontSize,
      required this.textColor,
      required this.fontFamily,
      this.isSelected = false,
      this.id,
      this.position});
}
