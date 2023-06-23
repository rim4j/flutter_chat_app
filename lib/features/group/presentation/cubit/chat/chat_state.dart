part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatSuccess extends ChatState {
  final List<TextMessageEntity> messages;

  const ChatSuccess({
    required this.messages,
  });

  @override
  List<Object?> get props => [messages];
}

class ChatFailed extends ChatState {
  @override
  List<Object?> get props => [];
}
