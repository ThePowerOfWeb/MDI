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
    apiKey: 'AIzaSyBOW0KZrLVKSjT9M-t1KAO9u2rCZag0FY8',
    appId: '1:607632802844:web:7a178d4a98afcf420a4bd9',
    messagingSenderId: '607632802844',
    projectId: 'flutteruassem4',
    authDomain: 'flutteruassem4.firebaseapp.com',
    storageBucket: 'flutteruassem4.firebasestorage.app',
    measurementId: 'G-KXCKDS9JR0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZc-bwsuCX_k0MBzsEsBxBiEndVypdgyk',
    appId: '1:607632802844:android:9abe1cbdd33c99d70a4bd9',
    messagingSenderId: '607632802844',
    projectId: 'flutteruassem4',
    storageBucket: 'flutteruassem4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAveAkaxZrd7ijQRKPTh9N0lSCNCZqGyXo',
    appId: '1:607632802844:ios:e1aa3ef4b3cb4d280a4bd9',
    messagingSenderId: '607632802844',
    projectId: 'flutteruassem4',
    storageBucket: 'flutteruassem4.firebasestorage.app',
    iosBundleId: 'com.example.aplikasi14',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAveAkaxZrd7ijQRKPTh9N0lSCNCZqGyXo',
    appId: '1:607632802844:ios:e1aa3ef4b3cb4d280a4bd9',
    messagingSenderId: '607632802844',
    projectId: 'flutteruassem4',
    storageBucket: 'flutteruassem4.firebasestorage.app',
    iosBundleId: 'com.example.aplikasi14',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBOW0KZrLVKSjT9M-t1KAO9u2rCZag0FY8',
    appId: '1:607632802844:web:c2bd206c6d6571650a4bd9',
    messagingSenderId: '607632802844',
    projectId: 'flutteruassem4',
    authDomain: 'flutteruassem4.firebaseapp.com',
    storageBucket: 'flutteruassem4.firebasestorage.app',
    measurementId: 'G-GSG64EJ8TN',
  );
}
