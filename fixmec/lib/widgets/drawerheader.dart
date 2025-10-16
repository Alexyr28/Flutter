import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixmec/pages/ui/acerca_de.dart';
import 'package:fixmec/pages/ui/home.dart';
import 'package:fixmec/pages/ui/login_page.dart';
import 'package:fixmec/pages/ui/settings.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawerheader extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final int currentIndex;

  const CustomDrawerheader({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    required this.currentIndex,
  });

  @override
  State<CustomDrawerheader> createState() => _DrawerheaderState();
}

class _DrawerheaderState extends State<CustomDrawerheader> {
  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);
    return Drawer(
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
                    loc.translate("app_name"),
                    style: const TextStyle(
                      fontFamily: "MiFuente",
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    loc.translate("diag"),
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
                loc.translate("start"),
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () => {
                Navigator.pop(context),
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeFixMec(
                      isDark: widget.isDark,
                      onThemeChanged: widget.onThemeChanged,
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
                loc.translate("configuration"),
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
                      currentIndex: widget.currentIndex,
                    ),
                  ),
                ),
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outlined, color: Colors.white),
              title: Text(
                loc.translate("about"),
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
                      currentIndex: widget.currentIndex,
                    ),
                  ),
                ),
              },
            ),

            // inicio cerrar sesión boton
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: Text(
                loc.translate("logout"),
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                final confirmLogout = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    widget.isDark ? const Color(0xFF1E1E1E) : Colors.white;
                    final textColor = widget.isDark
                        ? Colors.white70
                        : Colors.black87;

                    return AlertDialog(
                      backgroundColor: widget.isDark
                          ? const Color(0xFF004E92)
                          : const Color(0xFF00B4DB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      title: Text(
                        loc.translate("confirmlogout"),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "MiFuente",
                        ),
                      ),
                      //msg de seguridad
                      content: Text(
                        loc.translate("areusure"),
                        style: TextStyle(
                          color: textColor,
                          fontFamily: "MiFuente",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            loc.translate("cancel"),
                            style: TextStyle(
                              color: widget.isDark
                                  ? Colors.grey[400]
                                  : const Color.fromARGB(255, 39, 38, 38),
                              fontFamily: "MiFuente",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              82,
                              209,
                              255,
                            ),
                          ),
                          child: Text(
                            loc.translate("logout"),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "MiFuente",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }
}
