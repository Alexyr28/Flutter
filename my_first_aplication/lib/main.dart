import 'package:flutter/material.dart';

void main() {
  runApp(const HolaApp());
}

class HolaApp extends StatelessWidget {
  const HolaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenida',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BienvenidaPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BienvenidaPage extends StatefulWidget {
  const BienvenidaPage({super.key});

  @override
  State<BienvenidaPage> createState() => _BienvenidaPageState();
}

class _BienvenidaPageState extends State<BienvenidaPage> {
  String mensaje = '¡Hola, UDEBAR!';
  int contador = 0;

  void _presionarBoton() {
    setState(() {
      contador++;
      mensaje = '¡Hola! Has presionado $contador veces';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de Bienvenida'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              mensaje,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: _presionarBoton,
              child: const Text('Presióname'),
            ),
          ],
        ),
      ),
    );
  }
}
