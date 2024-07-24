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
    apiKey: 'AIzaSyCo2w-fN-3cGrgDiw71de4om91pqxUJqyE',
    appId: '1:1043888553226:web:4023a9b402a4c2dbec4ef3',
    messagingSenderId: '1043888553226',
    projectId: 'msh-5de85',
    authDomain: 'msh-5de85.firebaseapp.com',
    storageBucket: 'msh-5de85.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWf_-V7y3YyuYT467DC9LWSLqJ23jpgKo',
    appId: '1:1043888553226:android:b7bec87d8fbd87b4ec4ef3',
    messagingSenderId: '1043888553226',
    projectId: 'msh-5de85',
    storageBucket: 'msh-5de85.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvL9XDezonONqNS4BCZaicoSiFdK9MqG8',
    appId: '1:1043888553226:ios:c82c49681c2674aeec4ef3',
    messagingSenderId: '1043888553226',
    projectId: 'msh-5de85',
    storageBucket: 'msh-5de85.appspot.com',
    iosBundleId: 'com.example.mshApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvL9XDezonONqNS4BCZaicoSiFdK9MqG8',
    appId: '1:1043888553226:ios:c82c49681c2674aeec4ef3',
    messagingSenderId: '1043888553226',
    projectId: 'msh-5de85',
    storageBucket: 'msh-5de85.appspot.com',
    iosBundleId: 'com.example.mshApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCo2w-fN-3cGrgDiw71de4om91pqxUJqyE',
    appId: '1:1043888553226:web:d13e4eff994ca162ec4ef3',
    messagingSenderId: '1043888553226',
    projectId: 'msh-5de85',
    authDomain: 'msh-5de85.firebaseapp.com',
    storageBucket: 'msh-5de85.appspot.com',
  );
}
