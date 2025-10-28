import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL para el API
  static const String baseUrl = "http://10.0.2.2:8000/diagnostico";

  // Simulación local
  // Este metodo se realiaza una peticion GET al endpoint 'initial',
  // o se puede realizar de manera local
  static Future<Map<String, dynamic>> getInitial() async {
    final response = await http.post(Uri.parse('$baseUrl/inicial'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener el diagnóstico inicial');
    }
  }

  static Future<Map<String, dynamic>> sendAnswer(
    String key,
    String value,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/responder'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'key': value}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al enviar respuesta al servidor');
    }
    // await Future.delayed(const Duration(seconds: 1)); // Simula retardo de red
    // if (answer == 'Si') {
    //   return {
    //     'type': 'question',
    //     'text':
    //         '''Bienvenido a FixMec! Soy tu asistente experto en reparacion de motos.
    //                 ¿La moto enciende?''',
    //     'options': ['Si', 'No'],
    //   };
    // } else if (answer == 'No') {
    //   return {
    //     'type': 'diagnosis',
    //     'text': 'Posible falla: batería descargada o conexión suelta.',
    //   };
    // } else if (answer == 'No (explosiones)') {
    //   return {
    //     'type': 'diagnosis',
    //     'text': 'Posible falla: mezcla rica o bujía con problema.',
    //   };
    // } else {
    //   return {
    //     'type': 'diagnosis',
    //     'text':
    //         'No se pudo determinar la falla con la información proporcionada.',
    //   };
    // }
  }
}
