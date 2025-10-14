import 'package:fixmec/pages/ui/home.dart';
import 'package:fixmec/pages/ui/settings.dart';
import 'package:flutter/material.dart';

class AboutFixMec extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  const AboutFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF004E92), Color(0xFF00B4DB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF004E92), Color(0xFF00B4DB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: const Color.fromARGB(255, 65, 156, 221),
                      child: Image.asset(
                        "assets/icons/repair.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "FixMec",
                      style: TextStyle(
                        fontFamily: "MiFuente",
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Diagnóstico Inteligente",
                      style: TextStyle(
                        fontFamily: "MiFuente",
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home_rounded, color: Colors.white),
                title: const Text(
                  "Inicio",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeFixMec(
                        isDark: isDark,
                        onThemeChanged: onThemeChanged,
                      ),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings_suggest_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  "Configuración",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsFixMec(
                        isDark: isDark,
                        onThemeChanged: onThemeChanged,
                      ),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outlined, color: Colors.white),
                title: const Text(
                  "Acerca de",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset("assets/icons/repair.png", fit: BoxFit.contain),
        ),
        title: const Text(
          "Acerca de",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: "MiFuente",
          ),
        ),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              );
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF004E92), Color(0xFF00B4DB)],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  "FixMec",
                  style: TextStyle(
                    fontFamily: "MiFuente",
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const Text(
                  "Diagnóstico Inteligente de Motos",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "MiFuente",
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          _buildSection(
            icon: Icons.description_rounded,
            title: "Descripción",
            content:
                "FixMec es una aplicación móvil creada para ayudar a los motociclistas a diagnosticar fallas mecánicas de manera rápida e inteligente. Combina conocimiento técnico con inteligencia artificial para ofrecer posibles causas, soluciones y consejos de mantenimiento preventivo.",
          ),
          _buildSection(
            icon: Icons.functions,
            title: "Funciones principales",
            content:
                "• Diagnóstico inteligente de fallas\n• Chat con IA especializada en mecánica\n• Modo oscuro personalizable\n• Interfaz moderna y minimalista",
          ),
          _buildSection(
            icon: Icons.flutter_dash_sharp,
            title: "Tecnologías utilizadas",
            content:
                "Flutter & Dart\nLottie Animations\nShared Preferences\nDiseño responsivo con tema oscuro y azul tecnológico",
          ),
          const Text(
            "Desarrolladores",
            style: TextStyle(
              fontFamily: "MiFuente",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          _buildDeveloper("Alexander Yamá Rosero", "Desarrollo UI/UX"),
          _buildDeveloper("Samuel Salazar", "Lógica de diagnóstico y backend"),
          _buildDeveloper(
            "Daniel Trujillo",
            "Pruebas, documentación y optimización",
          ),
          const Divider(),
          const Center(
            child: Column(
              children: [
                Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    fontFamily: "MiFuente",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "© 2025 FixMec – Todos los derechos reservados",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "MiFuente",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "MiFuente",
                ),
              ),
            ],
          ),
          Text(
            content,
            style: TextStyle(
              height: 1.4,
              fontSize: 15,
              fontFamily: "MiFuente",
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloper(String name, String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.person_outline),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$name – $role",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: "MiFuente",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
