import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:projectwork/index.dart';

class AuthRepo {
  // sign in with email and password
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // debug print userCredential
      debugPrint(userCredential.toString());
      final User? user = userCredential.user;
      UserModel? userModel = await userRepo.getUserDataFromFirebase(user!.uid);
      return Right(userModel!);
    } on FirebaseAuthException catch (e) {
      final errorMessage = Exceptions.firebaseAuthErrorMessage(e);
      return Left(ServerFailure(message: errorMessage));
    } catch (e) {
      debugPrint(e.toString());
      final errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: errorMessage));
    }
  }

  // register with email and password
  Future<Either<Failure, UserModel>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? profile = '',
  }) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // debug print the credential
      debugPrint(userCredential.toString());
      final User? user = userCredential.user;
      UserModel? userData = UserModel(
        uid: user!.uid,
        firstName: firstName,
        lastName: lastName,
        displayName: '$firstName $lastName',
        email: email,
        phoneNumber: phoneNumber,
        profile: profile,
      );
      // save user data to firebase
      await userRepo.setUserDataToFirebase(userData);
      UserModel? userInfo = await userRepo.getUserDataFromFirebase(user.uid);
      return Right(userInfo!);
    } on FirebaseAuthException catch (e) {
      final errorMessage = Exceptions.firebaseAuthErrorMessage(e);
      return Left(ServerFailure(message: errorMessage));
    } catch (e) {
      debugPrint(e.toString());
      final errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: errorMessage));
    }
  }

  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
