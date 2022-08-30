import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectwork/index.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  final _isUserLoggedIn = false.obs;
  late User _currentFirebaseUser;
  UserModel _currentUserInfo = UserModel();

  // initialize the firebase user
  initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _isUserLoggedIn.value = true; // user is logged in
        updateCurrentFirebaseUser(user: user);
      } else {
        _isUserLoggedIn.value = false;
      }
    });
  }

  // update current firebase user
  updateCurrentFirebaseUser({required User user}) {
    _currentFirebaseUser = user;
    initUser();
  }

  // update user model from map
  updateCurrentUserInfoFromMap({required String id, required Map<String, dynamic> userMap}) {
    _currentUserInfo = UserModel.fromMap(userMap, id);
    initUser();
  }

  updateCurrentUserInfo(UserModel userModel) {
    debugPrint("updating current user info");
    _currentUserInfo = userModel;
    initUser();
  }

  bool get isUserLoggedIn => _isUserLoggedIn.value;
  User get currentFirebaseUser => _currentFirebaseUser;
  UserModel get currentUserInfo => _currentUserInfo;
}
