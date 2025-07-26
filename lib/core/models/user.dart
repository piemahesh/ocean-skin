import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class AppUser {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String role; // 'superAdmin', 'admin', 'candidate'
  @HiveField(3)
  final String? name;
  @HiveField(4)
  final String? avatarUrl;
  @HiveField(5)
  final String? phone;
  @HiveField(6)
  final String? dob;
  @HiveField(7)
  final bool isBlocked;
  @HiveField(8)
  final bool canPost;

  AppUser({
    required this.id,
    required this.email,
    required this.role,
    this.name,
    this.avatarUrl,
    this.phone,
    this.dob,
    this.isBlocked = false,
    this.canPost = false,
  });

  AppUser copyWith({
    String? id,
    String? email,
    String? role,
    String? name,
    String? avatarUrl,
    String? phone,
    String? dob,
    bool? isBlocked,
    bool? canPost,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      isBlocked: isBlocked ?? this.isBlocked,
      canPost: canPost ?? this.canPost,
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
