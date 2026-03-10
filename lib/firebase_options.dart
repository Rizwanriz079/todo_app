import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDZSXUbfe_cWt5qMoXwJh1J_AnAuRcDUEg',
    appId: '1:278884199301:web:097c883a79d2e30ec0b2ec',
    messagingSenderId: '278884199301',
    projectId: 'hreblr',
    authDomain: 'hreblr.firebaseapp.com',
    databaseURL: 'https://hreblr-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'hreblr.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATyxtPgOLv_1_Un8febTeEY36EZl72zVM',
    appId: '1:278884199301:android:b5103d28631b7284c0b2ec',
    messagingSenderId: '278884199301',
    projectId: 'hreblr',
    databaseURL: 'https://hreblr-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'hreblr.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGzgC-HlenRM3dX4wp7rienRFPc03Pg2g',
    appId: '1:278884199301:ios:b743be42fa715ae4c0b2ec',
    messagingSenderId: '278884199301',
    projectId: 'hreblr',
    databaseURL: 'https://hreblr-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'hreblr.firebasestorage.app',
    iosBundleId: 'com.hre.todo.hre',
  );
}
