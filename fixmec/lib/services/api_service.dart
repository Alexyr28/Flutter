//import 'dart:convert';
//import 'package:http/http.dart' as http;

class ApiService {
  // Base URL para el API
  static const String baseUrl = "http://127.0.0.1:8000/";

  // Simulación local
  // Este metodo se realiaza una peticion GET al endpoint 'initial',
  // o se puede realizar de manera local
  static Future<Map<String, dynamic>> getInitial() async {
    await Future.delayed(const Duration(seconds: 1)); // Simula retardo de red

    return {
      'type': 'question',
      'text':
          '''Bienvenido a FixMec! Soy tu asistente experto en reparacion de motos.
            ¿La moto enciende?''',
      'options': ['Si', 'No'],
    };
  }

  static Future<Map<String, dynamic>> sendAnswer(String answer) async {
    await Future.delayed(const Duration(seconds: 1)); // Simula retardo de red
    if (answer == 'Si') {
      return {
        'type': 'question',
        'text':
            '''Bienvenido a FixMec! Soy tu asistente experto en reparacion de motos.
                    ¿La moto enciende?''',
        'options': ['Si', 'No'],
      };
    } else if (answer == 'No') {
      return {
        'type': 'diagnosis',
        'text': 'Posible falla: batería descargada o conexión suelta.',
      };
    } else if (answer == 'No (explosiones)') {
      return {
        'type': 'diagnosis',
        'text': 'Posible falla: mezcla rica o bujía con problema.',
      };
    } else {
      return {
        'type': 'diagnosis',
        'text':
            'No se pudo determinar la falla con la información proporcionada.',
      };
    }
  }
}
