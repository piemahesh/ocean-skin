import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:hive/hive.dart';
import 'package:skin_chat/core/models/roles.dart';
import 'package:skin_chat/core/models/user.dart';
import 'package:skin_chat/core/services/hive_service.dart';

class AuthRepository {
  final fb_auth.FirebaseAuth _fbAuth = fb_auth.FirebaseAuth.instance;
  final HiveService _hiveService = HiveService();

  // Email/password login
  Future<AppUser> login(String email, String password) async {
    final creds = await _fbAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Fetch user profile from your Firebase DB here by creds.user!.uid
    // For simplicity, fake local user
    final user = AppUser(
      id: creds.user!.uid,
      email: email,
      role: UserRole.candidate,
      isBlocked: false,
      canPost: false,
    );
    // await _hiveService.saveUser(user);
    return user;
  }

  // Registration
  Future<AppUser> register(
    String email,
    String password,
    String username, {
    required String phone,
    required String dob,
    String? name,
  }) async {
    final creds = await _fbAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Save full-profile to Firebase DB (not auth)...
    final user = AppUser(
      id: creds.user!.uid,
      email: email,
      role: UserRole.candidate,
      name: name ?? username,
      phone: phone,
      dob: dob,
      isBlocked: false,
      canPost: false,
    );
    // await _hiveService.saveUser(user);
    return user;
  }

  // OAuth login (e.g., Google)
  Future<AppUser?> signInWithGoogle() async {
    // Use GoogleSignIn package... then
    // Check if email exists in DB, if yes: login; else: proceed with registration
    return null; // implement later
  }

  // Logout
  Future<void> logout() async {
    await _fbAuth.signOut();
    final box = Hive.box<AppUser>(HiveService.userBoxName);
    await box.clear();
  }

  // Get current user
  Future<AppUser?> currentUser() async {
    final box = Hive.box<AppUser>(HiveService.userBoxName);
    if (box.isEmpty) return null;
    return box.values.first;
  }
}
