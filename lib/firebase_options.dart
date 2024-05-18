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
    apiKey: 'AIzaSyCsOT7XuoTkNlkwr6N6ZQ3jXb6xHF6v94Q',
    appId: '1:68368382940:web:aee8a51e17f0c8fe39ad19',
    messagingSenderId: '68368382940',
    projectId: 'task2-b73b6',
    authDomain: 'task2-b73b6.firebaseapp.com',
    storageBucket: 'task2-b73b6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhTbqWk_GG3LB7Ky6NGLChs909QbyKkZU',
    appId: '1:68368382940:android:ea27402cda31a2c539ad19',
    messagingSenderId: '68368382940',
    projectId: 'task2-b73b6',
    storageBucket: 'task2-b73b6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBf7a1Kb-8eq3_9HPd6TDzf-rwtumkRH7k',
    appId: '1:68368382940:ios:0b070dcde80fd26a39ad19',
    messagingSenderId: '68368382940',
    projectId: 'task2-b73b6',
    storageBucket: 'task2-b73b6.appspot.com',
    iosBundleId: 'com.example.task2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBf7a1Kb-8eq3_9HPd6TDzf-rwtumkRH7k',
    appId: '1:68368382940:ios:0b070dcde80fd26a39ad19',
    messagingSenderId: '68368382940',
    projectId: 'task2-b73b6',
    storageBucket: 'task2-b73b6.appspot.com',
    iosBundleId: 'com.example.task2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCsOT7XuoTkNlkwr6N6ZQ3jXb6xHF6v94Q',
    appId: '1:68368382940:web:0a5ec1f72af9245039ad19',
    messagingSenderId: '68368382940',
    projectId: 'task2-b73b6',
    authDomain: 'task2-b73b6.firebaseapp.com',
    storageBucket: 'task2-b73b6.appspot.com',
  );
}
