import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final DateTime timestamp;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.timestamp,
  });

  String _formatTimestamp(DateTime timestamp) {
    final hour = timestamp.hour % 12 == 0 ? 12 : timestamp.hour % 12;
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = timestamp.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  bool _isPersian(String text) {
    // Simple check for Persian characters (Unicode range U+0600 to U+06FF)
    return text.runes.any((rune) => rune >= 0x0600 && rune <= 0x06FF);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue[200] : Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Directionality(
                textDirection: _isPersian(message) ? TextDirection.rtl : TextDirection.ltr,
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                _formatTimestamp(timestamp),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}