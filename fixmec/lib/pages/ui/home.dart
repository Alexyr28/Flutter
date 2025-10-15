import 'package:fixmec/pages/ui/acerca_de.dart';
import 'package:fixmec/pages/ui/settings.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
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
                  style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
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
          style: TextStyle(
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
              style: TextStyle(
                fontFamily: "MiFuente",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              Provider.of<LocalizationService>(context).translate("systemis"),
              style: TextStyle(
                fontFamily: "MiFuente",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            // carrusel
            CarouselSlider(
              options: CarouselOptions(
                height: 190.0,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.25,
                scrollDirection: Axis.horizontal,
              ),

              // img de las motos
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
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00B4DB),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            imgPath,
                            fit: BoxFit.contain, //tamaño imag
                          ),
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
