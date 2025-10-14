import "package:fixmec/pages/ui/home.dart";
import "package:flutter/material.dart";

class SettingsFixMec extends StatefulWidget {
  const SettingsFixMec({super.key});

  @override
  State<SettingsFixMec> createState() => _SettingsFixMec();
}

class _SettingsFixMec extends State<SettingsFixMec> {
  bool _isDark = false;
  bool _isnoti = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDark ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
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
                        backgroundColor: const Color.fromARGB(
                          255,
                          65,
                          156,
                          221,
                        ),
                        child: Image.asset(
                          "assets/icons/repair.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        "FixMec",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Diagnóstico Inteligente",
                        style: TextStyle(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeFixMec()),
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
                  onTap: () => {},
                ),
                ListTile(
                  leading: const Icon(Icons.info_outlined, color: Colors.white),
                  title: const Text(
                    "Acerca de",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => {},
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
            "Configuración",
            style: TextStyle(
              fontFamily: "MiFuente",
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
        body: Center(
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  _CustomListTile(
                    title: "Modo Oscuro",
                    icon: Icons.dark_mode_outlined,
                    trailing: Switch(
                      value: _isDark,
                      onChanged: (value) {
                        setState(() {
                          _isDark = value;
                        });
                      },
                    ),
                  ),
                  const _CustomListTile(
                    title: "Idioma",
                    icon: Icons.language_rounded,
                  ),
                  _CustomListTile(
                    title: "Notificaciones",
                    icon: Icons.notifications_active,
                    trailing: Switch(
                      value: _isnoti,
                      onChanged: (value) {
                        setState(() {
                          _isnoti = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile({
    required this.title,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(
                fontFamily: "MiFuente",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Column(children: children),
      ],
    );
  }
}
