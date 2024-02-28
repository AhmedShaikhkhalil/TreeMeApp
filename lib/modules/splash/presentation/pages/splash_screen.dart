import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:treeme/core/resources/assets_manager.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/resources/values_manager.dart';

import '../manager/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (logic) {
      return Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                  ColorManager.mainColor,
                  ColorManager.gradiantSplash
                ],
                    tileMode: TileMode.mirror,
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft)),
          ),
          AnimatedBuilder(
            animation: logic.shakeAnimation,
            builder: (context, Widget? child) {
              return Transform.translate(
                offset: Offset(logic.shakeAnimation.value,
                    0.0), // Apply the animation value to the X-axis
                child: child,
              );
            },
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 116.w,
                height: 116.h,
                padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s12.w, vertical: AppSize.s8.h),
                decoration: BoxDecoration(
                    color: ColorManager.white.withOpacity(1),
                    // gradient: LinearGradient(
                    //     colors: [
                    //       ColorManager.white.withOpacity(1),
                    //       ColorManager.white.withOpacity(0.53)
                    //     ],
                    //     tileMode: TileMode.mirror,
                    //     begin: Alignment.topCenter,
                    //     end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(AppSize.s33.r)),
                child: SvgPicture.asset(
                  ImageAssets.splashLogo,
                  width: AppSize.s58.w,
                  height: AppSize.s77.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
              top: AppSize.s27.h,
              right: AppSize.s11.w,
              child: Image.asset(ImageAssets.hotAirBallon)),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(ImageAssets.fireworks),
          )
        ],
      );
    });
  }
}
