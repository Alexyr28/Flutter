import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL para el API
  static const String baseUrl = "http://10.0.2.2:8000/diagnostico";

  static Future<Map<String, dynamic>> getInitial() async {
    final response = await http.post(Uri.parse('$baseUrl/inicial'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener el diagnóstico inicial');
    }
  }

  static Future<Map<String, dynamic>> sendAnswer(
    Map<String, String> respuestas,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/responder'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"respuestas": respuestas}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al enviar respuesta al servidor');
    }
  }
}
