import 'dart:convert';
import 'package:circular_menu/circular_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:fixmec/widgets/typingdots.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:markdown_widget/markdown_widget.dart';
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
  final ScrollController _scrollController = ScrollController();
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

  void autoScroll() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  //Funcion Eliminar Chat
  Future<void> deleteChat() async {
    if (_chatId != null) {
      final chatRef = FirebaseFirestore.instance
          .collection("chats")
          .doc(_chatId);

      //Borra los mensajes del subcoleccion
      final messages = await chatRef.collection("messages").get();
      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (var doc in messages.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit(); // Borra el mensaje

      //Borra el documento del chat
      await chatRef.delete();
    }

    setState(() {
      _chatId = null;
      _message.clear();
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          Provider.of<LocalizationService>(
            context,
            listen: false,
          ).translate("chatdeleted"),
          style: TextStyle(fontFamily: "MiFuente", fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
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

  //Funcion enviar mensajes
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
    //El Usuario Enviar mensaje
    setState(() {
      _message.add({"sender": "user", "text": text});
      _isloading = true;
      autoScroll();
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
          autoScroll();
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
    final loc = Provider.of<LocalizationService>(context);
    return CircularMenu(
      items: [
        //Nuevo Chat
        CircularMenuItem(
          icon: Icons.chat_rounded,
          color: Colors.indigoAccent,
          onTap: () {
            setState(() {
              _message.clear();
              _chatId = null;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  Provider.of<LocalizationService>(
                    context,
                    listen: false,
                  ).translate("newchat"),
                  style: TextStyle(
                    fontFamily: "MiFuente",
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
        //Elimiar chat
        CircularMenuItem(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: widget.isDark
                    ? const Color(0xFF004E92)
                    : const Color(0xFF00B4DB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Text(
                  loc.translate("clearchat"),
                  style: TextStyle(
                    fontFamily: "MiFuente",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  loc.translate("sureclear"),
                  style: TextStyle(
                    fontFamily: "MiFuente",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      loc.translate("cancel"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "MiFuente",
                        color: widget.isDark
                            ? Colors.grey[400]
                            : const Color.fromARGB(255, 39, 38, 38),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      deleteChat();
                    },
                    child: Text(
                      loc.translate("delete"),
                      style: TextStyle(
                        color: widget.isDark
                            ? Colors.grey[400]
                            : const Color.fromARGB(255, 39, 38, 38),
                        fontWeight: FontWeight.bold,
                        fontFamily: "MiFuente",
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          icon: Icons.delete_forever,
          color: Colors.redAccent,
        ),
        //Informacion chatbot
        CircularMenuItem(
          icon: Icons.info_outline,
          color: Colors.indigo,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "ChatBot FixMec 👨‍🔧",
                  style: TextStyle(
                    fontFamily: "MiFuente",
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ],
      alignment: Alignment.centerLeft,
      radius: 100,
      toggleButtonColor: Color(0xFF00B4DB),
      toggleButtonAnimatedIconData: AnimatedIcons.menu_close,
      toggleButtonSize: 30,
      backgroundWidget: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _message.length,
                itemBuilder: (context, index) {
                  final msg = _message[index];
                  final isUser = msg["sender"] == "user";
                  final safeText = (msg["text"] ?? "").toString();
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
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        child: MarkdownWidget(
                          data: safeText,
                          shrinkWrap: true,
                          config: MarkdownConfig.defaultConfig.copy(
                            configs: [
                              PConfig(
                                textStyle: TextStyle(
                                  color: isUser ? Colors.white : Colors.black,
                                  fontFamily: "MiFuente",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              CodeConfig(
                                style: TextStyle(
                                  fontFamily: 'MiFuente',
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isloading)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Provider.of<LocalizationService>(
                          context,
                        ).translate("typing"),
                        style: TextStyle(
                          fontFamily: "MiFuente",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4),
                      Typingdots(),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1,
                      textInputAction: TextInputAction.newline,
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
      ),
    );
  }
}
