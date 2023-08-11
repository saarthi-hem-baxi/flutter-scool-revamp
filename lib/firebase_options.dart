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
    apiKey: 'AIzaSyCKKbjUKqeB6egYtXYmWITtBFsII4Do6h8',
    appId: '1:1880302412:web:e91404cb017eda0c',
    messagingSenderId: '1880302412',
    projectId: 'saarthi-pedagogy-a2936',
    authDomain: 'saarthi-pedagogy-a2936.firebaseapp.com',
    databaseURL: 'https://saarthi-pedagogy-a2936.firebaseio.com',
    storageBucket: 'saarthi-pedagogy-a2936.appspot.com',
    measurementId: 'G-VWB5Y0HLE2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBow1iwDrWNbnumGZTW5A80DmK3FEKEU5g',
    appId: '1:1880302412:android:2001ce818fd9b68cfea5e9',
    messagingSenderId: '1880302412',
    projectId: 'saarthi-pedagogy-a2936',
    databaseURL: 'https://saarthi-pedagogy-a2936.firebaseio.com',
    storageBucket: 'saarthi-pedagogy-a2936.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFxGn_FTztqM_jUahdlJ6qb8kFKqB16wc',
    appId: '1:1880302412:ios:1998e83cdf434e77fea5e9',
    messagingSenderId: '1880302412',
    projectId: 'saarthi-pedagogy-a2936',
    databaseURL: 'https://saarthi-pedagogy-a2936.firebaseio.com',
    storageBucket: 'saarthi-pedagogy-a2936.appspot.com',
    androidClientId: '1880302412-k7u8u3mlb0d2slvvr4u3mvajohqr63vb.apps.googleusercontent.com',
    iosClientId: '1880302412-0i3ldtquafe08tr3opjv7q7nrgm1ik91.apps.googleusercontent.com',
    iosBundleId: 'com.saarthipedagogy.studentsv2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFxGn_FTztqM_jUahdlJ6qb8kFKqB16wc',
    appId: '1:1880302412:ios:1998e83cdf434e77fea5e9',
    messagingSenderId: '1880302412',
    projectId: 'saarthi-pedagogy-a2936',
    databaseURL: 'https://saarthi-pedagogy-a2936.firebaseio.com',
    storageBucket: 'saarthi-pedagogy-a2936.appspot.com',
    androidClientId: '1880302412-k7u8u3mlb0d2slvvr4u3mvajohqr63vb.apps.googleusercontent.com',
    iosClientId: '1880302412-0i3ldtquafe08tr3opjv7q7nrgm1ik91.apps.googleusercontent.com',
    iosBundleId: 'com.saarthipedagogy.studentsv2',
  );
}