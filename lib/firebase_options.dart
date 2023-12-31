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
    apiKey: 'AIzaSyDoDG2sdiiYmRv013PbeUuNzboKu03VujE',
    appId: '1:900568651789:web:40955e9fae43212f035d44',
    messagingSenderId: '900568651789',
    projectId: 'authpractice-65885',
    authDomain: 'authpractice-65885.firebaseapp.com',
    storageBucket: 'authpractice-65885.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3vzabGptB27sI_V1Wwc4bHC6BfOrMEkk',
    appId: '1:900568651789:android:22ccee8d581ee4d2035d44',
    messagingSenderId: '900568651789',
    projectId: 'authpractice-65885',
    storageBucket: 'authpractice-65885.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3SuECwvCYv9YFDrRgmJSR3Mnj_phGxW8',
    appId: '1:900568651789:ios:4e8e557c83291208035d44',
    messagingSenderId: '900568651789',
    projectId: 'authpractice-65885',
    storageBucket: 'authpractice-65885.appspot.com',
    iosBundleId: 'com.greendee.practice',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3SuECwvCYv9YFDrRgmJSR3Mnj_phGxW8',
    appId: '1:900568651789:ios:394e7e6c73928fc4035d44',
    messagingSenderId: '900568651789',
    projectId: 'authpractice-65885',
    storageBucket: 'authpractice-65885.appspot.com',
    iosBundleId: 'com.greendee.practice.RunnerTests',
  );
}
