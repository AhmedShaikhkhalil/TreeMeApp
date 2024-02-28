import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:treeme/core/helpers/validator.dart';
import 'package:treeme/core/resources/assets_manager.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/resources/strings_manager.dart';
import 'package:treeme/core/resources/values_manager.dart';

import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/widgets/custom_textField_with_label.dart';
import '../manager/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.authBackGround,
      body: Container(
        color: ColorManager.authBackGround,
        padding: EdgeInsets.symmetric(horizontal: AppSize.s18.w),
        child: SafeArea(
          child: SingleChildScrollView(
            child: GetBuilder<SignUpController>(builder: (logic) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          AppStrings.signUp.toUpperCase(),
                          style: getBoldStyle(
                              fontSize: FontSize.s30.sp,
                              decoration: TextDecoration.none,
                              color: const Color(0xffFEAA46)),
                        ),
                        Image.asset(ImageAssets.hotAirBallon),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s14.h,
                    ),
                    RichText(
                        textAlign: TextAlign.start,
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
                      height: AppSize.s33.h,
                    ),
                    CustomTextFieldWithLabel(
                      controller: logic.registerNameController,
                      label: AppStrings.name,
                      hint: AppStrings.nameHint,
                      validator: (p0) => Validator.validateName(p0!),
                    ),
                    SizedBox(
                      height: AppSize.s28.h,
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
                        logic.registerNumberController.text = phone.completeNumber;
                      },
                    ),
                    SizedBox(
                      height: AppSize.s14.h,
                    ),
                    CustomTextFieldWithLabel(
                      controller: logic.registerPasswordController,
                      label: AppStrings.password,
                      obscureText: logic.showPass,
                      hint: AppStrings.passwordHint,
                      validator: (p0) => Validator.validatePassword(p0 ?? ''),
                      suffix: IconButton(
                        onPressed: () => logic.showPassword(),
                        icon: Icon(
                          logic.showPass
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined,
                          size: AppSize.s20.h,
                          color: ColorManager.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s28.h,
                    ),
                    CustomTextFieldWithLabel(
                      controller: logic.registerPasswordConfirmController,
                      label: AppStrings.confirmPassword,
                      hint: AppStrings.repeatPassword,
                      obscureText: logic.showConfPass,
                      validator: (p0) => Validator.validateConfirmPassword(
                          p0 ?? '', logic.registerPasswordController.text),
                      suffix: IconButton(
                        onPressed: () => logic.showConfPassword(),
                        icon: Icon(
                          logic.showConfPass
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined,
                          size: AppSize.s20.h,
                          color: ColorManager.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s37.h,
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
                          if (_formKey.currentState!.validate()) {
                            logic.register(
                                logic.registerNameController.text.trim(),
                                logic.registerPasswordController.text.trim(),
                                logic.registerPasswordConfirmController.text.trim(),
                                logic.registerNumberController.text);
                          }
                        },
                        child: Text(
                          AppStrings.signUp.toUpperCase(),
                          style: getBoldStyle(
                              color: ColorManager.white, fontSize: FontSize.s16.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s32.h,
                    ),
                    Center(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: AppStrings.doHaveAcc,
                                style: getRegularStyle(
                                    color: ColorManager.black.withOpacity(0.7),
                                    fontSize: FontSize.s14.sp),
                                children: [
                                  TextSpan(
                                    text: AppStrings.signIn.toUpperCase(),
                                    recognizer: logic.signUpRecognizer,
                                    style: getBoldStyle(
                                        color: ColorManager.authText,
                                        fontSize: FontSize.s14.sp),
                                  )
                                ]),
                          ])),
                    ),
                    SizedBox(
                      height: AppSize.s40.h,
                    ),
                    // Center(
                    //   child: Text(
                    //     AppStrings.otherSignUpOpt,
                    //     style: getRegularStyle(
                    //         color: ColorManager.black.withOpacity(0.7),
                    //         fontSize: FontSize.s14.sp),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: AppSize.s15.h,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const OptionAuthWidget(
                    //       icon: ImageAssets.facebookLogo,
                    //     ),
                    //     SizedBox(
                    //       width: AppSize.s11.w,
                    //     ),
                    //     const OptionAuthWidget(
                    //       icon: ImageAssets.googleLogo,
                    //     ),
                    //     SizedBox(
                    //       width: AppSize.s11.w,
                    //     ),
                    //     const OptionAuthWidget(
                    //       icon: ImageAssets.appleLogo,
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
