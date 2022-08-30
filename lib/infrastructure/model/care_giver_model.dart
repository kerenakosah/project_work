import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? displayName;
  String? email;
  String? phoneNumber;
  String? profile;

  UserModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.displayName,
    this.profile,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid.toString(),
      firstName: map['first_name'].toString(),
      lastName: map['last_name'].toString(),
      email: map['email'].toString(),
      phoneNumber: map['phone'].toString(),
      displayName: map['display_name'].toString(),
      profile: map['profile'].toString(),
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid.toString(),
      'first_name': firstName.toString(),
      'last_name': lastName.toString(),
      'email': email.toString(),
      'phone': phoneNumber.toString(),
      'display_name': displayName.toString(),
      'profile': profile.toString(),
    };
  }

  // factory constructor
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.id.toString(),
      firstName: doc['first_name'].toString(),
      lastName: doc['last_name'].toString(),
      email: doc['email'].toString(),
      phoneNumber: doc['phone'].toString(),
      displayName: doc['first_name'].toString(),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'uid': uid.toString(),
      'first_name': firstName.toString(),
      'last_name': lastName.toString(),
      'email': email.toString(),
      'phone_number': phoneNumber.toString(),
      'display_name': displayName.toString(),
      'profile': profile.toString(),
    };
  }

  // copyWith method
  UserModel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? displayName,
    String? profile,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      profile: profile ?? this.profile,
    );
  }
}
