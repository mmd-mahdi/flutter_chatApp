import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/database_service.dart';
import '../../utils/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  late AnimationController _controller;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _addContact() async {
    if (_emailController.text.isNotEmpty) {
      try {
        final query = await _firestore
            .collection('users')
            .where('email', isEqualTo: _emailController.text.trim())
            .get();
        if (query.docs.isNotEmpty) {
          final user = query.docs.first;
          await DatabaseService().addUser(
            user.id,
            user['email'],
            user['displayName'],
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not found')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SlideAnimation(
              controller: _controller,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Contact Email'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addContact,
              child: const Text('Add Contact'),
            ),
          ],
        ),
      ),
    );
  }
}