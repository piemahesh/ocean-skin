// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_meta.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LinkMetaAdapter extends TypeAdapter<LinkMeta> {
  @override
  final int typeId = 2;

  @override
  LinkMeta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LinkMeta(
      url: fields[0] as String,
      title: fields[1] as String?,
      description: fields[2] as String?,
      image: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LinkMeta obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LinkMetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkMeta _$LinkMetaFromJson(Map<String, dynamic> json) => LinkMeta(
      url: json['url'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$LinkMetaToJson(LinkMeta instance) => <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
    };
