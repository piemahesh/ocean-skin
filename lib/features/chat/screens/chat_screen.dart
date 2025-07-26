import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_chat/features/chat/widgets/link_preview_widget.dart';
import '../bloc/chat_bloc.dart';
import '../../../core/models/message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ChatLoaded) {
          final messages = state.messages;
          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, i) {
              final msg = messages[i];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(msg.text),
                  if (msg.linkMeta != null)
                    LinkPreviewWidget(meta: msg.linkMeta!),
                  // Optionally, show delete icon if within 1hr and user has rights
                ],
              );
            },
          );
        }
        return Center(child: Text('No messages yet.'));
      },
    );
  }
}
