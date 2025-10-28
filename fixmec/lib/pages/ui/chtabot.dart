import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChatbotFixMec extends StatefulWidget {
  final int currentIndex;
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final String? chatId; // id de los chats existentes

  const ChatbotFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    this.currentIndex = 1,
    this.chatId,
  });

  @override
  State<ChatbotFixMec> createState() => _ChatbotFixMecState();
}

class _ChatbotFixMecState extends State<ChatbotFixMec> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _message = [];
  bool _isloading = false;
  String? _chatId;

  @override
  void didUpdateWidget(covariant ChatbotFixMec oldWidget) {
    super.didUpdateWidget(oldWidget);

    //Si se cambia el chatID, se recargarán los mensajes
    if (widget.chatId != oldWidget.chatId) {
      setState(() {
        _chatId = widget.chatId;
        _message.clear();
      });

      if (_chatId != null) {
        _loadMessages();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.chatId != null) {
      _chatId = widget.chatId;
      _loadMessages();
    }
  }

  // si hay chats, cargarlos desde firebase (buscar por chatId)
  Future<void> _loadMessages() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('chats')
        .doc(_chatId)
        .collection('messages')
        .orderBy('createdAt')
        .get();

    setState(() {
      _message.clear();
      for (var doc in snapshot.docs) {
        _message.add({"sender": doc['sender'], "text": doc['text']});
      }
    });
  }

  Future<void> sendMessage(String text) async {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    final mechanicPrompt = loc.translate("mechanic");
    final serverPrompt = loc.translate("server");
    final user = FirebaseAuth.instance.currentUser;

    // Si el chat no existe aún, crear uno nuevo
    if (_chatId == null) {
      final newChat = await FirebaseFirestore.instance.collection('chats').add({
        "userId": user?.uid ?? "anon",
        "title": text.length > 25 ? text.substring(0, 25) : text,
        "createdAt": FieldValue.serverTimestamp(),
      });
      _chatId = newChat.id;
    }

    // Guardar lo que se consulto del usuario
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(_chatId)
        .collection('messages')
        .add({
          "sender": "user",
          "text": text,
          "createdAt": FieldValue.serverTimestamp(),
        });

    setState(() {
      _message.add({"sender": "user", "text": text});
      _isloading = true;
    });
    _controller.clear();

    try {
      final response = await http.post(
        Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyDuAqmj-ia018u0FM0Yf8_eg4yynY9sHXs",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": mechanicPrompt},
                {"text": text},
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data["candidates"][0]["content"]["parts"][0]["text"];

        // Guardar respuesta del bot
        await FirebaseFirestore.instance
            .collection('chats')
            .doc(_chatId)
            .collection('messages')
            .add({
              "sender": "bot",
              "text": reply,
              "createdAt": FieldValue.serverTimestamp(),
            });

        setState(() {
          _message.add({"sender": "bot", "text": reply});
        });
      } else {
        setState(() {
          _message.add({"sender": "bot", "text": serverPrompt});
        });
      }
    } catch (e) {
      setState(() {
        _message.add({"sender": "bot", "text": "Error: $e"});
      });
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _message.length,
              itemBuilder: (context, index) {
                final msg = _message[index];
                final isUser = msg["sender"] == "user";
                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 10,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color(0xFF00B4DB)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: MarkdownBody(
                      data: msg["text"]!,
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(
                          color: isUser ? Colors.white : Colors.black,
                          fontFamily: "MiFuente",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isloading)
            const LinearProgressIndicator(color: Color(0xFF00B4DB)),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: Provider.of<LocalizationService>(
                        context,
                      ).translate("write"),
                      hintStyle: const TextStyle(
                        fontFamily: "MiFuente",
                        fontWeight: FontWeight.bold,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                    }
                  },
                  icon: const Icon(
                    Icons.send_outlined,
                    color: Color(0xFF00B4DB),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
