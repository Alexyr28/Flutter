import "package:fixmec/pages/ui/acerca_de.dart";
import "package:fixmec/pages/ui/home.dart";
import "package:fixmec/pages/ui/language.dart";
import "package:fixmec/services/localization_service.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:salomon_bottom_bar/salomon_bottom_bar.dart";

class SettingsFixMec extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final int selectedIndex;
  const SettingsFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    this.selectedIndex = 0,
  });

  @override
  State<SettingsFixMec> createState() => _SettingsFixMec();
}

class _SettingsFixMec extends State<SettingsFixMec> {
  bool _isDark = false;
  bool _isnoti = false;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDark;
    _currentIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant SettingsFixMec oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDark != widget.isDark) {
      setState(() {
        _isDark = widget.isDark;
      });
    }
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
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeFixMec(
                        isDark: _isDark,
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
                  Provider.of<LocalizationService>(
                    context,
                  ).translate("configuration"),
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => Navigator.pop(context),
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
                        isDark: _isDark,
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
          Provider.of<LocalizationService>(context).translate("configuration"),
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
        child: ListView(
          children: [
            _SingleSection(
              title: "general",
              children: [
                _CustomListTile(
                  title: "darkmod",
                  icon: Icons.dark_mode_outlined,
                  trailing: Switch(
                    value: _isDark,
                    onChanged: (value) {
                      widget.onThemeChanged(value);
                      setState(() {
                        _isDark = value;
                      });
                    },
                  ),
                ),
                _CustomListTile(
                  title: "language",
                  icon: Icons.language_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguageFixMec(
                          isDark: _isDark,
                          onThemeChanged: widget.onThemeChanged,
                        ),
                      ),
                    );
                  },
                ),
                _CustomListTile(
                  title: "noti",
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
                    isDark: _isDark,
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

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  const _CustomListTile({
    required this.title,
    required this.icon,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        Provider.of<LocalizationService>(context).translate(title),
        style: TextStyle(fontFamily: "MiFuente", fontWeight: FontWeight.bold),
      ),
      leading: Icon(icon),
      trailing: trailing,
      onTap: onTap,
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
              Provider.of<LocalizationService>(context).translate(title!),
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
