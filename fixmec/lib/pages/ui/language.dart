import 'package:fixmec/pages/ui/acerca_de.dart';
import 'package:fixmec/pages/ui/home.dart';
import 'package:fixmec/pages/ui/settings.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageFixMec extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const LanguageFixMec({
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
                      Provider.of<LocalizationService>(
                        context,
                      ).translate("app_name"),
                      style: TextStyle(
                        fontFamily: "MiFuente",
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      Provider.of<LocalizationService>(
                        context,
                      ).translate("diag"),
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
                title: Text(
                  Provider.of<LocalizationService>(context).translate("start"),
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
                title: Text(
                  Provider.of<LocalizationService>(
                    context,
                  ).translate("configuration"),
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
                title: Text(
                  Provider.of<LocalizationService>(context).translate("about"),
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutFixMec(
                        isDark: isDark,
                        onThemeChanged: onThemeChanged,
                      ),
                    ),
                  ),
                },
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
        title: Text(
          Provider.of<LocalizationService>(context).translate("language"),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<LocalizationService>(
                      context,
                      listen: false,
                    ).changeLanguage('es');
                  },
                  style:
                      ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(0),
                        elevation: 5,
                      ).copyWith(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        shadowColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF004E92), Color(0xFF00B4DB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        Provider.of<LocalizationService>(
                          context,
                        ).translate("spanish"),
                        style: TextStyle(
                          fontFamily: "MiFuente",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<LocalizationService>(
                      context,
                      listen: false,
                    ).changeLanguage('en');
                  },
                  style:
                      ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(0),
                        elevation: 5,
                      ).copyWith(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        shadowColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF004E92), Color(0xFF00B4DB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        Provider.of<LocalizationService>(
                          context,
                        ).translate("english"),
                        style: TextStyle(
                          fontFamily: "MiFuente",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
