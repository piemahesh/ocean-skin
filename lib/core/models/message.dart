import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'link_meta.dart';
part 'message.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class ChatMessage {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final String senderId;
  @HiveField(3)
  final DateTime timestamp;
  @HiveField(4)
  final String? imageUrl;
  @HiveField(10)
  final LinkMeta? linkMeta;

  ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
    this.imageUrl,
    this.linkMeta,
  });

  ChatMessage copyWith({
    String? id,
    String? text,
    String? senderId,
    DateTime? timestamp,
    String? imageUrl,
    LinkMeta? linkMeta,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      senderId: senderId ?? this.senderId,
      timestamp: timestamp ?? this.timestamp,
      imageUrl: imageUrl ?? this.imageUrl,
      linkMeta: linkMeta ?? this.linkMeta,
    );
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
