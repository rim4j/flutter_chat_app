import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/core/constants/constants.dart';

import 'package:flutter_chat_app/features/group/data/data_sources/remote/group_remote_data_source.dart';
import 'package:flutter_chat_app/features/group/data/models/group_model.dart';
import 'package:flutter_chat_app/features/group/data/models/test_message_model.dart';
import 'package:flutter_chat_app/features/group/domain/entities/group_entity.dart';
import 'package:flutter_chat_app/features/group/domain/entities/text_message_entitiy.dart';

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final FirebaseFirestore firestore;

  GroupRemoteDataSourceImpl({
    required this.firestore,
  });

  @override
  Future<void> getCreateGroup(GroupEntity groupEntity) async {
    final groupCollection =
        firestore.collection(FirebaseCollectionsName.groups);

    final groupId = groupCollection.doc().id;

    groupCollection.doc(groupId).get().then((groupShopShot) async {
      final newGroup = GroupModel(
        uid: groupEntity.uid,
        createAt: groupEntity.createAt,
        groupId: groupId,
        groupName: groupEntity.groupName,
        groupProfileImage: groupEntity.groupProfileImage,
        lastMessage: groupEntity.lastMessage,
      ).toDocument();

      if (!groupShopShot.exists) {
        await groupCollection.doc(groupId).set(newGroup);
        return;
      }

      return;
    });
  }

  @override
  Stream<List<GroupEntity>> getGroups() {
    final groupCollection = firestore.collection("groups");
    return groupCollection
        .orderBy("createAt", descending: true)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((e) => GroupModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) {
    final messagesCollection = firestore
        .collection(FirebaseCollectionsName.groupChatChannel)
        .doc(channelId)
        .collection(FirebaseCollectionsName.messages);

    return messagesCollection.orderBy('time').snapshots().map(
          (querySnap) => querySnap.docs
              .map((e) => TextMessageModel.fromSnapshot(e))
              .toList(),
        );
  }

  @override
  Future<void> sendTextMessage(
    TextMessageEntity textMessageEntity,
    String channelId,
  ) async {
    final messagesCollection = firestore
        .collection(FirebaseCollectionsName.groupChatChannel)
        .doc(channelId)
        .collection(FirebaseCollectionsName.messages);

    final messageId = messagesCollection.doc().id;

    final newTextMessage = TextMessageModel(
      content: textMessageEntity.content,
      senderName: textMessageEntity.senderName,
      senderId: textMessageEntity.senderId,
      recipientId: textMessageEntity.recipientId,
      receiverName: textMessageEntity.receiverName,
      time: textMessageEntity.time,
      messageId: messageId,
      type: "TEXT",
    ).toDocument();

    await messagesCollection.doc(messageId).set(newTextMessage);
  }

  @override
  Future<void> updateGroup(GroupEntity groupEntity) async {
    Map<String, dynamic> groupInformation = {};

    final groupCollection =
        firestore.collection(FirebaseCollectionsName.groups);

    if (groupEntity.groupProfileImage != null &&
        groupEntity.groupProfileImage != "") {
      groupInformation['groupProfileImage'] = groupEntity.groupProfileImage;
    }

    if (groupEntity.createAt != null) {
      groupInformation["createAt"] = groupEntity.createAt;
    }

    if (groupEntity.groupName != null && groupEntity.groupName != "") {
      groupInformation["groupName"] = groupEntity.groupName;
    }

    if (groupEntity.lastMessage != null && groupEntity.lastMessage != "") {
      groupInformation["lastMessage"] = groupEntity.lastMessage;
    }

    return groupCollection.doc(groupEntity.groupId).update(groupInformation);
  }
}
