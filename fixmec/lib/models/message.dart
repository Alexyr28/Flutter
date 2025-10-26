// Clase para modelo de mensaje para la pagina de diagnostico

class Message {
  // Texto del mensaje
  final String text;
  // Indica si el mensaje es del usuario o del sistema
  final bool isUser; // true = usuario, false = SBC
  Message({required this.text, required this.isUser});
}
