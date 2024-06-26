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
    apiKey: 'AIzaSyDcO7BCui2JwJMsfEmozIX6ExpItHb4fEU',
    appId: '1:765809634314:web:083ae2a6ea36a337dd03f3',
    messagingSenderId: '765809634314',
    projectId: 'assignment3-7bdb6',
    authDomain: 'assignment3-7bdb6.firebaseapp.com',
    storageBucket: 'assignment3-7bdb6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVkX0RUB1NeeYbL1hy2F3847MeiE6YbTE',
    appId: '1:765809634314:android:cb8aa82d779ec838dd03f3',
    messagingSenderId: '765809634314',
    projectId: 'assignment3-7bdb6',
    storageBucket: 'assignment3-7bdb6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoxLUfPz3WzHMKykTn-O4-yL6tFVq51Kg',
    appId: '1:765809634314:ios:aad765bb93a94cf6dd03f3',
    messagingSenderId: '765809634314',
    projectId: 'assignment3-7bdb6',
    storageBucket: 'assignment3-7bdb6.appspot.com',
    iosBundleId: 'com.example.assignment3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDoxLUfPz3WzHMKykTn-O4-yL6tFVq51Kg',
    appId: '1:765809634314:ios:aad765bb93a94cf6dd03f3',
    messagingSenderId: '765809634314',
    projectId: 'assignment3-7bdb6',
    storageBucket: 'assignment3-7bdb6.appspot.com',
    iosBundleId: 'com.example.assignment3',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDcO7BCui2JwJMsfEmozIX6ExpItHb4fEU',
    appId: '1:765809634314:web:075913672a1585a3dd03f3',
    messagingSenderId: '765809634314',
    projectId: 'assignment3-7bdb6',
    authDomain: 'assignment3-7bdb6.firebaseapp.com',
    storageBucket: 'assignment3-7bdb6.appspot.com',
  );
}
