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
    apiKey: 'AIzaSyAvPL0E9y5OQD5xsun212IqPO38PoDFNs0',
    appId: '1:524004505175:web:0ad60d9565497df71dd512',
    messagingSenderId: '524004505175',
    projectId: 'complaint-management-sys-87685',
    authDomain: 'complaint-management-sys-87685.firebaseapp.com',
    storageBucket: 'complaint-management-sys-87685.appspot.com',
    measurementId: 'G-ZQ36BMWC6G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbKDu_U6J0aL37mB7z6Kd4maA_a6b4dFE',
    appId: '1:524004505175:android:09bd27cf2a19c7c91dd512',
    messagingSenderId: '524004505175',
    projectId: 'complaint-management-sys-87685',
    storageBucket: 'complaint-management-sys-87685.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXnzAIJ0q8nO7oXtIQDiBs3nlJh6WgogU',
    appId: '1:524004505175:ios:fbb7725404c51a011dd512',
    messagingSenderId: '524004505175',
    projectId: 'complaint-management-sys-87685',
    storageBucket: 'complaint-management-sys-87685.appspot.com',
    iosBundleId: 'com.example.complaintManagementSystem',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXnzAIJ0q8nO7oXtIQDiBs3nlJh6WgogU',
    appId: '1:524004505175:ios:fbb7725404c51a011dd512',
    messagingSenderId: '524004505175',
    projectId: 'complaint-management-sys-87685',
    storageBucket: 'complaint-management-sys-87685.appspot.com',
    iosBundleId: 'com.example.complaintManagementSystem',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAvPL0E9y5OQD5xsun212IqPO38PoDFNs0',
    appId: '1:524004505175:web:32be91e3b5e768891dd512',
    messagingSenderId: '524004505175',
    projectId: 'complaint-management-sys-87685',
    authDomain: 'complaint-management-sys-87685.firebaseapp.com',
    storageBucket: 'complaint-management-sys-87685.appspot.com',
    measurementId: 'G-K0W7P2VWNW',
  );

}