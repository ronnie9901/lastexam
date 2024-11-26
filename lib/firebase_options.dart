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
    apiKey: 'AIzaSyAk08x0pghtA23wc1u3eDFV-9fktibemyQ',
    appId: '1:1055748981910:web:2f6c08fc90f1dbe0b2aeb7',
    messagingSenderId: '1055748981910',
    projectId: 'lastexam-a2e63',
    authDomain: 'lastexam-a2e63.firebaseapp.com',
    storageBucket: 'lastexam-a2e63.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbQQPdxTU8y2qZuPPp4rLYsnuwTXBY_zM',
    appId: '1:1055748981910:android:011e0dbef0a1af08b2aeb7',
    messagingSenderId: '1055748981910',
    projectId: 'lastexam-a2e63',
    storageBucket: 'lastexam-a2e63.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA8DqWeZ0g5GpkkJyiH1FP4dDyssCeAi9M',
    appId: '1:1055748981910:ios:0be10541e2178cfcb2aeb7',
    messagingSenderId: '1055748981910',
    projectId: 'lastexam-a2e63',
    storageBucket: 'lastexam-a2e63.firebasestorage.app',
    iosBundleId: 'com.example.lastexam',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA8DqWeZ0g5GpkkJyiH1FP4dDyssCeAi9M',
    appId: '1:1055748981910:ios:0be10541e2178cfcb2aeb7',
    messagingSenderId: '1055748981910',
    projectId: 'lastexam-a2e63',
    storageBucket: 'lastexam-a2e63.firebasestorage.app',
    iosBundleId: 'com.example.lastexam',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAk08x0pghtA23wc1u3eDFV-9fktibemyQ',
    appId: '1:1055748981910:web:3f0217f8c1aa8bd7b2aeb7',
    messagingSenderId: '1055748981910',
    projectId: 'lastexam-a2e63',
    authDomain: 'lastexam-a2e63.firebaseapp.com',
    storageBucket: 'lastexam-a2e63.firebasestorage.app',
  );
}