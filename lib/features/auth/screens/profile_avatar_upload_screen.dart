import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_chat/features/auth/bloc/auth_bloc.dart';

class ProfileAvatarUploadScreen extends StatelessWidget {
  final String email, password, username, phone, dob, name;
  const ProfileAvatarUploadScreen(
    this.email,
    this.password,
    this.username,
    this.phone,
    this.dob,
    this.name, {
    super.key,
  });

  void _skipOrUpload(BuildContext context, String? avatarPath) {
    context.read<AuthBloc>().add(AvatarUploaded(avatarPath: avatarPath));
  }

  @override
  Widget build(BuildContext context) {
    // Use image_picker or other package to let user pick image or skip
    return Scaffold(
      appBar: AppBar(title: Text('Upload Avatar')),
      body: Center(
        child: Column(
          children: [
            // Display avatar preview if picked
            // RaisedButton to pick image
            // Or, skip
            ElevatedButton(
              onPressed: () => _skipOrUpload(context, null),
              child: Text('Skip'),
            ),
          ],
        ),
      ),
    );
  }
}
