import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:treeme/core/resources/assets_manager.dart';
import 'package:treeme/core/resources/font_manager.dart';
import 'package:treeme/core/resources/strings_manager.dart';
import 'package:treeme/core/resources/styles_manager.dart';
import 'package:treeme/core/resources/values_manager.dart';
import 'package:treeme/core/routes/app_routes.dart';

import '../../../../core/resources/color_manager.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                  ColorManager.mainColor,
                  ColorManager.gradiantSplash
                ],
                    tileMode: TileMode.mirror,
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft)),
          ),
          Container(
            margin: EdgeInsets.only(
                top: AppSize.s40.h, right: AppSize.s37.w, left: AppSize.s37.w),
            height: AppSize.s318.h,
            width: AppSize.s318.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: ColorManager.borderCircle.withOpacity(0.3),
                  width: AppSize.s50.w,
                  style: BorderStyle.solid,
                  strokeAlign: BorderSide.strokeAlignInside),
              color: Colors.transparent,
            ),
          ),
          Positioned(
              top: AppSize.s27.h,
              right: AppSize.s11.w,
              child: Image.asset(ImageAssets.hotAirBallon)),
          Positioned(
              top: AppSize.s130.h,
              child: Image.asset(
                ImageAssets.balloons,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 400,
              // padding: EdgeInsets.symmetric(horizontal: AppSize.s37.w),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(145, 35),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSize.s30.h,
                  ),
                  SizedBox(
                    height: AppSize.s10.h,
                    child: ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: AppSize.s9.h,
                            width: AppSize.s9.w,
                            margin: EdgeInsets.symmetric(
                                horizontal: AppSize.s2_5.w),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == 1
                                    ? Colors.blue
                                    : Color(0xFFD9D9D9)),
                          );
                        }),
                  ),
                  SizedBox(
                    height: AppSize.s39.h,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: AppStrings.onBoardingTitle,
                            style: getBoldStyle(
                                color: ColorManager.textFontColor,
                                fontSize: FontSize.s36.sp),
                            children: [
                              WidgetSpan(
                                  child: Lottie.network(
                                      'https://fonts.gstatic.com/s/e/notoemoji/latest/1f973/lottie.json',
                                      height: AppSize.s50.h,
                                      width: AppSize.s50.w))
                            ])
                      ])),
                  SizedBox(
                    height: AppSize.s30.h,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: AppStrings.onBoardingLabel,
                            style: getMediumStyle(
                                color: ColorManager.textFont1Color,
                                fontSize: FontSize.s16.sp),
                            children: [
                              WidgetSpan(
                                  child: Lottie.network(
                                      'https://fonts.gstatic.com/s/e/notoemoji/latest/1f609/lottie.json',
                                      height: AppSize.s20.h,
                                      width: AppSize.s20.w))
                            ])
                      ])),
                  SizedBox(
                    height: AppSize.s57.h,
                  ),
                  FloatingActionButton(
                    onPressed: () => Get.toNamed(AppRoutes.login),
                    child: Container(
                      width: AppSize.s80.w,
                      height: AppSize.s80.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: ColorManager.shadowButton,
                                offset: Offset(0, 24.h),
                                blurRadius: 24)
                          ],
                          gradient: ColorManager().gradientFloating),
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: AppSize.s0.w,
              // bottom: 369,
              top: MediaQuery.of(context).size.height / 2.5,
              child: Image.asset(
                ImageAssets.calender,
              )),
        ],
      ),
    );
  }
}
