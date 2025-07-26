import '../../../core/models/user.dart';
import '../../../core/services/hive_service.dart';

class AdminRepository {
  final HiveService _hiveService = HiveService();

  Future<List<AppUser>> getAllUsers() async {
    // Fetch all from Firebase; store to Hive
    // For now, get from Hive
    return _hiveService.getAllUsers();
  }

  Future<void> updateUser(AppUser user) async {
    await _hiveService.saveUser(user);
    // Push to Firebase DB as well
  }

  // Blocking
  Future<void> blockUser(String userId) async {
    final user = await _hiveService.getUser(userId);
    if (user != null) {
      final updated = user.copyWith(isBlocked: true, canPost: false);
      await updateUser(updated);
    }
  }

  // Grant/revoke post access
  Future<void> setPostingAccess(String userId, bool canPost) async {
    final user = await _hiveService.getUser(userId);
    if (user != null) {
      await updateUser(user.copyWith(canPost: canPost));
    }
  }

  // CSV Download
  Future<String> exportUsersAsCsv() async {
    final users = await getAllUsers();
    final buffer = StringBuffer(
      'id,email,role,name,avatarUrl,phone,dob,isBlocked,canPost\n',
    );
    for (final u in users) {
      buffer.writeln(
        '${u.id},${u.email},${u.role},${u.name ?? ''},${u.avatarUrl ?? ''},'
        '${u.phone ?? ''},${u.dob ?? ''},'
        '${u.isBlocked},${u.canPost}',
      );
    }
    return buffer.toString();
  }
}
