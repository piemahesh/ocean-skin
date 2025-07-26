// chat_event.dart
part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  /* ... */
}

class SendChatMessage extends ChatEvent {
  final ChatMessage message;
  SendChatMessage(this.message);
  @override
  List<Object?> get props => [message];
}

class FetchChatMessages extends ChatEvent {
  final DateTime? lastTimestamp;
  FetchChatMessages({this.lastTimestamp});
  @override
  List<Object?> get props => [lastTimestamp];
}

class DeleteMessage extends ChatEvent {
  final String messageId;
  DeleteMessage(this.messageId);
  @override
  List<Object?> get props => [messageId];
}
