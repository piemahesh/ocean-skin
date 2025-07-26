import 'dart:io';

import '../../../core/services/hive_service.dart';
import '../../../core/models/message.dart';
import '../../../core/utils/url_utils.dart';
import '../../../core/services/meta_service.dart';
import 'package:uuid/uuid.dart';

class ChatRepository {
  final HiveService _hiveService = HiveService();

  Future<ChatMessage> handleMetaAndStore(ChatMessage message) async {
    final urls = extractUrls(message.text);
    var newMessage = message;
    if (urls.isNotEmpty) {
      final meta = await MetaService.fetchMeta(urls.first);
      if (meta != null) {
        newMessage = message.copyWith(linkMeta: meta);
      }
    }
    await _hiveService.saveMessage(newMessage);
    return newMessage;
  }

  Future<void> sendToFirebase(ChatMessage message) async {
    // Send to Firebase Realtime DB
    // (Add Firebase logic here)
  }

  Future<List<ChatMessage>> fetchAndSyncMessages(
    DateTime? lastTimestamp,
  ) async {
    // Fetch newest 10 from Firebase after lastTimestamp; store to Hive
    // Return all messages from Hive
    return _hiveService.getAllMessages();
  }

  Future<void> deleteMessage(String messageId) async {
    await _hiveService.deleteMessage(messageId);
    // Also update Firebase for real-time deletion
  }

  Future<String> uploadImage(File file) async {
    return "";
    // Use firebase_storage to upload & retrieve URL.
  }

  Future<void> sendMediaMessage(
    String text,
    File? imageFile,
    String senderId,
  ) async {
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await uploadImage(imageFile);
    }
    final message = ChatMessage(
      id: Uuid().v4(),
      text: text,
      senderId: senderId,
      timestamp: DateTime.now(),
      imageUrl: imageUrl,
      // linkMeta auto-filled if any
    );
    await handleMetaAndStore(message);
    await sendToFirebase(message);
  }
}
