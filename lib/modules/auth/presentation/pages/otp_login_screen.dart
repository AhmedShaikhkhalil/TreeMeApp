import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:treeme/core/resources/resource.dart';
import 'package:treeme/core/routes/app_routes.dart';
import 'package:treeme/modules/auth/presentation/manager/login_controller.dart';

class OTPLoginScreen extends StatefulWidget {
  const OTPLoginScreen({Key? key}) : super(key: key);

  @override
  State<OTPLoginScreen> createState() => _OTPLoginScreenState();
}

class _OTPLoginScreenState extends State<OTPLoginScreen> {
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
            child: GetBuilder<LoginController>(builder: (logic) {
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
                      'Enter OTP',
                      style: getBoldStyle(
                          fontSize: FontSize.s20.sp,
                          decoration: TextDecoration.none,
                          color: const Color(0xffFEAA46)),
                    ),
                    SizedBox(
                      height: AppSize.s14.h,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        animationType: AnimationType.fade,
                        autoDisposeControllers: false,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15.sp),
                          fieldHeight: 45.sp,
                          fieldWidth: 45.sp,
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

                        keyboardType: TextInputType.number,
                        errorAnimationController: logic.errorController,
                        controller: otpController,
                        // onSubmitted: (value) async {
                        //   try {
                        //     await FirebaseAuth.instance
                        //         .signInWithCredential(PhoneAuthProvider.credential(
                        //             verificationId: logic.verificationIdUser!,
                        //             smsCode: value))
                        //         .then((value) async {
                        //       if (value.user != null) {
                        //         Get.to(AppRoutes.navBar);
                        //       }
                        //     });
                        //   } catch (e) {
                        //     ScaffoldMessenger.of(context)
                        //         .showSnackBar(SnackBar(content: Text(e.toString())));
                        //   }
                        // },
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
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance
                                .signInWithCredential(PhoneAuthProvider.credential(
                                    verificationId: logic.verificationIdUser!,
                                    smsCode: logic.sendCode))
                                .then((value) async {
                              if (value.user != null) {
                                logic.login();
                              }
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                        },
                        child: Text(
                          AppStrings.verify,
                          style: getBoldStyle(
                              color: ColorManager.white, fontSize: FontSize.s16.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s26.h,
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
