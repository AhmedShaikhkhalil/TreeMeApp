import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';

class OptionAuthWidget extends StatelessWidget {
  const OptionAuthWidget({
    super.key,
    required this.icon,
  });
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s50.h,
      width: AppSize.s50.w,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: ColorManager.white,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        icon,
        height: AppSize.s20.h,
        width: AppSize.s20.w,
      ),
    );
  }
}
