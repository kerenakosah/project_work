import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions => Platform.isIOS || Platform.isMacOS
      ? const FirebaseOptions(
          appId: '1:404258353224:ios:8c15418d361165eaffa87d',
          apiKey: 'AIzaSyBxez--w-bonusq592_-nLeqakIAXje2BU',
          projectId: 'roam-ghana',
          messagingSenderId: '404258353224',
          databaseURL: 'https://roam-ghana-default-rtdb.firebaseio.com',
        )
      : const FirebaseOptions(
          appId: '1:653347381634:android:9c476f076533a6ea81ef9b',
          apiKey: 'AIzaSyAZsHf8IvWX7D8lqvoLFP_Z_COng4w1VF4',
          messagingSenderId: '653347381634',
          projectId: 'keren--project',
          databaseURL: 'keren--project.appspot.com',
        );
}
