import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'link_meta.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class LinkMeta {
  @HiveField(0)
  final String url;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String? image;
  LinkMeta({required this.url, this.title, this.description, this.image});
  factory LinkMeta.fromJson(Map<String, dynamic> json) =>
      _$LinkMetaFromJson(json);
  Map<String, dynamic> toJson() => _$LinkMetaToJson(this);
}
