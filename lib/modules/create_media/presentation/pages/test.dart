// import 'package:flutter/material.dart';
//
// class TrimSliderPainter extends CustomPainter {
//   final double thumbRadius;
//   final double lowerValue;
//   final double upperValue;
//   final Color color;
//   final Function(double, double)? onChanged;
//
//   TrimSliderPainter({
//     required this.thumbRadius,
//     required this.lowerValue,
//     required this.upperValue,
//     required this.color,
//     this.onChanged,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double width = size.width;
//     final double height = size.height;
//     final double thumbHeight = height * 0.8;
//     final double thumbY = height * 0.1;
//
//     final Paint backgroundPaint = Paint()
//       ..color = color.withOpacity(0.3)
//       ..style = PaintingStyle.fill;
//
//     final Paint thumbPaint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//
//     // Draw background
//     final backgroundRect =
//         Rect.fromLTRB(0, thumbY, width, thumbY + thumbHeight);
//     canvas.drawRect(backgroundRect, backgroundPaint);
//
//     // Draw thumbs
//     final double lowerThumbX = lowerValue * width - thumbRadius;
//     final double upperThumbX = upperValue * width - thumbRadius;
//
//     final lowerThumbRect = Rect.fromLTRB(lowerThumbX, thumbY,
//         lowerThumbX + thumbRadius * 2, thumbY + thumbHeight);
//     canvas.drawRRect(
//         RRect.fromRectAndRadius(lowerThumbRect, Radius.circular(thumbRadius)),
//         thumbPaint);
//
//     final upperThumbRect = Rect.fromLTRB(upperThumbX, thumbY,
//         upperThumbX + thumbRadius * 2, thumbY + thumbHeight);
//     canvas.drawRRect(
//         RRect.fromRectAndRadius(upperThumbRect, Radius.circular(thumbRadius)),
//         thumbPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     if (oldDelegate is TrimSliderPainter) {
//       return oldDelegate.lowerValue != lowerValue ||
//           oldDelegate.upperValue != upperValue ||
//           oldDelegate.color != color;
//     }
//     return false;
//   }
//
//   @override
//   bool hitTest(Offset position) {
//     return true;
//   }
//
//   @override
//   PointerMoveEventListener? getPointerMoveEventListener() {
//     return (event) {
//       final dx = event.localPosition.dx;
//       final width = event.localPosition.direction;
//       final range = upperValue - lowerValue;
//       final minRange = thumbRadius * 2 / width;
//
//       double newLowerValue = lowerValue;
//       double newUpperValue = upperValue;
//
//       if (dx < width * lowerValue) {
//         newLowerValue = dx / width;
//         if (newUpperValue - newLowerValue < minRange) {
//           newUpperValue = newLowerValue + minRange;
//         }
//       } else if (dx > width * upperValue) {
//         newUpperValue = dx / width;
//         if (newUpperValue - newLowerValue < minRange) {
//           newLowerValue = newUpperValue - minRange;
//         }
//       } else {
//         final distanceToLeftThumb = dx - width * lowerValue;
//         final distanceToRightThumb = width * upperValue - dx;
//
//         if (distanceToLeftThumb < distanceToRightThumb) {
//           newLowerValue = dx / width;
//           if (newUpperValue - newLowerValue < minRange) {
//             newUpperValue = newLowerValue + minRange;
//           }
//         } else {
//           newUpperValue = dx / width;
//           if (newUpperValue - newLowerValue < minRange) {
//             newLowerValue = newUpperValue - minRange;
//           }
//         }
//       }
//
//       if (onChanged != null) {
//         onChanged!(newLowerValue, newUpperValue);
//       }
//     };
//   }
// }
//
// class CapCutEditor extends StatefulWidget {
//   @override
//   _CapCutEditorState createState() => _CapCutEditorState();
// }
//
// class _CapCutEditorState extends State<CapCutEditor> {
//   double lowerValue = 0.2;
//   double upperValue = 0.8;
//
//   void updateValues(double lower, double upper) {
//     setState(() {
//       lowerValue = lower;
//       upperValue = upper;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CapCut Editor'),
//       ),
//       body: Column(
//         children: [
//           AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             height: 100,
//             width: double.infinity,
//             child: GestureDetector(
//               onHorizontalDragStart: (details) {
//                 final dx = details.localPosition.dx;
//                 final width = context.size!.width;
//                 final newLowerValue = (dx / width).clamp(0.0, upperValue);
//                 final newUpperValue = (dx / width).clamp(lowerValue, 1.0);
//                 if (newUpperValue - newLowerValue >= 12 * 2 / width) {
//                   setState(() {
//                     lowerValue = newLowerValue;
//                     upperValue = newUpperValue;
//                   });
//                 }
//               },
//               child: CustomPaint(
//                 painter: TrimSliderPainter(
//                   thumbRadius: 12,
//                   lowerValue: lowerValue,
//                   upperValue: upperValue,
//                   color: Colors.blue,
//                   onChanged: updateValues,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Lower Value: $lowerValue',
//           ),
//           Text('Upper Value: $upperValue'),
//         ],
//       ),
//     );
//   }
// }
