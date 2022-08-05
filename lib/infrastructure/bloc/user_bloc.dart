import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projectwork/index.dart';

class MUser {
  bool isUserLoggedIn = false;
  late User currentFirebaseUser;
  late UserModel currentUserInfo;

  // initialize the firebase user
  initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        isUserLoggedIn = true; // user is logged in
        updateCurrentFirebaseUser(user);
      } else {
        isUserLoggedIn = false;
      }
    });
  }

  // update current firebase user
  updateCurrentFirebaseUser(User user) {
    currentFirebaseUser = user;
    initUser();
  }

  updateCurrentUserInfo(UserModel userModel) {
    currentUserInfo = userModel;
    initUser();
  }
}

final userProvider = StateProvider<MUser>((ref) {
  return MUser();
});
