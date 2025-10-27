import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatHistoryPage extends StatelessWidget {
  const ChatHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final loc = Provider.of<LocalizationService>(context);

    return Scaffold(
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
            return Center(child: Text(loc.translate('there_are_no_chats_yet')));
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              final title =
                  chat['title'] ?? loc.translate('chat_without_titles');
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
                      SnackBar(content: Text(loc.translate('chat_deleted'))),
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
