import 'package:flutter_chat_app/features/group/domain/entities/group_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel extends GroupEntity {
  const GroupModel({
    final String? groupName,
    final String? groupProfileImage,
    final String? uid,
    final Timestamp? createAt,
    final String? groupId,
    final String? lastMessage,
  }) : super(
          groupName: groupName,
          createAt: createAt,
          groupId: groupId,
          groupProfileImage: groupProfileImage,
          lastMessage: lastMessage,
          uid: uid,
        );

  factory GroupModel.fromSnapshot(DocumentSnapshot snapshot) {
    return GroupModel(
      groupName: snapshot.get('groupName'),
      createAt: snapshot.get('createAt'),
      groupId: snapshot.get('groupId'),
      groupProfileImage: snapshot.get('groupProfileImage'),
      lastMessage: snapshot.get('lastMessage'),
      uid: snapshot.get('uid'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "groupName": groupName,
      "createAt": createAt,
      "groupId": groupId,
      "groupProfileImage": groupProfileImage,
      "lastMessage": lastMessage,
      "uid": uid,
    };
  }
}
