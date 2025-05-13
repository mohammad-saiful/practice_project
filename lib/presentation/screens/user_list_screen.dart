import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(userProvider.notifier).fetchUsers();
        },
        child: const Icon(Icons.refresh),
      ),
      body:
          userState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : userState.error != null
              ? Center(child: Text('Error: ${userState.error}'))
              : userState.users == null || userState.users!.isEmpty
              ? const Center(child: Text('No users found'))
              : ListView.builder(
                itemCount: userState.users!.length,
                itemBuilder: (context, index) {
                  final user = userState.users![index];
                  return ListTile(
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                  );
                },
              ),
    );
  }
}
