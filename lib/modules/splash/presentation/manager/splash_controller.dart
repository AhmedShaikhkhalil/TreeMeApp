import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:treeme/core/routes/app_routes.dart';
import 'package:treeme/core/utils/services/storage.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController shakeController;
  late Animation<double> shakeAnimation;

  final Storage _storage;

  SplashController(this._storage);

  @override
  void onInit() {
    super.onInit();
    permission();
    shakeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    shakeAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -5.0, end: 5.0),
        weight: 0.5,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 5.0, end: -5.0),
        weight: 0.5,
      ),
    ]).animate(shakeController);
  }

  void _startShakeAnimation() {
    shakeController.forward(from: 0.0); // Start the animation from the beginning
  }

  @override
  void onReady() {
    super.onReady();

    _startShakeAnimation();
    print('${_storage.jwtToken}');
    Future.delayed(
      Duration(seconds: 4),
      () {
        if (_storage.jwtToken == null) {
          return Get.toNamed(AppRoutes.onBoarding);
        } else {
          return Get.toNamed(AppRoutes.navBar);
        }
      },
    );
  }

  Future<void> permission() async {
    var per = Permission.notification.request();
    var status = await Permission.contacts.status;
    if (status.isDenied) {
      bool isShown = await Permission.contacts.shouldShowRequestRationale;
    }

// You can can also directly ask the permission about its status.
//     if (await Permission.location.isRestricted) {
//       // The OS restricts access, for example because of parental controls.
//     }
  }
}
