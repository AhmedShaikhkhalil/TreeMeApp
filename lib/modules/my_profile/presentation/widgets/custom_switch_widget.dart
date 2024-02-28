import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/resources/values_manager.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomSwitch({required this.value, required this.onChanged});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        widget.onChanged(_value);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: AppSize.s54.w,
        height: AppSize.s32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s16.r),
          gradient: LinearGradient(
            colors: _value ? [ColorManager.gradiantSplash, ColorManager.mainColor] : [Colors.grey, Colors.white],
            begin: Alignment.topLeft,
              end: Alignment.bottomRight
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: _value ? 20 : 0,
              right: _value ? 0 : 20,
              child: Container(
                width: AppSize.s26.w,
                height: AppSize.s26.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  gradient: LinearGradient(colors: [
                    ColorManager.white,

                    ColorManager.white.withOpacity(0.44),
                  ],begin: Alignment.topLeft,
                    end: Alignment.bottomRight,)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
