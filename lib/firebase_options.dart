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
    apiKey: 'AIzaSyAyvoPv-H01P69NiWjcf8hLa-90dKc0IrQ',
    appId: '1:529899772494:web:c57f0cf15fd8e9233f411f',
    messagingSenderId: '529899772494',
    projectId: 'qr-code-getx',
    authDomain: 'qr-code-getx.firebaseapp.com',
    storageBucket: 'qr-code-getx.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5K30sWH-_FIF53jAD4GTXQP0IDmCGp44',
    appId: '1:529899772494:android:6c14ae89750830973f411f',
    messagingSenderId: '529899772494',
    projectId: 'qr-code-getx',
    storageBucket: 'qr-code-getx.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDp_058X_dfNAnGXH07JCBfN4_zRwl2eVo',
    appId: '1:529899772494:ios:1bc136f1b306e2b43f411f',
    messagingSenderId: '529899772494',
    projectId: 'qr-code-getx',
    storageBucket: 'qr-code-getx.appspot.com',
    iosClientId: '529899772494-fuljror0deogik1pndl65prqb47q7l1a.apps.googleusercontent.com',
    iosBundleId: 'com.example.qrCode',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDp_058X_dfNAnGXH07JCBfN4_zRwl2eVo',
    appId: '1:529899772494:ios:1bc136f1b306e2b43f411f',
    messagingSenderId: '529899772494',
    projectId: 'qr-code-getx',
    storageBucket: 'qr-code-getx.appspot.com',
    iosClientId: '529899772494-fuljror0deogik1pndl65prqb47q7l1a.apps.googleusercontent.com',
    iosBundleId: 'com.example.qrCode',
  );
}