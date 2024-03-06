import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:treeme/core/helpers/dismiss_keyboard.dart';
import 'package:treeme/core/utils/services/fb_notifications.dart';

import 'core/bindings/main_bindings.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/get_pages.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  // if(kDebugMode){
  //    FirebaseAuth.instance.setSettings(
  //     forceRecaptchaFlow: false,
  //     phoneNumber: '+970595236275',
  //     smsCode: '000000',
  //     appVerificationDisabledForTesting: true);
  // }
 
  FbNotifications.initNotifications();
  FirebaseFirestore.setLoggingEnabled(true);
  FbNotifications.initializeForegroundNotificationForAndroid();

  // await FFmpegKitConfig.init();
  // FFmpegKitConfig.enableLogCallback(logCallback);
  // FFmpegKitConfig.enableStatisticsCallback(null);
  // FFmpegKitConfig.(null);
  // FFmpegKitConfig.enableLogToFile(false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: ((context, child) {
            return GetMaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(fontFamily: 'Comfortaa'),
              debugShowCheckedModeBanner: false,
              getPages: AppPages.pages,
              initialBinding: MainBindings(),
              initialRoute: AppRoutes.splash,
            );
          })),
    );
  }
}
