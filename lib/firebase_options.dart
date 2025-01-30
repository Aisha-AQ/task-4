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
    apiKey: 'AIzaSyDdlNg5Ik97II7YCzTzC8O7pkqlHgZUlns',
    appId: '1:823671072860:web:41cce3b04ff6f54f509e99',
    messagingSenderId: '823671072860',
    projectId: 'task-44',
    authDomain: 'task-44.firebaseapp.com',
    storageBucket: 'task-44.firebasestorage.app',
    measurementId: 'G-BC0HML3YER',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3VtTcVFIJyPR6asHYS6mzLKhlabOM_I0',
    appId: '1:823671072860:android:3661a073ec1e559e509e99',
    messagingSenderId: '823671072860',
    projectId: 'task-44',
    storageBucket: 'task-44.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMOxaKMWvUKtncKafHo6JnEPxN7YZTLvA',
    appId: '1:823671072860:ios:42b8b54f7071de73509e99',
    messagingSenderId: '823671072860',
    projectId: 'task-44',
    storageBucket: 'task-44.firebasestorage.app',
    iosBundleId: 'com.example.task4',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAMOxaKMWvUKtncKafHo6JnEPxN7YZTLvA',
    appId: '1:823671072860:ios:42b8b54f7071de73509e99',
    messagingSenderId: '823671072860',
    projectId: 'task-44',
    storageBucket: 'task-44.firebasestorage.app',
    iosBundleId: 'com.example.task4',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDdlNg5Ik97II7YCzTzC8O7pkqlHgZUlns',
    appId: '1:823671072860:web:24d0b3013c567f37509e99',
    messagingSenderId: '823671072860',
    projectId: 'task-44',
    authDomain: 'task-44.firebaseapp.com',
    storageBucket: 'task-44.firebasestorage.app',
    measurementId: 'G-JWBMFJ97DN',
  );
}
