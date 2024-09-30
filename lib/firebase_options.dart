// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBtx8qz-ZOh3YCam5rK1nbv_JZf0adDfDU',
    appId: '1:1031794551154:web:3d748653296c732914d5eb',
    messagingSenderId: '1031794551154',
    projectId: 'farmogram-c5609',
    authDomain: 'farmogram-c5609.firebaseapp.com',
    storageBucket: 'farmogram-c5609.appspot.com',
    measurementId: 'G-5MYBJMZ4RG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9cLA-mq-1TCMSSBxlqY1vwVVoPZIwkAM',
    appId: '1:1031794551154:android:bc2f838f8374b03914d5eb',
    messagingSenderId: '1031794551154',
    projectId: 'farmogram-c5609',
    storageBucket: 'farmogram-c5609.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYyUAe5BW2pgn7b2dglSOaHOpacyjmkf4',
    appId: '1:1031794551154:ios:17f03eaba440f82514d5eb',
    messagingSenderId: '1031794551154',
    projectId: 'farmogram-c5609',
    storageBucket: 'farmogram-c5609.appspot.com',
    iosClientId:
        '1031794551154-r20os56ej8rfqh3kc6bnt8uvhcblii1n.apps.googleusercontent.com',
    iosBundleId: 'com.student.farmogram',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCYyUAe5BW2pgn7b2dglSOaHOpacyjmkf4',
    appId: '1:1031794551154:ios:17f03eaba440f82514d5eb',
    messagingSenderId: '1031794551154',
    projectId: 'farmogram-c5609',
    storageBucket: 'farmogram-c5609.appspot.com',
    iosClientId:
        '1031794551154-r20os56ej8rfqh3kc6bnt8uvhcblii1n.apps.googleusercontent.com',
    iosBundleId: 'com.student.farmogram',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBtx8qz-ZOh3YCam5rK1nbv_JZf0adDfDU',
    appId: '1:1031794551154:web:63152f0e7abaa4ab14d5eb',
    messagingSenderId: '1031794551154',
    projectId: 'farmogram-c5609',
    authDomain: 'farmogram-c5609.firebaseapp.com',
    storageBucket: 'farmogram-c5609.appspot.com',
    measurementId: 'G-JVPVEKC6VC',
  );
}
