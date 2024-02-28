import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
class CustomElevatedButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const CustomElevatedButton({
    super.key, required this.title, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          gradient: ColorManager().gradientButton,
          boxShadow: [
            BoxShadow(
                color: ColorManager.mainColor.withOpacity(0.3),
                offset: const Offset(-0, 22),
                blurRadius: 6,
                spreadRadius: -12)
          ],
          borderRadius: BorderRadius.circular(AppSize.s16.r)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(AppSize.s16.r)),
            padding: EdgeInsets.zero,
            minimumSize: Size(double.infinity, 64.h)),
        onPressed: onPressed,
        child: Text(
          title,
          style: getBoldStyle(
              color: ColorManager.white,
              fontSize: FontSize.s16.sp),
        ),
      ),
    );
  }
}
