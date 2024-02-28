// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCE8Ggq08jqaBQetuoy2zbb8m7gKcAb58s',
    appId: '1:61477570914:android:cef8ab406d2eae6d25043b',
    messagingSenderId: '61477570914',
    projectId: 'treeme-chat',
    databaseURL: 'https://treeme-chat-default-rtdb.firebaseio.com',
    storageBucket: 'treeme-chat.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAX6J22kUbT4jDo-JtDU0LECX6rjDrRJlU',
    appId: '1:61477570914:ios:aa22efe6d553185125043b',
    messagingSenderId: '61477570914',
    projectId: 'treeme-chat',
    databaseURL: 'https://treeme-chat-default-rtdb.firebaseio.com',
    storageBucket: 'treeme-chat.appspot.com',
    androidClientId: '61477570914-42n8fhm058782c1iandcla7qctrkk4p9.apps.googleusercontent.com',
    iosClientId: '61477570914-4hka7qilmf6k5cbava102sff9gmsleo1.apps.googleusercontent.com',
    iosBundleId: 'com.wiz.treeme',
  );
}
