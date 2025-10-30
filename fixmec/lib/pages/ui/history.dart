import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatHistoryPage extends StatefulWidget {
  final ValueChanged<int> onIndexChanged;
  final int currentIndex;
  final ValueChanged<String>? onChatSelected;

  const ChatHistoryPage({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
    this.onChatSelected,
  });

  @override
  State<ChatHistoryPage> createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> {
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
            return Center(
              child: Text(
                loc.translate('there_are_no_chats_yet'),
                style: TextStyle(
                  fontFamily: "MiFuente",
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
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
                      SnackBar(
                        content: Text(
                          loc.translate('chat_deleted'),
                          style: TextStyle(
                            fontFamily: "MiFuente",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: ListTile(
                  title: Text(
                    title,
                    style: TextStyle(
                      fontFamily: "MiFuente",
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    date != null
                        ? "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}"
                        : "Sin fecha",
                    style: TextStyle(
                      fontFamily: "MiFuente",
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
                  //Moverse a la pagina del chat y pasar el ID
                  onTap: () => {
                    if (widget.onChatSelected != null)
                      {widget.onChatSelected!(chat.id)},
                    widget.onIndexChanged(1),
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
