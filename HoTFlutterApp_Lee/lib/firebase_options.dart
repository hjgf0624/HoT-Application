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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCWGUWO-NNR1nYYQOcxKGgNVFuM1Q5VqU8',
    appId: '1:33940977685:web:915e2850de3af354d8f61c',
    messagingSenderId: '33940977685',
    projectId: 'capstone-7a008',
    authDomain: 'capstone-7a008.firebaseapp.com',
    databaseURL: 'https://capstone-7a008-default-rtdb.firebaseio.com',
    storageBucket: 'capstone-7a008.appspot.com',
    measurementId: 'G-4ME7Y4EKR4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCxaDRypE2mdvAGsKfoA_ZDi4_1uPxCic',
    appId: '1:33940977685:android:67b8575d57c6afa6d8f61c',
    messagingSenderId: '33940977685',
    projectId: 'capstone-7a008',
    databaseURL: 'https://capstone-7a008-default-rtdb.firebaseio.com',
    storageBucket: 'capstone-7a008.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6QvD7vGGcEIiyRHQsYsN0SC_Z-gpzkao',
    appId: '1:33940977685:ios:0db67bce7cdb8301d8f61c',
    messagingSenderId: '33940977685',
    projectId: 'capstone-7a008',
    databaseURL: 'https://capstone-7a008-default-rtdb.firebaseio.com',
    storageBucket: 'capstone-7a008.appspot.com',
    iosClientId: '33940977685-nfiscrqrfm7476aqcqjhna42d1gf8urf.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6QvD7vGGcEIiyRHQsYsN0SC_Z-gpzkao',
    appId: '1:33940977685:ios:1d60d5d9de98ddf3d8f61c',
    messagingSenderId: '33940977685',
    projectId: 'capstone-7a008',
    databaseURL: 'https://capstone-7a008-default-rtdb.firebaseio.com',
    storageBucket: 'capstone-7a008.appspot.com',
    iosClientId: '33940977685-0pse6jg3hbun9jpua1f7f8f4ac1rot0e.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled2.RunnerTests',
  );
}
