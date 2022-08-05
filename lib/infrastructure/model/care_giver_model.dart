import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String uid;
  late String firstName;
  late String lastName;
  late String displayName;
  late String email;
  late String phoneNumber;
  String? profile;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.displayName,
    this.profile,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phone'] ?? '',
      displayName: map['display_name'] ?? '',
      profile: map['profile'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phoneNumber,
      'display_name': displayName,
      'profile': profile,
    };
  }

  // factory constructor
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.id,
      firstName: doc['first_name'],
      lastName: doc['last_name'],
      email: doc['email'],
      phoneNumber: doc['phone'],
      displayName: doc['first_name'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'display_name': displayName,
      'profile': profile,
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
