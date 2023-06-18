import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    final String? name,
    final String? email,
    final String? uid,
    final String? status,
    final String? profileUrl,
    final String? password,
  }) : super(
          name: name,
          email: email,
          uid: uid,
          status: status,
          profileUrl: profileUrl,
          password: password,
        );

  factory UserModel.fromSnaphot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      name: snapshot['name'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      status: snapshot['status'],
      profileUrl: snapshot['profileUrl'],
      password: snapshot['password'],
    );
  }

  Map<String, dynamic> toDocument() => {
        "name": name,
        "email": email,
        "uid": uid,
        "status": status,
        "profileUrl": profileUrl,
        "password": password,
      };
}
