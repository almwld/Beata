import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _chats = [
    {'name': 'محمد أحمد', 'message': 'مرحباً، هل المنتج متوفر؟', 'time': '10:30', 'unread': 2},
    {'name': 'خالد علي', 'message': 'شكراً لك', 'time': '09:15', 'unread': 0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المحادثات')),
      body: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.goldColor.withOpacity(0.2),
              child: Text(chat['name'][0], style: const TextStyle(color: AppTheme.goldColor)),
            ),
            title: Text(chat['name'], style: TextStyle(fontWeight: chat['unread'] > 0 ? FontWeight.bold : FontWeight.normal)),
            subtitle: Text(chat['message'], maxLines: 1),
            trailing: chat['unread'] > 0
                ? Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle),
                    child: Text(chat['unread'].toString(), style: const TextStyle(color: Colors.black, fontSize: 10)),
                  )
                : Text(chat['time'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            onTap: () {},
          );
        },
      ),
    );
  }
}
