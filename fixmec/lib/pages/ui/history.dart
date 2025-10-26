import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chtabot.dart';

class ChatHistoryPage extends StatelessWidget {
  const ChatHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final loc = Provider.of<LocalizationService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('history_chats'))),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('userId', isEqualTo: user?.uid ?? "anon")
            .where('createdAt', isNotEqualTo: null)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final chats = snapshot.data!.docs;

          if (chats.isEmpty) {
            return const Center(child: Text("Aún no hay chats"));
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              final title = chat['title'] ?? "Chat sin título";
              final date = (chat['createdAt'] as Timestamp?)?.toDate();

              return Dismissible(
                key: Key(chat.id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) async {
                  await FirebaseFirestore.instance
                      .collection('chats')
                      .doc(chat.id)
                      .delete();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Chat eliminado')),
                    );
                  }
                },
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(
                    date != null
                        ? "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}"
                        : "Sin fecha",
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatbotFixMec(
                          chatId: chat.id,
                          currentIndex: 1,
                          isDark: false,
                          onThemeChanged: (_) {},
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
