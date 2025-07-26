import 'package:hive/hive.dart';
import '../models/user.dart';
import '../models/message.dart';
import '../models/link_meta.dart';

class HiveService {
  static const userBoxName = 'userBox';
  static const messageBoxName = 'messageBox';

  /// Initialize Hive adapters and open boxes
  Future<void> init() async {
    // Register adapters if not already registered
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(AppUserAdapter());
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ChatMessageAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(LinkMetaAdapter());

    // Open boxes if not already open
    if (!Hive.isBoxOpen(userBoxName)) {
      await Hive.openBox<AppUser>(userBoxName);
    }
    if (!Hive.isBoxOpen(messageBoxName)) {
      await Hive.openBox<ChatMessage>(messageBoxName);
    }
  }

  /// User CRUD operations

  Future<void> saveUser(AppUser user) async {
    final box = Hive.box<AppUser>(userBoxName);
    await box.put(user.id, user);
  }

  AppUser? getUser(String userId) {
    final box = Hive.box<AppUser>(userBoxName);
    return box.get(userId);
  }

  Future<List<AppUser>> getAllUsers() async {
    final box = Hive.box<AppUser>(userBoxName);
    return box.values.toList();
  }

  Future<void> deleteUser(String userId) async {
    final box = Hive.box<AppUser>(userBoxName);
    await box.delete(userId);
  }

  Future<void> clearUsers() async {
    final box = Hive.box<AppUser>(userBoxName);
    await box.clear();
  }

  /// Message CRUD operations (placeholders, expand as needed)

  Future<void> saveMessage(ChatMessage message) async {
    final box = Hive.box<ChatMessage>(messageBoxName);
    await box.put(message.id, message);
  }

  ChatMessage? getMessage(String messageId) {
    final box = Hive.box<ChatMessage>(messageBoxName);
    return box.get(messageId);
  }

  Future<List<ChatMessage>> getAllMessages() async {
    final box = Hive.box<ChatMessage>(messageBoxName);
    return box.values.toList();
  }

  Future<void> deleteMessage(String messageId) async {
    final box = Hive.box<ChatMessage>(messageBoxName);
    await box.delete(messageId);
  }

  Future<void> clearMessages() async {
    final box = Hive.box<ChatMessage>(messageBoxName);
    await box.clear();
  }
}
