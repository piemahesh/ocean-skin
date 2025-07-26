import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../core/models/user.dart';
import '../../../core/services/hive_service.dart';

class ProfileRepository {
  final HiveService _hiveService = HiveService();

  Future<AppUser?> getProfile(String userId) async {
    return _hiveService.getUser(userId);
  }

  Future<void> updateProfile(AppUser updatedUser) async {
    await _hiveService.saveUser(updatedUser);
    // Update in Firebase DB (provide method to sync with your backend)
  }

  Future<String?> uploadAvatar(File file, String userId) async {
    final storageRef = FirebaseStorage.instance.ref('avatars/$userId.jpg');
    await storageRef.putFile(file);
    return await storageRef.getDownloadURL();
  }

  Future<void> updateAvatar(AppUser user, File avatarFile) async {
    final avatarUrl = await uploadAvatar(avatarFile, user.id);
    final updatedUser = user.copyWith(avatarUrl: avatarUrl);
    await _hiveService.saveUser(updatedUser);
    // Sync to Firebase profile as well
  }
}
