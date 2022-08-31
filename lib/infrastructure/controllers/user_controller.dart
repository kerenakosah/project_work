import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:projectwork/index.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  final _isUserLoggedIn = false.obs;
  late User _currentFirebaseUser;
  final _currentUserInfo = UserModel().obs;

  // initialize the firebase user
  initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _isUserLoggedIn.value = true;
        _currentFirebaseUser = user;
      }
    });
  }

  // update user model from map
  updateCurrentUserInfoFromMap({required String id, required Map<String, dynamic> userMap}) {
    _currentUserInfo.value = UserModel.fromMap(userMap, id);
    initUser();
  }

  updateCurrentUserInfo(UserModel userModel) {
    _currentUserInfo.value = userModel;
  }

  bool get isUserLoggedIn => _isUserLoggedIn.value;
  User get currentFirebaseUser => _currentFirebaseUser;
  UserModel get currentUserInfo => _currentUserInfo.value;
}
