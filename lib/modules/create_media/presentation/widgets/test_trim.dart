// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// const _touchMargin = 24.0;
//
// class TrimSliderText extends StatefulWidget {
//   final Widget child;
//   final double minTrimDuration;
//   late double end;
//   late double start;
//   final Function(double start, double end) onTrimUpdate;
//
//   TrimSliderText({
//     super.key,
//     required this.child,
//     required this.minTrimDuration,
//     required this.onTrimUpdate,
//     required this.end,
//     required this.start,
//   });
//
//   @override
//   _TrimSliderTextState createState() => _TrimSliderTextState();
// }
//
// class _TrimSliderTextState extends State<TrimSliderText> {
//   TrimStyle trimStyle = TrimStyle();
//   final double _horizontalMargin = 16.0;
//   Rect _rect = Rect.zero;
//   Size _trimLayout = Size.zero;
//   Size _fullLayout = Size.zero;
//   double _start = 0.0;
//   double _end = 1.0;
//   late final double _edgesTouchMargin = max(0, _touchMargin);
//   _TrimBoundaries _boundary = _TrimBoundaries.start;
//
//   @override
//   void initState() {
//     super.initState();
//     _end = widget.end;
//     _start = widget.start;
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       _start = widget.start;
//       _end = widget.end;
//     });
//   }
//
//   //
//   // void _onHorizontalDragStart(DragStartDetails details) {
//   //   final pos = details.localPosition;
//   //   final progressTrim = _getVideoPosition();
//   //
//   //   // Left, right and video progress indicator touch areas
//   //   Rect leftTouch = Rect.fromCenter(
//   //     center: Offset(_rect.left - _edgesTouchMargin / 2, _rect.height / 2),
//   //     width: _edgesTouchMargin,
//   //     height: _rect.height,
//   //   );
//   //   Rect rightTouch = Rect.fromCenter(
//   //     center: Offset(_rect.right + _edgesTouchMargin / 2, _rect.height / 2),
//   //     width: _edgesTouchMargin,
//   //     height: _rect.height,
//   //   );
//   //   final progressTouch = Rect.fromCenter(
//   //     center: Offset(progressTrim, _rect.height / 2),
//   //     width: _positionTouchMargin,
//   //     height: _rect.height,
//   //   );
//   //
//   //   // if the scroll view is touched, it will be by default an inside gesture
//   //   _boundary = _TrimBoundaries.inside;
//   //
//   //   /// boundary should not be set to other that inside when scroll controller is moving
//   //   /// it would lead to weird behavior to change position while scrolling
//   //   if (isNotScrollBouncingBack &&
//   //       !_scrollController.position.isScrollingNotifier.value) {
//   //     if (progressTouch.contains(pos)) {
//   //       // video indicator should have the higher priority since it does not affect the trim param
//   //       _boundary = _TrimBoundaries.progress;
//   //     } else {
//   //       // if video indicator is not touched, expand [leftTouch] and [rightTouch] on the inside
//   //       leftTouch = leftTouch.expandToInclude(
//   //           Rect.fromLTWH(_rect.left, 0, _edgesTouchMargin, 1));
//   //       rightTouch = rightTouch.expandToInclude(Rect.fromLTWH(
//   //           _rect.right - _edgesTouchMargin, 0, _edgesTouchMargin, 1));
//   //     }
//   //
//   //     if (leftTouch.contains(pos)) {
//   //       _boundary = _TrimBoundaries.left;
//   //     } else if (rightTouch.contains(pos)) {
//   //       _boundary = _TrimBoundaries.right;
//   //     }
//   //   }
//   //
//   //   _updateControllerIsTrimming(true);
//   // }
//
//   /// Executed when the user starts the gesture
//   void _startGesture(DragStartDetails details) {
//     final position = details.localPosition.dx + _horizontalMargin;
//
//     final startBoundary = _rect.left - _horizontalMargin;
//     final endBoundary = _rect.right - _horizontalMargin;
//
//     if (position >= startBoundary && position <= endBoundary) {
//       final startDiff =
//           (_start * (_fullLayout.width - 2 * _horizontalMargin)) - position;
//       final endDiff =
//           (_end * (_fullLayout.width - 2 * _horizontalMargin)) - position;
//
//       if (startDiff.abs() < endDiff.abs()) {
//         _boundary = _TrimBoundaries.start;
//       } else {
//         _boundary = _TrimBoundaries.end;
//       }
//     } else {
//       _boundary = _TrimBoundaries.progress;
//     }
//
//     widget.onTrimUpdate(_start, _end);
//   }
//
//   /// Executed when the user moves the gesture
//   void _moveGesture(DragUpdateDetails details) {
//     final position = details.localPosition.dx + _horizontalMargin;
//
//     // Trim start move
//     if (_boundary == _TrimBoundaries.start) {
//       final endPosition = _rect.right - _horizontalMargin;
//       print(_rect.right.toString());
//       final newStart = max(_rect.left - _horizontalMargin,
//           min(position, _end * (_fullLayout.width - 2 * _horizontalMargin)));
//       final minWidth =
//           widget.minTrimDuration * (_fullLayout.width - 2 * _horizontalMargin);
//
//       if (newStart + minWidth < endPosition) {
//         setState(() {
//           _start = newStart / (_fullLayout.width - 2 * _horizontalMargin);
//         });
//       }
//     }
//     // Trim end move
//     else if (_boundary == _TrimBoundaries.end) {
//       final startPosition = _rect.left - _horizontalMargin;
//       final newEnd = max(
//           startPosition, min(_fullLayout.width, position + _horizontalMargin));
//       final minWidth =
//           widget.minTrimDuration * (_fullLayout.width - 2 * _horizontalMargin);
//
//       if (startPosition + minWidth < newEnd) {
//         setState(() {
//           _end = newEnd / (_fullLayout.width - 2 * _horizontalMargin);
//         });
//       }
//     }
//     // Progress line move
//     else if (_boundary == _TrimBoundaries.progress) {
//       final rectLeft = _rect.left - _horizontalMargin;
//       final rectRight = _rect.right - _horizontalMargin;
//
//       final newStart =
//           max(rectLeft, min(rectRight, position - 0.5 * _trimLayout.width));
//       final newEnd =
//           max(rectLeft, min(rectRight, position + 0.5 * _trimLayout.width));
//
//       if (newStart < newEnd) {
//         setState(() {
//           _start = newStart / (_fullLayout.width - 2 * _horizontalMargin);
//           _end = newEnd / (_fullLayout.width - 2 * _horizontalMargin);
//         });
//       }
//     }
//
//     widget.onTrimUpdate(_start, _end);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: Get.width * 0.6,
//       height: 50,
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           _rect = Offset.zero & constraints.biggest;
//           _fullLayout =
//               Size(constraints.biggest.width, constraints.biggest.height);
//           _trimLayout = Size(_rect.width * (_end - _start), _rect.height);
//
//           return GestureDetector(
//             onHorizontalDragStart: _startGesture,
//             onHorizontalDragUpdate: _moveGesture,
//             child: Stack(
//               children: [
//                 // Positioned(
//                 //   width: _trimLayout.width,
//                 //   height: _trimLayout.height,
//                 //   left: _rect.left +
//                 //       _horizontalMargin +
//                 //       (_rect.width - _trimLayout.width) * _start,
//                 //   top: _rect.top,
//                 //
//                 // ),
//                 Container(
//                   margin: EdgeInsetsDirectional.only(end: 15),
//                   child: widget.child,
//                 ),
//                 Positioned(
//                   left: _rect.left +
//                       _horizontalMargin +
//                       (_rect.width - _trimLayout.width) * _start,
//                   top: _rect.top,
//                   width: _trimLayout.width,
//                   height: _trimLayout.height,
//                   child: CustomPaint(
//                     painter: TrimSliderTextPainter(
//                       rect: _rect,
//                       trimLayout: _trimLayout,
//                       fullLayout: _fullLayout,
//                       trimStyle:
//                           TrimStyle(), // Provide your own TrimStyle implementation
//                       horizontalMargin: _horizontalMargin,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// enum _TrimBoundaries { start, end, progress }
//
// class TrimStyle {
//   final Color fullProgressColor;
//   final double fullProgressLineWidth;
//   final Color trimProgressColor;
//   final double trimProgressLineWidth;
//   final Color edgeColor;
//   final Color positionLineColor;
//   final double positionLineWidth;
//
//   TrimStyle({
//     this.fullProgressColor = Colors.grey,
//     this.fullProgressLineWidth = 2.0,
//     this.trimProgressColor = Colors.blue,
//     this.trimProgressLineWidth = 4.0,
//     this.edgeColor = Colors.white,
//     this.positionLineColor = Colors.white,
//     this.positionLineWidth = 2.0,
//   });
// }
//
// class TrimSliderTextPainter extends CustomPainter {
//   final Rect rect;
//   final Size trimLayout;
//   final Size fullLayout;
//   final TrimStyle trimStyle;
//   final double horizontalMargin;
//
//   TrimSliderTextPainter({
//     required this.rect,
//     required this.trimLayout,
//     required this.fullLayout,
//     required this.trimStyle,
//     required this.horizontalMargin,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Draw the full progress line
//     final fullProgressLineRect = Offset(rect.left, rect.top) &
//         Size(fullLayout.width, trimStyle.fullProgressLineWidth);
//     final fullProgressLinePaint = Paint()
//       ..color = trimStyle.fullProgressColor
//       ..strokeWidth = trimStyle.fullProgressLineWidth;
//     // canvas.drawRect(fullProgressLineRect, fullProgressLinePaint);
//
//     // Draw the trim progress line
//     final trimProgressLineRect = Offset(rect.left, rect.top) &
//         Size(trimLayout.width, trimStyle.trimProgressLineWidth);
//     final trimProgressLinePaint = Paint()
//       ..color = trimStyle.trimProgressColor
//       ..strokeWidth = trimStyle.trimProgressLineWidth;
//     canvas.drawRect(trimProgressLineRect, trimProgressLinePaint);
//
//     // Draw the edges
//     final leftEdgeRect = Offset(rect.left - horizontalMargin, rect.top) &
//         Size(horizontalMargin, rect.height);
//     final rightEdgeRect =
//         Offset(rect.right, rect.top) & Size(horizontalMargin, rect.height);
//     final edgePaint = Paint()..color = trimStyle.edgeColor;
//     canvas.drawRect(leftEdgeRect, edgePaint);
//     // canvas.drawRect(rightEdgeRect, edgePaint);
//
//     // Draw the position line
//     final positionLineRect = Offset(
//             rect.left + trimLayout.width - trimStyle.positionLineWidth * 0.5,
//             rect.top) &
//         Size(trimStyle.positionLineWidth, rect.height);
//     final positionLinePaint = Paint()
//       ..color = trimStyle.positionLineColor
//       ..strokeWidth = trimStyle.positionLineWidth;
//     canvas.drawRect(positionLineRect, positionLinePaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
