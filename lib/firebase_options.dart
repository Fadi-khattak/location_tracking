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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBL_oEWA67MMnWwbh-ptVNOVViXTppSXPA',
    appId: '1:868742610477:android:512c8a97622e1f0aed42a4',
    messagingSenderId: '868742610477',
    projectId: 'groupchat-74767',
    databaseURL: 'https://groupchat-74767-default-rtdb.firebaseio.com',
    storageBucket: 'groupchat-74767.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB9hYQnEqQZ02So0nkndVZUTeX5vPTrJY4',
    appId: '1:868742610477:ios:4426ad164906cb8eed42a4',
    messagingSenderId: '868742610477',
    projectId: 'groupchat-74767',
    databaseURL: 'https://groupchat-74767-default-rtdb.firebaseio.com',
    storageBucket: 'groupchat-74767.appspot.com',
    androidClientId: '868742610477-132bd2qa3uv2iun6ebhujok36qkj0r8j.apps.googleusercontent.com',
    iosClientId: '868742610477-egsetcg9q66j1krqhppvtmbgfpm6rb5i.apps.googleusercontent.com',
    iosBundleId: 'com.example.locationTracking',
  );
}
