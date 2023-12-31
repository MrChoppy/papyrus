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
    apiKey: 'AIzaSyBvCWC2DHvY63YwF3ZoQH51BiFgun_Gzqg',
    appId: '1:132165196119:web:64392589815fbdc0fe0612',
    messagingSenderId: '132165196119',
    projectId: 'papyrus-d47c6',
    authDomain: 'papyrus-d47c6.firebaseapp.com',
    storageBucket: 'papyrus-d47c6.appspot.com',
    measurementId: 'G-W07WRSZGFR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3KjP6Wbwbr2Qn2sROauoyqSHMN7QxgFM',
    appId: '1:132165196119:android:60a9729e386e6cd7fe0612',
    messagingSenderId: '132165196119',
    projectId: 'papyrus-d47c6',
    storageBucket: 'papyrus-d47c6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjOE7QwHLgKkcosAKalj70c3G6XzGLOX8',
    appId: '1:132165196119:ios:dff3656ed45ac1e8fe0612',
    messagingSenderId: '132165196119',
    projectId: 'papyrus-d47c6',
    storageBucket: 'papyrus-d47c6.appspot.com',
    iosBundleId: 'com.example.papyrus',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDjOE7QwHLgKkcosAKalj70c3G6XzGLOX8',
    appId: '1:132165196119:ios:22dd1b43841b65b0fe0612',
    messagingSenderId: '132165196119',
    projectId: 'papyrus-d47c6',
    storageBucket: 'papyrus-d47c6.appspot.com',
    iosBundleId: 'com.example.papyrus.RunnerTests',
  );
}
