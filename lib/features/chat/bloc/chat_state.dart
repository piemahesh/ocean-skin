// chat_state.dart
part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  /* ... */
}

class ChatInitial extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;
  ChatLoaded(this.messages);
  @override
  List<Object?> get props => [messages];
}

class ChatMessageSent extends ChatState {
  final ChatMessage message;
  ChatMessageSent(this.message);
  @override
  List<Object?> get props => [message];
}

class MessageDeleted extends ChatState {
  final String messageId;
  MessageDeleted(this.messageId);
  @override
  List<Object?> get props => [messageId];
}
