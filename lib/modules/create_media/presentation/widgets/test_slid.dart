// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_core/theme.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
//
// class WidthRangeSliderScreen extends StatefulWidget {
//   final SfRangeValues values;
//
//   WidthRangeSliderScreen({super.key, required this.values});
//   @override
//   _WidthRangeSliderScreenState createState() => _WidthRangeSliderScreenState();
// }
//
// class _WidthRangeSliderScreenState extends State<WidthRangeSliderScreen>
//     with SingleTickerProviderStateMixin {
//   SfRangeValues _values = SfRangeValues(50, 100);
//   double _sliderWidth = 200;
//
//   late AnimationController _animationController;
//   late Animation<double> _widthAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _values = widget.values;
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 200), // Adjust the duration as needed
//     );
//     _widthAnimation = Tween<double>(
//       begin: _sliderWidth,
//       end: _sliderWidth,
//     ).animate(_animationController);
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   void _updateSelectedRange(SfRangeValues newValues) {
//     setState(() {
//       _values = newValues;
//       _updateSliderWidth();
//     });
//   }
//
//   void _updateSliderWidth() {
//     double rangeWidth = _values.end - _values.start;
//     _widthAnimation = Tween<double>(
//       begin: _widthAnimation.value,
//       end: rangeWidth, // Adjust the factor as needed
//     ).animate(_animationController);
//
//     _animationController.reset();
//     _animationController.forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double min = 0; // Minimum value of the range
//     double max = 200; // Maximum value of the range
//
//     if (_values.start < min) _values = SfRangeValues(min, _values.end);
//     if (_values.end > max) _values = SfRangeValues(_values.start, max);
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         AnimatedBuilder(
//           animation: _widthAnimation,
//           builder: (context, child) {
//             return Container(
//               width: _widthAnimation.value,
//               child: SfRangeSliderTheme(
//                 data: SfRangeSliderThemeData(
//                   inactiveTrackHeight: 40,
//                   activeTrackHeight: 40,
//                 ),
//                 child: SfRangeSlider(
//                   min: min,
//                   max: max,
//                   thumbShape: const SfThumbShape(),
//                   values: _values,
//                   onChanged: (SfRangeValues value) {
//                     _updateSelectedRange(value);
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
