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
      case TargetPlatform.windows:
        return web;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAkKgmthFrK-gSZZLqPqnKzTV81-wujwI8',
    appId: '1:907810109035:android:b5abe10f689662eb37232e',
    messagingSenderId: '907810109035',
    projectId: 'fashion-store-app-5fffa',
    storageBucket: 'fashion-store-app-5fffa.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkKgmthFrK-gSZZLqPqnKzTV81-wujwI8',
    appId: '1:907810109035:android:b5abe10f689662eb37232e',
    messagingSenderId: '907810109035',
    projectId: 'fashion-store-app-5fffa',
    storageBucket: 'fashion-store-app-5fffa.firebasestorage.app',
  );
}