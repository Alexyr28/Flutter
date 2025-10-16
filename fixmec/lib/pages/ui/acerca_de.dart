import 'package:fixmec/services/localization_service.dart';
import 'package:fixmec/widgets/drawerheader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutFixMec extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final int currentIndex;
  const AboutFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawerheader(
        isDark: isDark,
        onThemeChanged: onThemeChanged,
        currentIndex: currentIndex,
      ),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset("assets/icons/repair.png", fit: BoxFit.contain),
        ),
        title: Text(
          Provider.of<LocalizationService>(context).translate("about"),
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
                Text(
                  Provider.of<LocalizationService>(
                    context,
                  ).translate("app_name"),
                  style: TextStyle(
                    fontFamily: "MiFuente",
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                  Provider.of<LocalizationService>(
                    context,
                  ).translate("diagnosis"),
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
            context: context,
            icon: Icons.description_rounded,
            title: "description",
            content: "descript2",
          ),
          _buildSection(
            context: context,
            icon: Icons.functions,
            title: "functions",
            content: "fun2",
          ),
          _buildSection(
            context: context,
            icon: Icons.flutter_dash_sharp,
            title: "technologies",
            content: "techno2",
          ),
          Text(
            Provider.of<LocalizationService>(context).translate("developers"),
            style: TextStyle(
              fontFamily: "MiFuente",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          _buildDeveloper(context, "Alexander Yamá Rosero", "dev1"),
          _buildDeveloper(context, "Samuel Salazar", "dev2"),
          _buildDeveloper(context, "Daniel Trujillo", "dev3"),
          const Divider(),
          Center(
            child: Column(
              children: [
                Text(
                  "${Provider.of<LocalizationService>(context).translate('version')} 1.0.0",
                  style: TextStyle(
                    fontFamily: "MiFuente",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "© 2025 FixMec – ${Provider.of<LocalizationService>(context).translate('rights')}",
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
    required BuildContext context,
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
                Provider.of<LocalizationService>(context).translate(title),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "MiFuente",
                ),
              ),
            ],
          ),
          Text(
            Provider.of<LocalizationService>(context).translate(content),
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

  Widget _buildDeveloper(BuildContext context, String name, String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.person_outline),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$name – ${Provider.of<LocalizationService>(context).translate(role)}",
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
