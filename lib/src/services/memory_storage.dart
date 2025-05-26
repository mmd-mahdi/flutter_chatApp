import '../models/user_model.dart';
import '../models/message_model.dart';

class MemoryStorage {
  static final MemoryStorage _instance = MemoryStorage._internal();
  factory MemoryStorage() => _instance;
  MemoryStorage._internal();

  final List<UserModel> _contacts = [];
  final List<MessageModel> _messages = [];

  void addContact(UserModel contact) {
    if (!_contacts.any((c) => c.id == contact.id)) {
      _contacts.add(contact);
    }
  }

  List<UserModel> getContacts() => _contacts;

  void addMessage(MessageModel message) {
    _messages.add(message);
  }

  List<MessageModel> getMessages(String userId, String receiverId) {
    return _messages.where((m) =>
    (m.senderId == userId && m.receiverId == receiverId) ||
        (m.senderId == receiverId && m.receiverId == userId)).toList();
  }
}