import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/bloc/auth_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification Settings'),
            onTap: () {
              // Navigate to notification settings or toggle directly
            },
          ),
          ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text('Privacy & Security'),
            onTap: () {
              // Navigate to privacy screen or show options (block/allow contacts, etc.)
            },
          ),
          ListTile(
            leading: Icon(Icons.cleaning_services),
            title: Text('Clear Local Cache'),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Clear All Chat Data?'),
                  content: Text(
                    'This will remove all locally cached messages.',
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                    TextButton(
                      child: Text('Clear'),
                      onPressed: () {
                        // Call method to clear Hive chatbox here
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Cache cleared')),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            onTap: () {
              // Show app version, contact, etc.
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign Out'),
            onTap: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
        ],
      ),
    );
  }
}
