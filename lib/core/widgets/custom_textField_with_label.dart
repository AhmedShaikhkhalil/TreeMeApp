import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class CustomTextFieldWithLabel extends StatelessWidget {
  const CustomTextFieldWithLabel(
      {super.key,
      required this.label,
      required this.hint,
      this.suffix,
      this.labelStyle,
      this.controller,
      this.keyboardType,
      this.obscureText = false,
      this.validator});
  final String label;
  final String hint;
  final Widget? suffix;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextStyle? labelStyle;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ??
              getRegularStyle(
                  color: ColorManager.black, fontSize: FontSize.s14.sp),
        ),
        SizedBox(
          height: AppSize.s8.h,
        ),
        TextFormField(
          keyboardType: keyboardType,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s10.r),
                  borderSide: BorderSide.none),
              contentPadding: EdgeInsets.only(
                  left: AppSize.s16.w,
                  top: AppSize.s18.h,
                  right: AppSize.s12.w,
                  bottom: AppSize.s18.h),
              fillColor: ColorManager.white,
              hintStyle: getRegularStyle(
                  color: ColorManager.hintColor, fontSize: FontSize.s16.sp),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s10.r),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s10.r),
                  borderSide: BorderSide.none),
              // suffix: suffix,
              suffixIcon: suffix,
              hintText: hint),
        ),
      ],
    );
  }
}
