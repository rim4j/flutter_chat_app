import 'package:flutter_chat_app/features/group/domain/entities/text_message_entitiy.dart';
import 'package:flutter_chat_app/features/group/domain/repositories/group_repsitory.dart';

class SendTextMessageUseCase {
  final GroupRepository groupRepository;

  SendTextMessageUseCase({
    required this.groupRepository,
  });

  Future<void> call(
    TextMessageEntity textMessageEntity,
    String channelId,
  ) {
    return groupRepository.sendTextMessage(textMessageEntity, channelId);
  }
}
