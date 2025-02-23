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
    apiKey: 'AIzaSyAq6VYepp1G4Phm-ux4l30HZBfqDg9ruc0',
    appId: '1:634970179632:web:7399470eed09539bdf85f5',
    messagingSenderId: '634970179632',
    projectId: 'quizz-6ba14',
    authDomain: 'quizz-6ba14.firebaseapp.com',
    storageBucket: 'quizz-6ba14.firebasestorage.app',
    measurementId: 'G-REWVH0YM74',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDo0gPP3dIYSw5rH3yQ1KZOuPtd67e4vxg',
    appId: '1:634970179632:android:35bcb8ce5e9048a1df85f5',
    messagingSenderId: '634970179632',
    projectId: 'quizz-6ba14',
    storageBucket: 'quizz-6ba14.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaO7qZxs9yqiBdAtIdusgQApwbK_R3Nbo',
    appId: '1:634970179632:ios:1dd404c1089ebc73df85f5',
    messagingSenderId: '634970179632',
    projectId: 'quizz-6ba14',
    storageBucket: 'quizz-6ba14.firebasestorage.app',
    iosBundleId: 'com.example.hci',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaO7qZxs9yqiBdAtIdusgQApwbK_R3Nbo',
    appId: '1:634970179632:ios:1dd404c1089ebc73df85f5',
    messagingSenderId: '634970179632',
    projectId: 'quizz-6ba14',
    storageBucket: 'quizz-6ba14.firebasestorage.app',
    iosBundleId: 'com.example.hci',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAq6VYepp1G4Phm-ux4l30HZBfqDg9ruc0',
    appId: '1:634970179632:web:70ec79d72ec5383ddf85f5',
    messagingSenderId: '634970179632',
    projectId: 'quizz-6ba14',
    authDomain: 'quizz-6ba14.firebaseapp.com',
    storageBucket: 'quizz-6ba14.firebasestorage.app',
    measurementId: 'G-LYS70VWB4X',
  );
}
