import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/admin_bloc.dart';
import '../../../core/models/user.dart';
import '../repository/admin_repository.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminBloc(AdminRepository())..add(LoadUsers()),
      child: Scaffold(
        appBar: AppBar(title: Text('User Management')),
        body: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is AdminLoading)
              return Center(child: CircularProgressIndicator());
            if (state is UsersLoaded) {
              final users = state.users;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, i) {
                  final user = users[i];
                  return Card(
                    child: ListTile(
                      title: Text('${user.name ?? user.email} (${user.role})'),
                      subtitle: Text(
                        'Blocked: ${user.isBlocked} | Can Post: ${user.canPost}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.block),
                            onPressed: () {
                              context.read<AdminBloc>().add(BlockUser(user.id));
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              user.canPost
                                  ? Icons.remove_circle
                                  : Icons.check_circle,
                            ),
                            onPressed: () {
                              context.read<AdminBloc>().add(
                                SetPostingAccess(user.id, !user.canPost),
                              );
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        // Show user detail dialog, allow grant/revoke/block.
                      },
                    ),
                  );
                },
              );
            }
            return Center(child: Text('No users found'));
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.download),
          onPressed: () {
            context.read<AdminBloc>().add(ExportCsv());
          },
        ),
      ),
    );
  }
}
