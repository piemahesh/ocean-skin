import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../../../core/models/user.dart';
import '../../../core/services/hive_service.dart';

class AppDrawer extends StatelessWidget {
  final AppUser user; // Pass current user to Drawer for conditional rendering

  const AppDrawer({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name ?? ''),
            accountEmail: Text(user.email),
            currentAccountPicture: user.avatarUrl != null
                ? CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl!))
                : CircleAvatar(child: Icon(Icons.person)),
            decoration: BoxDecoration(color: Colors.teal),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Me Chats'),
            onTap: () {
              GoRouter.of(context).go('/chat');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              GoRouter.of(context).go('/profile');
            },
          ),
          // Only show for superAdmin
          if (user.role == 'superAdmin')
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('User Management'),
              onTap: () {
                GoRouter.of(context).go('/user_management');
              },
            ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              GoRouter.of(context).go('/settings');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Terms & Conditions'),
            onTap: () {
              GoRouter.of(context).go('/terms');
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            onTap: () {
              GoRouter.of(context).go('/about');
            },
          ),
        ],
      ),
    );
  }
}
