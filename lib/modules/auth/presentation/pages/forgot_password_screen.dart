import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:treeme/modules/auth/presentation/manager/forgot_password_controller.dart';

import '../../../../core/resources/resource.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.authBackGround,
      body: Container(
        color: ColorManager.authBackGround,
        padding: EdgeInsets.symmetric(horizontal: AppSize.s18.w),
        child: SafeArea(
          child: SingleChildScrollView(
            child: GetBuilder<ForgotPasswordController>(builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(ImageAssets.hotAirBallon),
                    ],
                  ),
                  Text(
                    AppStrings.titleForgotPassword,
                    style: getBoldStyle(
                        fontSize: FontSize.s20.sp,
                        decoration: TextDecoration.none,
                        color: const Color(0xffFEAA46)),
                  ),
                  SizedBox(
                    height: AppSize.s14.h,
                  ),
                  RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(
                            text: AppStrings.dontWorry,
                            style: getMediumStyle(
                                color: ColorManager.textFont1Color,
                                fontSize: FontSize.s16.sp),
                            children: [
                              WidgetSpan(
                                  child: Lottie.network(
                                      'https://fonts.gstatic.com/s/e/notoemoji/latest/1f609/lottie.json',
                                      height: AppSize.s20.h,
                                      width: AppSize.s20.w)),
                            ])
                      ])),
                  SizedBox(
                    height: AppSize.s53.h,
                  ),
                  Text(
                    AppStrings.phoneNumber,
                    style: getRegularStyle(
                        color: ColorManager.black, fontSize: FontSize.s14.sp),
                  ),
                  SizedBox(
                    height: AppSize.s8.h,
                  ),
                  IntlPhoneField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s10.r),
                          borderSide: BorderSide.none),
                      filled: true,
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
                      // suffixIcon: suffix,
                      hintText: AppStrings.phoneNumber,
                    ),
                    initialCountryCode: 'PS',
                    keyboardType: TextInputType.number,
                    onChanged: (phone) {
                      print(phone.completeNumber);
                      logic.phoneController.text = phone.completeNumber;
                    },
                  ),
                  SizedBox(
                    height: AppSize.s60.h,
                  ),
                  Container(
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
                              borderRadius: BorderRadius.circular(AppSize.s16.r)),
                          padding: EdgeInsets.zero,
                          minimumSize: Size(double.infinity, 64.h)),
                      onPressed: () {
                        logic.sendOtp(logic.phoneController.text.trim());
                      },
                      child: Text(
                        AppStrings.sendOtp,
                        style: getBoldStyle(
                            color: ColorManager.white, fontSize: FontSize.s16.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s32.h,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
