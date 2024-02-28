import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:treeme/core/helpers/validator.dart';
import 'package:treeme/core/resources/resource.dart';
import 'package:treeme/core/widgets/custom_textField_with_label.dart';
import 'package:treeme/modules/auth/presentation/manager/forgot_password_controller.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late TextEditingController otpController;

  @override
  void initState() {
    otpController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();

    super.dispose();
  }

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
            child: GetBuilder<ForgotPasswordController>(builder: (logic) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(ImageAssets.hotAirBallon),
                      ],
                    ),
                    Text(
                      logic.onVerify ? 'Enter OTP' : 'Enter New Password',
                      style: getBoldStyle(
                          fontSize: FontSize.s20.sp,
                          decoration: TextDecoration.none,
                          color: const Color(0xffFEAA46)),
                    ),
                    SizedBox(
                      height: AppSize.s14.h,
                    ),
                    logic.onVerify
                        ? RichText(
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
                            ]))
                        : SizedBox(),
                    SizedBox(
                      height: AppSize.s53.h,
                    ),
                    PageTransitionSwitcher(
                      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                        return SharedAxisTransition(
                            fillColor: Colors.transparent,
                            animation: primaryAnimation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.vertical,
                            child: child);
                      },
                      duration: Duration(milliseconds: 300),
                      child: logic.onVerify
                          ? Column(
                              children: [
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: PinCodeTextField(
                                    length: 4,
                                    obscureText: false,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    animationType: AnimationType.fade,
                                    autoDisposeControllers: false,
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(15.sp),
                                      fieldHeight: 70.sp,
                                      fieldWidth: 70.sp,
                                      errorBorderColor: ColorManager.moveColor,
                                      activeColor: logic.errorText.isNotEmpty
                                          ? ColorManager.moveColor
                                          : ColorManager.mainColor,
                                      activeFillColor: logic.errorText.isNotEmpty
                                          ? ColorManager.moveColor.withOpacity(0.3)
                                          : ColorManager.mainColor,
                                      selectedColor: Colors.grey.shade300,
                                      selectedFillColor: Colors.grey.shade300,
                                      inactiveColor: Colors.grey.shade300,
                                      inactiveFillColor: Colors.grey.shade300,
                                    ),
                                    textStyle: const TextStyle(color: Colors.white),
                                    animationDuration: const Duration(milliseconds: 300),
                                    enableActiveFill: true,
                                    keyboardType: TextInputType.number,
                                    errorAnimationController: logic.errorController,
                                    controller: otpController,
                                    onCompleted: (v) {},
                                    onChanged: (value) {
                                      /*logic.otpController.text =
                                        replaceArabicNumber(value);
                                    logic.otpController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset:
                                            logic.otpController.text.length));
                                    */
                                      logic.sendCode = otpController.text;
                                      // logic.errorText = "";
                                      // logic.isFull = value.length == 4;
                                      // logic.update();
                                    },
                                    beforeTextPaste: (text) {
                                      return true;
                                    },
                                    appContext: context,
                                  ),
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
                                            color:
                                                ColorManager.mainColor.withOpacity(0.3),
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
                                    onPressed: () {
                                      logic.verfiy();
                                    },
                                    child: Text(
                                      AppStrings.verify,
                                      style: getBoldStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSize.s16.sp),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.s26.h,
                                ),
                                Center(
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: AppStrings.resendCode,
                                        recognizer: logic.resendCodeRecognizer,
                                        style: getBoldStyle(
                                            color: ColorManager.authText,
                                            fontSize: FontSize.s18.sp),
                                      )),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: AppSize.s24.h,
                                ),
                                CustomTextFieldWithLabel(
                                  controller: logic.newPasswordController,
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
                                  height: AppSize.s60.h,
                                ),
                                Container(
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                      gradient: ColorManager().gradientButton,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                ColorManager.mainColor.withOpacity(0.3),
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
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        logic.resetPassword(
                                            logic.phoneController.text.trim(),
                                            logic.oTPCode,
                                            logic.newPasswordController.text.trim());
                                      }
                                    },
                                    child: Text(
                                      AppStrings.submit,
                                      style: getBoldStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSize.s16.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    SizedBox(
                      height: AppSize.s32.h,
                    ),
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
