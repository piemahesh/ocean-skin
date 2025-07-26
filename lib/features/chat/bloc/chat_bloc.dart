import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/chat_repository.dart';
import '../../../core/models/message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repo;
  ChatBloc(this._repo) : super(ChatInitial()) {
    on<SendChatMessage>((event, emit) async {
      emit(ChatLoading());
      final msg = await _repo.handleMetaAndStore(event.message); // Handles meta
      await _repo.sendToFirebase(msg);
      emit(ChatMessageSent(msg));
    });

    on<FetchChatMessages>((event, emit) async {
      emit(ChatLoading());
      final msgs = await _repo.fetchAndSyncMessages(event.lastTimestamp);
      emit(ChatLoaded(msgs));
    });

    on<DeleteMessage>((event, emit) async {
      await _repo.deleteMessage(event.messageId);
      emit(MessageDeleted(event.messageId));
    });
  }
}
