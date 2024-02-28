import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treeme/core/utils/services/storage.dart';
import 'package:treeme/modules/auth/data/data_sources/auth_data_source.dart';
import 'package:treeme/modules/auth/presentation/manager/login_controller.dart';

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
  bool showPass = true;
  bool showConfPass = true;

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
      String name, String password, String confirmPassword, String phone) async {
    final registerModel =
        await _authDataSource.register(name, password, confirmPassword, phone);
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
      print('tokem ${_storage.jwtToken}');
      successToast('A code will be sent to you');
     Get.toNamed(AppRoutes.login);
    });
    // clearTextField();
  }

  _verifyPhone(String? phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
          if (value.user != null) {
            Get.to(AppRoutes.navBar);
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => Home()),
            //         (route) => false);
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String? verficationID, int? resendToken) {
        verificationIdUser = verficationID;
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        Get.to(() => OTPLoginScreen());
      },
      timeout: Duration(seconds: 30),
    );
  }
}

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
