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
    apiKey: 'AIzaSyDo2Rw_kENITF1EAkbhw2Zes43Iay2EUwQ',
    appId: '1:211133513597:web:20c1593347740f5e811614',
    messagingSenderId: '211133513597',
    projectId: 'chat-app-419bf',
    authDomain: 'chat-app-419bf.firebaseapp.com',
    storageBucket: 'chat-app-419bf.appspot.com',
    measurementId: 'G-7P6VBQQ34Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6f8W3XFm8ycq7RnL32FP8RzVfHyzfFak',
    appId: '1:211133513597:android:ecb6ff7875281c61811614',
    messagingSenderId: '211133513597',
    projectId: 'chat-app-419bf',
    storageBucket: 'chat-app-419bf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAgDtn2akk8kIw_R_CkTxots45FoxszNc',
    appId: '1:211133513597:ios:e050b084c46fbb20811614',
    messagingSenderId: '211133513597',
    projectId: 'chat-app-419bf',
    storageBucket: 'chat-app-419bf.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDAgDtn2akk8kIw_R_CkTxots45FoxszNc',
    appId: '1:211133513597:ios:e050b084c46fbb20811614',
    messagingSenderId: '211133513597',
    projectId: 'chat-app-419bf',
    storageBucket: 'chat-app-419bf.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDo2Rw_kENITF1EAkbhw2Zes43Iay2EUwQ',
    appId: '1:211133513597:web:3ad3b78fc89d2782811614',
    messagingSenderId: '211133513597',
    projectId: 'chat-app-419bf',
    authDomain: 'chat-app-419bf.firebaseapp.com',
    storageBucket: 'chat-app-419bf.appspot.com',
    measurementId: 'G-W3GVPXSH8V',
  );
}