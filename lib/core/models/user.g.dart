// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppUserAdapter extends TypeAdapter<AppUser> {
  @override
  final int typeId = 0;

  @override
  AppUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppUser(
      id: fields[0] as String,
      email: fields[1] as String,
      role: fields[2] as String,
      name: fields[3] as String?,
      avatarUrl: fields[4] as String?,
      phone: fields[5] as String?,
      dob: fields[6] as String?,
      isBlocked: fields[7] as bool,
      canPost: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AppUser obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.avatarUrl)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.dob)
      ..writeByte(7)
      ..write(obj.isBlocked)
      ..writeByte(8)
      ..write(obj.canPost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      id: json['id'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      name: json['name'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      phone: json['phone'] as String?,
      dob: json['dob'] as String?,
      isBlocked: json['isBlocked'] as bool? ?? false,
      canPost: json['canPost'] as bool? ?? false,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': instance.role,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'phone': instance.phone,
      'dob': instance.dob,
      'isBlocked': instance.isBlocked,
      'canPost': instance.canPost,
    };
