import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_chat_app/features/group/domain/entities/text_message_entitiy.dart';
import 'package:flutter_chat_app/features/group/domain/use_cases/get_messages_usecase.dart';
import 'package:flutter_chat_app/features/group/domain/use_cases/sent_text_message_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;

  ChatCubit({
    required this.sendTextMessageUseCase,
    required this.getMessagesUseCase,
  }) : super(ChatInitial());

  Future<void> getMessages({required String channelId}) async {
    emit(ChatLoading());

    try {
      final streamRes = getMessagesUseCase(channelId);
      streamRes.listen((messages) {
        emit(ChatSuccess(messages: messages));
      });
    } on SocketException catch (_) {
      emit(ChatFailed());
    } catch (_) {
      emit(ChatFailed());
    }
  }

  Future<void> sendTextMessage({
    required TextMessageEntity textMessageEntity,
    required String channelId,
  }) async {
    try {
      await sendTextMessageUseCase(textMessageEntity, channelId);
    } on SocketException catch (_) {
      emit(ChatFailed());
    } catch (_) {
      emit(ChatFailed());
    }
  }
}
