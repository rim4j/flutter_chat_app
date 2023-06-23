import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupEntity extends Equatable {
  final String? groupName;
  final String? groupProfileImage;
  final Timestamp? createAt;
  final String? groupId;
  final String? uid;
  final String? lastMessage;

  const GroupEntity({
    this.groupName,
    this.groupProfileImage,
    this.createAt,
    this.groupId,
    this.uid,
    this.lastMessage,
  });

  @override
  List<Object?> get props => [
        groupName,
        groupProfileImage,
        createAt,
        groupId,
        uid,
        lastMessage,
      ];
}
