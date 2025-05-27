import 'package:flutter/material.dart';
import '../chat/chat_screen.dart';
import '../add_contact/add_contact_screen.dart';
import '../../models/user_model.dart';
import '../../services/database_service.dart';
import '../../widgets/animated_floating_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final databaseService = DatabaseService();

    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: FutureBuilder<List<UserModel>>(
        future: databaseService.getChattedContacts(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final contacts = snapshot.data ?? [];
          if (contacts.isEmpty) {
            return const Center(child: Text('No chats yet. Start a new conversation!'));
          }
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ListTile(
                leading: CircleAvatar(child: Text(contact.displayName[0])),
                title: Text(contact.displayName),
                subtitle: const Text('Last message...'), // Placeholder
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(receiver: contact),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: AnimatedFloatingButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddContactScreen()),
        ),
      ),
    );
  }
}