import 'package:fixmec/models/message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fixmec/services/api_service.dart';
// import 'package:fixmec/widgets/appbar.dart';
// import 'package:fixmec/models/message.dart';

class DiagnosisFixMec extends StatefulWidget {
  final int currentIndex;
  final bool isDark;

  final ValueChanged<bool> onThemeChanged;
  const DiagnosisFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    this.currentIndex = 2,
  });

  @override
  State<DiagnosisFixMec> createState() => _DiagnosisFixMec();
}

class _DiagnosisFixMec extends State<DiagnosisFixMec> {
  final List<Message> messages = [];
  Map<String, String> respuestas = {};
  List<String> options = [];
  bool isResetting = false;
  final ScrollController scrollController = ScrollController();
  bool loading = false;
  String? currentKey;
  @override
  void initState() {
    super.initState();
    loadInitial();
  }

  // Con esta funcion obtenemos el mensaje inicial que traemos del APIService
  // Para luego indicar las opciones que el usuario puede seleccionar
  Future<void> loadInitial() async {
    setState(() => loading = true);
    final data = await ApiService.getInitial();
    setState(() {
      currentKey = data['key'];
      messages.add(Message(text: data['text'], isUser: false));
      options = List<String>.from(data['options'] ?? []);
      loading = false;
      scrollToBottom();
    });
  }

  // Esta funcion se ejecuta cuando el usuario selecciona una de las opciones
  Future<void> onOptionSelected(String option) async {
    // Añadimos la respuesta del usuario
    setState(() {
      messages.add(Message(text: option, isUser: true));
      options = [];
      loading = true;
      scrollToBottom();
    });
    respuestas[currentKey!] = option;

    // Llamamos al servicio API para enviar la respuesta del usuario
    final data = await ApiService.sendAnswer({currentKey!: option});

    setState(() {
      if (data['type'] == 'question') {
        currentKey = data['key'];
        messages.add(Message(text: data['text'], isUser: false));
        options = List<String>.from(data['options'] ?? []);
      } else if (data['type'] == 'diagnosis') {
        messages.add(Message(text: data['text'], isUser: false));
        options = [];
      } else {
        messages.add(
          Message(text: 'Error: Tipo de respuesta desconocido.', isUser: false),
        );
      }
      loading = false;
      scrollToBottom();
    });
  }

  // Esta funcion es el scroll automatico hacia el final de la lista de mensajes
  Future<void> scrollToBottom() async {
    Future.delayed(const Duration(seconds: 1), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 3),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> resetDiagnosis() async {
    if (isResetting) return; // Evita llamadas concurrentes
    isResetting = true;

    if (mounted) {
      setState(() {
        loading = true;
      });
    }

    try {
      if (mounted) {
        // Limpiamos el estado actual antes de reiniciar.
        setState(() {
          messages.clear();
          options = [];
          respuestas.clear();
          currentKey = null;
        });
      }
      Future.delayed(const Duration(milliseconds: 50), () {
        if (scrollController.hasClients) {
          scrollController.jumpTo(0);
        }
      });

      final data = await ApiService.getInitial();

      if (mounted) {
        setState(() {
          currentKey = data['key'];
          messages.add(Message(text: data['text'], isUser: false));
          options = List<String>.from(data['options'] ?? []);
          loading = false;
          scrollToBottom();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          messages.add(
            Message(
              text: 'Error al reiniciar el diagnóstico: $e',
              isUser: false,
            ),
          );
          loading = false;
        });
      }
    } finally {
      isResetting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: resetDiagnosis,
        backgroundColor: const Color(0xFF00B4DB),
        child: const Icon(Icons.refresh),
      ),

      body: SafeArea(
        child: Column(
          children: [
            if (options.isNotEmpty)
              Container(
                height: 60,
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: ScrollConfiguration(
                  behavior: const MaterialScrollBehavior().copyWith(
                    dragDevices: {...PointerDeviceKind.values},
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: options.map((opt) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: ElevatedButton(
                            onPressed: () => onOptionSelected(opt),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00B4DB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                            ),
                            child: Text(opt),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                itemBuilder: (context, index) =>
                    buildMessageBubble(messages[index]),
              ),
            ),

            if (loading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                ),
              ),

            //Opciones dinamicas
          ],
        ),
      ),
    );
  }

  Widget buildMessageBubble(Message msg) {
    // Determina la alineacion del mensaje. Si es del usuario a la derecha, si no a la izquierda
    final alignment = msg.isUser ? Alignment.centerRight : Alignment.centerLeft;
    // Detrminar el color de la burbuja del mensaje
    final color = msg.isUser ? Colors.blueAccent : Colors.grey.shade300;
    // Determinar el color del texto
    final textColor = msg.isUser ? Colors.white : Colors.black87;
    // El radio de las esquinas de la burbuja
    final radius = BorderRadius.circular(12);

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: msg.isUser
              ? radius.subtract(
                  const BorderRadius.only(bottomRight: Radius.circular(12)),
                )
              : radius.subtract(
                  const BorderRadius.only(bottomLeft: Radius.circular(12)),
                ),
        ),
        child: Text(msg.text, style: TextStyle(color: textColor)),
      ),
    );
  }
}
