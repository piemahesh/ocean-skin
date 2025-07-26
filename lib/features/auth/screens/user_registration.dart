import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_chat/features/auth/bloc/auth_bloc.dart';

class UserRegistrationScreen extends StatefulWidget {
  final String email, password, username;
  const UserRegistrationScreen(
    this.email,
    this.password,
    this.username, {
    super.key,
  });

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _nameController = TextEditingController();

  void _next() {
    context.read<AuthBloc>().add(
      RegistrationDetailsProvided(
        phone: _phoneController.text,
        dob: _dobController.text,
        name: _nameController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Details')),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _next, child: Text('Next')),
          ],
        ),
      ),
    );
  }
}
