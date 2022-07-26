import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:projectwork/index.dart';

class UserRepo {
  final FirebaseCaller _firebaseCaller = FirebaseCaller.instance;

  String? uid;
  UserModel? userModel;

  // set user data
  Future<Either<Failure, UserModel>> setUserDataToFirebase(
    UserModel userData,
  ) async {
    try {
      final _firebaseStoredUser = await getUserDataFromFirebase(userData.uid);
      if (_firebaseStoredUser == null) {
        _firebaseCaller.setData(
          path: FirestorePaths.userDocument(userData.uid),
          data: userData.toMap(),
        );
        userModel = userData;
        return Right(userData);
      } else {
        return Right(_firebaseStoredUser);
      }
    } on FirebaseAuthException catch (e) {
      final _errorMessage = Exceptions.firebaseAuthErrorMessage(e);
      return Left(ServerFailure(message: _errorMessage));
    } catch (e) {
      debugPrint(e.toString());
      final _errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: _errorMessage));
    }
  }

  // check if user document exists
  Future<bool> checkUserData(String uid) async {
    await _firebaseCaller.getData(
      path: FirestorePaths.userDocument(uid),
      builder: (data, docId) {
        if (data != null) {
          return true;
        }
        return false;
      },
    );
    return false;
  }

  // get user data from firebase
  Future<UserModel?> getUserDataFromFirebase(String userId) async {
    return await _firebaseCaller.getData(
      path: FirestorePaths.userDocument(userId),
      builder: (data, docId) {
        if (data != null) {
          userModel = UserModel.fromMap(data, docId!);
          return userModel!;
        }
        return null;
      },
    );
  }

  // update user
  Future updateUser(UserModel userData) async {
    await _firebaseCaller.setData(
      path: FirestorePaths.userDocument(uid!),
      data: userData.toMap(),
      merge: true,
    );
    userModel = userData;
  }

  // change first name
  Future updateFirstName({required String name}) async {
    await _firebaseCaller.setData(
      path: FirestorePaths.userDocument(uid!),
      data: {"first_name": name},
      merge: true,
    );
    userModel = userModel!.copyWith(firstName: name);
  }

  // change last name
  Future updateLastName({required String name}) async {
    await _firebaseCaller.setData(
      path: FirestorePaths.userDocument(uid!),
      data: {"last_name": name},
      merge: true,
    );
    userModel = userModel!.copyWith(lastName: name);
  }

  // change phone number
  Future updateUserPhone({required String phone}) async {
    await _firebaseCaller.setData(
      path: FirestorePaths.userDocument(uid!),
      data: {"phone": phone},
      merge: true,
    );
    userModel = userModel!.copyWith(phoneNumber: phone);
  }

  // update user profile picture
  Future updateUserImage({required File? imageFile}) async {
    String? _picUrl = await _firebaseCaller.uploadImage(
      path: FirestorePaths.profilesImagesPath(userModel!.uid),
      file: imageFile!,
    );
    if (_picUrl != null) {
      await _firebaseCaller.setData(
        path: FirestorePaths.userDocument(uid!),
        data: {"profile": _picUrl},
        merge: true,
      );
      userModel = userModel!.copyWith(profile: _picUrl);
    }
  }

  // delete user data
  Future clearUserLocalData() async {
    uid = null;
    userModel = null;
  }
}
