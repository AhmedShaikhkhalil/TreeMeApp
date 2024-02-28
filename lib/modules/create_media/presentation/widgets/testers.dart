// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_editor/domain/entities/trim_style.dart';
// import 'package:video_editor/ui/trim/trim_slider_painter.dart';
//
// class TrimWidget extends StatefulWidget {
//   final Widget child;
//
//   const TrimWidget({required this.child});
//
//   @override
//   _TrimWidgetState createState() => _TrimWidgetState();
// }
//
// class _TrimWidgetState extends State<TrimWidget> {
//   double _trimStart = 0.2;
//   double _trimEnd = 0.8;
//   Rect? _rect;
//   _TrimBoundaries? _boundary;
//   double? _preComputedVideoPosition;
//   bool _isTrimStart = false;
//   bool _isTrimEnd = false;
//   bool _isTrimInside = false;
//   final double _touchMargin = 8;
//   final double _horizontalMargin = 16;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanStart: _onPanStart,
//       onPanUpdate: _onPanUpdate,
//       onPanEnd: _onPanEnd,
//       child: Container(
//         // color: Colors.grey[200],
//         child: Stack(
//           children: [
//             widget.child,
//             CustomPaint(
//               painter: TrimSliderPainter(
//                 _rect!,
//                 isTrimming: true,
//                 isTrimmed: true,
//                 2.1,
//                 TrimSliderStyle(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _onPanStart(DragStartDetails details) {
//     final double x = details.localPosition.dx;
//     final double y = details.localPosition.dy;
//
//     _rect = Rect.fromLTWH(
//         _horizontalMargin, 0, context.size!.width - 2 * _horizontalMargin, 100);
//
//     if (_rect!.inflate(_touchMargin).contains(Offset(x, y))) {
//       _boundary = _getTrimBoundary(x);
//       if (_boundary != null) {
//         _preComputedVideoPosition =
//             0.0; // Replace with your video position logic
//         if (true) {
//           // Replace with your haptic feedback check
//           HapticFeedback.mediumImpact();
//         }
//       }
//     }
//   }
//
//   void _onPanUpdate(DragUpdateDetails details) {
//     if (_boundary != null) {
//       final double delta = details.delta.dx / _rect!.width;
//       final double start = _trimStart;
//       final double end = _trimEnd;
//
//       if (_isTrimStart) {
//         final double newStart = (start + delta)
//             .clamp(0, _trimEnd - 1 / 100); // Replace 100 with your max duration
//         setState(() {
//           _trimStart = newStart;
//         });
//       } else if (_isTrimEnd) {
//         final double newEnd = (end + delta).clamp(
//             _trimStart + 1 / 100, 1); // Replace 100 with your max duration
//         setState(() {
//           _trimEnd = newEnd;
//         });
//       } else if (_isTrimInside) {
//         final double newStart =
//             (start + delta).clamp(0, 1 - (_trimEnd - _trimStart));
//         final double newEnd = (end + delta).clamp(_trimEnd - _trimStart, 1);
//         setState(() {
//           _trimStart = newStart;
//           _trimEnd = newEnd;
//         });
//       }
//     }
//   }
//
//   void _onPanEnd(DragEndDetails details) {
//     if (_boundary != null) {
//       _boundary = null;
//       _preComputedVideoPosition = null;
//       // Handle seek logic here
//     }
//   }
//
//   _TrimBoundaries? _getTrimBoundary(double x) {
//     if (x <= _rect!.left) {
//       _isTrimStart = true;
//       _isTrimEnd = false;
//       _isTrimInside = false;
//       return _TrimBoundaries.left;
//     } else if (x >= _rect!.right) {
//       _isTrimStart = false;
//       _isTrimEnd = true;
//       _isTrimInside = false;
//       return _TrimBoundaries.right;
//     } else if (_rect!
//         .inflate(-_touchMargin)
//         .contains(Offset(x, _rect!.center.dy))) {
//       _isTrimStart = false;
//       _isTrimEnd = false;
//       _isTrimInside = true;
//       return _TrimBoundaries.inside;
//     } else {
//       return null;
//     }
//   }
// }
//
// enum _TrimBoundaries { left, right, inside }
