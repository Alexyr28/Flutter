import 'package:fixmec/pages/ui/acerca_de.dart';
import 'package:fixmec/pages/ui/settings.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixmec/pages/ui/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeFixMec extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  final int selectedIndex;
  const HomeFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    this.selectedIndex = 0,
  });

  @override
  State<HomeFixMec> createState() => _HomeFixMecState();
}

class _HomeFixMecState extends State<HomeFixMec> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      SalomonBottomBarItem(
        icon: Icon(Icons.home_rounded),
        title: Text(
          Provider.of<LocalizationService>(context).translate("start"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.chat_outlined),
        title: Text(
          Provider.of<LocalizationService>(context).translate("chat"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.query_stats_outlined),
        title: Text(
          Provider.of<LocalizationService>(context).translate("diagnost"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.warning_amber_outlined),
        title: Text(
          Provider.of<LocalizationService>(context).translate("fault"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.history),
        title: Text(
          Provider.of<LocalizationService>(context).translate("history"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
    ];
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
                      style: const TextStyle(
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
                      style: const TextStyle(
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
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () => Navigator.pop(context),
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
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsFixMec(
                        isDark: widget.isDark,
                        onThemeChanged: widget.onThemeChanged,
                      ),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outlined, color: Colors.white),
                title: Text(
                  Provider.of<LocalizationService>(context).translate("about"),
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutFixMec(
                        isDark: widget.isDark,
                        onThemeChanged: widget.onThemeChanged,
                      ),
                    ),
                  ),
                },
              ),

              // inicio cerrar sesión boton
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text(
                  "Cerrar sesión",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  final confirmLogout = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      final bgColor = widget.isDark
                          ? const Color(0xFF1E1E1E)
                          : Colors.white;
                      final textColor = widget.isDark
                          ? Colors.white70
                          : Colors.black87;

                      return AlertDialog(
                        backgroundColor: bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Text(
                          "Confirmar cierre de sesión",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        //msg de seguridad
                        content: Text(
                          "¿Estás seguro de que deseas cerrar sesión?",
                          style: TextStyle(color: textColor),
                        ),
                        actions: [
                          TextButton(
                            child: Text(
                              "Cancelar",
                              style: TextStyle(
                                color: widget.isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[700],
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            child: const Text("Cerrar sesión"),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmLogout == true) {
                    await FirebaseAuth.instance.signOut();
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('isLoggedIn');

                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(
                            isDark: widget.isDark,
                            onThemeChanged: widget.onThemeChanged,
                          ),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }
                  }
                },
              ),
              // fin cerrar sesión, mas de aqui no toque, solo el boton
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
          Provider.of<LocalizationService>(context).translate("app_name"),
          style: const TextStyle(
            fontFamily: 'MiFuente',
            fontWeight: FontWeight.bold,
            color: Colors.white,
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

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              Provider.of<LocalizationService>(context).translate("welcome"),
              style: const TextStyle(
                fontFamily: "MiFuente",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              Provider.of<LocalizationService>(context).translate("systemis"),
              style: const TextStyle(
                fontFamily: "MiFuente",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 190.0,
                viewportFraction: 0.8,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.25,
              ),
              items: ["assets/motos/apache.png", "assets/motos/evo.png"].map((
                imgPath,
              ) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF00B4DB),
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(imgPath, fit: BoxFit.contain),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeFixMec(
                    isDark: widget.isDark,
                    onThemeChanged: widget.onThemeChanged,
                    selectedIndex: 0,
                  ),
                ),
              );
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsFixMec(
                    isDark: widget.isDark,
                    onThemeChanged: widget.onThemeChanged,
                    selectedIndex: 1,
                  ),
                ),
              );
          }
        },
        items: items,
      ),
    );
  }
}
