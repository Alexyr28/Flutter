import 'dart:convert';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
//import 'package:markdown_widget/markdown_widget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChatbotFixMec extends StatefulWidget {
  final int currentIndex;
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  const ChatbotFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    this.currentIndex = 1,
  });

  @override
  State<ChatbotFixMec> createState() => _ChatbotFixMecState();
}

class _ChatbotFixMecState extends State<ChatbotFixMec> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _message = [];
  bool _isloading = false;

  Future<void> sendMessage(String text) async {
    final mechanicPrompt = Provider.of<LocalizationService>(
      context,
      listen: false,
    ).translate("mechanic");
    final serverPrompt = Provider.of<LocalizationService>(
      context,
      listen: false,
    ).translate("server");
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
        setState(() {
          _message.add({"sender": "bot", "text": reply});
        });
      } else {
        setState(() {
          _message.add({
            "sender": "bot",
            //"text": "Error: ${response.statusCode}\n${response.body}",
            "text": serverPrompt,
          });
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
                    // child: MarkdownWidget(
                    //   data: msg["text"] ?? '',
                    //   shrinkWrap: true,
                    //   config: MarkdownConfig(
                    //     configs: [
                    //       PConfig(
                    //         textStyle: TextStyle(
                    //           color: isUser ? Colors.white : Colors.black,
                    //           fontFamily: "MiFuente",
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                      hintStyle: TextStyle(
                        fontFamily: "MiFuente",
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(),
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
