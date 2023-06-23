import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/config/theme/app_styles.dart';
import 'package:flutter_chat_app/config/theme/app_themes.dart';
import 'package:flutter_chat_app/core/constants/constants.dart';
import 'package:flutter_chat_app/features/group/domain/entities/group_entity.dart';

import 'package:flutter_chat_app/features/group/domain/entities/single_chat_entity.dart';
import 'package:flutter_chat_app/features/group/domain/entities/text_message_entitiy.dart';
import 'package:flutter_chat_app/features/group/presentation/cubit/chat/chat_cubit.dart';
import 'package:flutter_chat_app/features/group/presentation/cubit/group/group_cubit.dart';
import 'package:flutter_chat_app/features/user/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class SingleChatPage extends StatefulWidget {
  final SingleChatEntity singleChatEntity;

  const SingleChatPage({
    Key? key,
    required this.singleChatEntity,
  }) : super(key: key);

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context)
        .getMessages(channelId: widget.singleChatEntity.groupId);

    // _messageController.addListener(() {
    //   setState(() {});
    // });

    //scroll to bottom default
    Timer(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: customAppBar(title: widget.singleChatEntity.groupName),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, chatState) {
          if (chatState is ChatSuccess) {
            final List<TextMessageEntity> messages = chatState.messages;

            return Column(
              children: [
                _messageList(messages),
                _sendMessageTextField(),
              ],
            );
          }

          return const Center(
            child: SpinKitThreeBounce(
              color: AppColors.blueColor,
              size: 50,
            ),
          );
        },
      ),
    );
  }

  Widget _messageWidget({
    required String text,
    required String time,
    required Color color,
    required TextAlign align,
    required CrossAxisAlignment boxAlign,
    required CrossAxisAlignment crossAlign,
    required String name,
    required TextAlign alignName,
    required BubbleNip nip,
  }) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.90,
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(3),
            child: Bubble(
              color: color,
              nip: nip,
              child: Column(
                crossAxisAlignment: crossAlign,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    textAlign: alignName,
                    style: fEncodeSansBold.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  sizeVer(5),
                  Text(
                    text,
                    textAlign: align,
                    style: fEncodeSansMedium.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  sizeVer(5),
                  Text(
                    time,
                    textAlign: align,
                    style: fEncodeSansRegular.copyWith(
                      color: AppColors.darkGreyColor,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Expanded _messageList(List<TextMessageEntity> messages) {
    if (_scrollController.hasClients) {
      Timer(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    }

    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final TextMessageEntity message = messages[index];

          if (message.senderId == widget.singleChatEntity.uid) {
            return _messageWidget(
              name: "Me",
              alignName: TextAlign.end,
              color: AppColors.backGroundColorBottomNav,
              time: DateFormat('hh:mm a').format(message.time!.toDate()),
              align: TextAlign.left,
              nip: BubbleNip.rightTop,
              boxAlign: CrossAxisAlignment.start,
              crossAlign: CrossAxisAlignment.end,
              text: message.content!,
            );
          } else {
            return _messageWidget(
              color: AppColors.darkGreyColor.withOpacity(0.4),
              nip: BubbleNip.leftTop,
              name: "${message.senderName}",
              alignName: TextAlign.end,
              time: DateFormat('hh:mm a').format(message.time!.toDate()),
              align: TextAlign.left,
              boxAlign: CrossAxisAlignment.start,
              crossAlign: CrossAxisAlignment.start,
              text: message.content!,
            );
          }
        },
      ),
    );
  }

  _sendMessageTextField() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.backGroundColorBottomNav,
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                ),
                child: Row(
                  children: [
                    sizeHor(10),
                    const Icon(
                      Icons.insert_emoticon,
                      color: AppColors.secondaryColor,
                    ),
                    sizeHor(10),
                    Expanded(
                      child: Container(
                        height: 60,
                        constraints: const BoxConstraints(maxHeight: 60),
                        child: Scrollbar(
                          child: Center(
                            child: TextField(
                              style: fEncodeSansMedium.copyWith(
                                color: AppColors.primaryColor,
                              ),
                              controller: _messageController,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message",
                                hintStyle: fEncodeSansMedium.copyWith(
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    sizeHor(15),
                  ],
                ),
              ),
            ),
            sizeHor(10),
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.blueColor,
              child: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.paperPlane,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {
                  _sendMessage();
                },
              ),
            ),
            sizeHor(5),
          ],
        ),
      ),
    );
  }

  void _clear() {
    setState(() {
      _messageController.clear();
    });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      BlocProvider.of<ChatCubit>(context)
          .sendTextMessage(
        textMessageEntity: TextMessageEntity(
          time: Timestamp.now(),
          content: _messageController.text,
          senderName: widget.singleChatEntity.username,
          senderId: widget.singleChatEntity.uid,
          type: "TEXT",
        ),
        channelId: widget.singleChatEntity.groupId,
      )
          .then((value) {
        BlocProvider.of<GroupCubit>(context).updateGroup(
          groupEntity: GroupEntity(
            groupId: widget.singleChatEntity.groupId,
            lastMessage: _messageController.text,
            createAt: Timestamp.now(),
          ),
        );
        _clear();
      });
    }
  }
}
