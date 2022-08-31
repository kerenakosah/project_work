import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class HelperMethods {
  HelperMethods._();

  // create an instance of the class
  static final HelperMethods instance = HelperMethods._();

  // fetch user profile from firebase database
  Future<void> fetchUserProfile() async {
    // debugPrint("user ${userController.currentFirebaseUser.uid}");
    // get the uid of the current firebase user
    final String uid = userController.currentFirebaseUser.uid;
    UserModel? userModel = await userRepo.getUserDataFromFirebase(uid);
    userController.updateCurrentUserInfo(userModel!);
    // debugPrint("user data ${userModel.email}");
  }

  // post data to firebase database
  Future<void> postData({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) async {
    // get the uid of the current firebase user
    final String uid = userController.currentFirebaseUser.uid;
    // set the data to the firebase database
    UserModel userData = UserModel(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      displayName: '$firstName $lastName',
      email: email,
      phoneNumber: phoneNumber,
      profile: '',
    );
    Either<Failure, UserModel> data = await userRepo.setUserDataToFirebase(userData);
    if (data.isRight()) {
      data.fold((l) => debugPrint(l.toString()), (userModel) => userController.updateCurrentUserInfo(userModel));
    }
  }

  // update the data
  Future<void> updateData(String path, Map<String, dynamic> data) async {
    // update the data to the firebase database
    // await _databaseReference.child(path).update(data);
  }

  // subscribe to the firebase database
  Future<void> subscribeToData(String path) async {}
}
