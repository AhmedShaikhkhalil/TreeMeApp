import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:treeme/core/utils/services/storage.dart';
import 'package:treeme/modules/auth/data/data_sources/auth_data_source.dart';
import 'package:treeme/modules/auth/presentation/manager/login_controller.dart';
import 'package:treeme/modules/auth/presentation/pages/otp_signup.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/netwrok/failure.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/error_toast.dart';
import '../pages/otp_login_screen.dart';

class SignUpController extends GetxController {
  late TapGestureRecognizer signUpRecognizer;
  final IAuthDataSource _authDataSource;
  final Storage _storage;
  String? verificationIdUser = '';
  SignUpController(
    this._authDataSource,
    this._storage,
  );
  int? _resendToken;
  bool showPass = true;
  bool showConfPass = true;
  String errorText = '';
  String sendCode = '';
  String oTPCode = '';

  late StreamController<ErrorAnimationType> errorController;


  showPassword() {
    showPass = !showPass;
    update();
  }

  showConfPassword() {
    showConfPass = !showConfPass;
    update();
  }

  @override
  void onInit() {
    errorController = StreamController<ErrorAnimationType>();
    signUpRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Get.back();
      };
    super.onInit();
  }

  final TextEditingController registerNumberController = TextEditingController();
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerPasswordController = TextEditingController();
  final TextEditingController registerPasswordConfirmController = TextEditingController();
  clearTextField() {
    registerNumberController.clear();
    registerNameController.clear();
    registerPasswordController.clear();
    registerPasswordConfirmController.clear();
  }

  @override
  void onClose() {
    registerNumberController.dispose();
    registerNameController.dispose();
    registerPasswordController.dispose();
    registerPasswordConfirmController.dispose();
  }

  Future<void> register(
      ) async {

    final registerModel =
        await _authDataSource.register(registerNameController.text.trim(), registerPasswordController.text.trim(), registerPasswordConfirmController.text.trim(), registerNumberController.text);
    registerModel.fold((l) => errorToast(l.message), (r) async {
      _storage.jwtToken = r.token?.apiToken ?? '';
      _storage.fistName = r.data?.name ?? '';
      _storage.firebaseUID = r.data?.firebaseUid ?? '';
      _storage.phoneNumber = r.data?.phone ?? '';
      _storage.userId = r.data?.id.toString() ?? '';
      _storage.isLoggedIn = true;
      AppConfig.firstName = _storage.fistName;
      AppConfig.firstName = _storage.fistName;
      AppConfig.userId = _storage.userId;
      AppConfig.phoneNumber = r.data?.phone ?? '';
      // Get.toNamed(AppRoutes.navBar);
      verifyPhone();
    });
    // clearTextField();
  }

  Future<void> verifyPhone() async {
    try{
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: registerNumberController.text.trim(),
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                register();
              }
            });

          },
          verificationFailed: (FirebaseAuthException e) {
            errorToast(e.message??'Error');
          },
          codeSent: (String? verficationID, int? resendToken) {
            verificationIdUser = verficationID;
            _resendToken = resendToken;

            Get.to(() => OTPSignupScreen());
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            verificationID = verificationIdUser??'' ;
          },
          timeout: Duration(seconds: 9));
    }catch (e){
      log('verifyPhoneNumber $e');
    }

  }}

extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Failure, U>> mapLeftToFailure() {
    return map(
      (either) => either.leftMap((obj) {
        try {
          return obj as Failure;
        } catch (e) {
          throw obj;
        }
      }),
    );
  }
}
