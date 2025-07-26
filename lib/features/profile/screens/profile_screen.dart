import 'dart:io';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_chat/core/services/hive_service.dart';
import '../bloc/profile_bloc.dart';
import '../../../core/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  File? _pickedAvatar;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get current user from local Hive box
    final box = Hive.box<AppUser>(HiveService.userBoxName);
    final currentUser = box.values.isNotEmpty
        ? box.values.first
        : null; // adjust as needed

    if (currentUser != null) {
      final userId = currentUser.id;
      context.read<ProfileBloc>().add(LoadProfile(userId));
    } else {
      // Handle no user found (optional)
    }
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _pickedAvatar = File(picked.path));
    }
  }

  void _saveAvatar(AppUser user) {
    if (_pickedAvatar != null) {
      context.read<ProfileBloc>().add(UpdateAvatar(user, _pickedAvatar!));
    }
  }

  void _updateProfile(AppUser user) {
    final updated = user.copyWith(
      name: _nameController.text,
      phone: _phoneController.text,
      dob: _dobController.text,
      // Add logic for avatar update if needed
    );
    context.read<ProfileBloc>().add(UpdateProfile(updated));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProfileLoaded) {
          final user = state.user;
          _nameController.text = user.name ?? '';
          _phoneController.text = user.phone ?? '';

          _dobController.text = user.dob ?? '';
          return Scaffold(
            appBar: AppBar(title: Text('Profile')),
            body: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  // Avatar picker UI goes here
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: _pickedAvatar != null
                        ? FileImage(_pickedAvatar!)
                        : (user.avatarUrl != null
                                  ? NetworkImage(user.avatarUrl!)
                                  : null)
                              as ImageProvider?,
                    child: user.avatarUrl == null && _pickedAvatar == null
                        ? Icon(Icons.person, size: 48)
                        : null,
                  ),
                  TextButton(
                    onPressed: _pickAvatar,
                    child: Text('Change Avatar'),
                  ),
                  ElevatedButton(
                    onPressed: () => _saveAvatar(user),
                    child: Text('Save Avatar'),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone'),
                  ),
                  TextField(
                    controller: _dobController,
                    decoration: InputDecoration(labelText: 'DOB'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _updateProfile(user),
                    child: Text('Update Profile'),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is ProfileError) {
          return Center(child: Text(state.error));
        }
        return SizedBox.shrink();
      },
    );
  }
}
