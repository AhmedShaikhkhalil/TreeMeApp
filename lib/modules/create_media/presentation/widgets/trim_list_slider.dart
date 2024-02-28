// import 'package:flutter/material.dart';
//
// class TrimSliderList extends StatefulWidget {
//   final List<Widget> children;
//   final double minTrimDuration;
//   final Function(double start, double end) onTrimUpdate;
//
//   TrimSliderList({
//     super.key,
//     required this.children,
//     required this.minTrimDuration,
//     required this.onTrimUpdate,
//   });
//
//   @override
//   _TrimSliderListState createState() => _TrimSliderListState();
// }
//
// class _TrimSliderListState extends State<TrimSliderList> {
//   final double _horizontalMargin = 16.0;
//   Rect _rect = Rect.zero;
//   List<Size> _trimLayouts = [];
//   Size _fullLayout = Size.zero;
//   List<double> _starts = [];
//   List<double> _ends = [];
//   _TrimBoundaries _boundary = _TrimBoundaries.start;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       _initializeTrimRanges();
//     });
//   }
//
//   void _initializeTrimRanges() {
//     final numChildren = widget.children.length;
//     _starts = List<double>.filled(numChildren, 0.0);
//     _ends = List<double>.filled(numChildren, 1.0);
//
//     for (int i = 0; i < numChildren; i++) {
//       _trimLayouts.add(Size.zero);
//     }
//
//     setState(() {});
//   }
//
//   /// Executed when the user starts the gesture
//   void _startGesture(DragStartDetails details) {
//     // implementation remains the same
//   }
//
//   /// Executed when the user moves the gesture
//   void _moveGesture(DragUpdateDetails details) {
//     // implementation remains the same
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         _rect = Offset.zero & constraints.biggest;
//         _fullLayout =
//             Size(constraints.biggest.width, constraints.biggest.height);
//
//         return GestureDetector(
//           onHorizontalDragStart: _startGesture,
//           onHorizontalDragUpdate: _moveGesture,
//           child: Stack(
//             children: [
//               for (int i = 0; i < widget.children.length; i++)
//                 Positioned(
//                   left: _rect.left +
//                       _horizontalMargin +
//                       (_rect.width - _trimLayouts[i].width) * _starts[i],
//                   top: _rect.top,
//                   width: _trimLayouts[i].width,
//                   height: _trimLayouts[i].height,
//                   child: CustomPaint(
//                     painter: _TrimSliderTextPainter(
//                       rect: _rect,
//                       trimLayout: _trimLayouts[i],
//                       fullLayout: _fullLayout,
//                       trimStyle:
//                           TrimStyle(), // Provide your own TrimStyle implementation
//                       horizontalMargin: _horizontalMargin,
//                     ),
//                     child: widget.children[i],
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _TrimSliderTextPainter extends CustomPainter {
//   final Rect rect;
//   final Size trimLayout;
//   final Size fullLayout;
//   final TrimStyle trimStyle;
//   final double horizontalMargin;
//
//   _TrimSliderTextPainter({
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
//     canvas.drawRect(fullProgressLineRect, fullProgressLinePaint);
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
//     canvas.drawRect(rightEdgeRect, edgePaint);
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
