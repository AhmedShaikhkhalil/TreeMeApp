import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:treeme/core/routes/app_routes.dart';
import 'package:treeme/core/utils/error_toast.dart';

import '../../data/data_sources/auth_data_source.dart';
import '../pages/otp_screen.dart';

class ForgotPasswordController extends GetxController {
  bool onFirstPage = false;
  bool onVerify = true;
  String errorText = '';
  String sendCode = '';
  String oTPCode = '';
  bool showPass = true;
  showPassword() {
    showPass = !showPass;
    update();
  }

  final IAuthDataSource _authDataSource;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  late TapGestureRecognizer resendCodeRecognizer;
  late StreamController<ErrorAnimationType> errorController;
  ForgotPasswordController(this._authDataSource);

  void transPage() {
    onFirstPage = !onFirstPage;
    update();
  }

  void setPass() {
    onVerify = !onVerify;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    errorController = StreamController<ErrorAnimationType>();
    resendCodeRecognizer = TapGestureRecognizer()
      ..onTap = () {
        sendOtp(phoneController.text.trim());
        transPage();
      };
  }

  Future<void> sendOtp(String phone) async {
    final sendOTP = await _authDataSource.sendOtp(
      phone,
    );
    sendOTP.fold((l) => errorToast(l.message), (r) {
      successToast(r.otp ?? '', title: r.message);
      oTPCode = r.otp ?? '';
      !onFirstPage ? Get.to(OTPScreen()) : null;
    });
  }

  Future<void> resetPassword(String phone, String otp, String newPass) async {
    final sendOTP = await _authDataSource.resetPassword(otp, newPass, phone);
    sendOTP.fold((l) => errorToast(l.message), (r) {
      successToast(r ?? '');
      Get.offAndToNamed(AppRoutes.login);
    });
  }

  verfiy() {
    if (oTPCode == sendCode) {
      successToast('Code is Correct');
      setPass();
    } else {
      errorController.add(ErrorAnimationType.shake);
      errorToast('Code is Wrong');
    }
  }
}
