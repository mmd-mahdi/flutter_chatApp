import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/message_model.dart';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String id, String email, String displayName) async {
    await _firestore.collection('users').doc(id).set({
      'email': email,
      'displayName': displayName,
    });
  }

  Future<void> addMessage(String senderId, String receiverId, String content) async {
    await _firestore.collection('messages').add({
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<UserModel>> getContacts(String userId) async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs
        .where((doc) => doc.id != userId)
        .map((doc) => UserModel(
      id: doc.id,
      email: doc['email'],
      displayName: doc['displayName'],
    ))
        .toList();
  }

  Stream<List<MessageModel>> getMessages(String userId, String receiverId) {
    return _firestore
        .collection('messages')
        .where('senderId', whereIn: [userId, receiverId])
        .where('receiverId', whereIn: [userId, receiverId])
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MessageModel(
      id: doc.id,
      senderId: doc['senderId'],
      receiverId: doc['receiverId'],
      content: doc['content'],
      timestamp: (doc['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    ))
        .toList());
  }
}