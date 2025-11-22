import "dart:developer";
import "package:fixmec/services/background_task.dart";
import "package:fixmec/services/localization_service.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class SettingsFixMec extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<int> onIndexChanged;
  final int currentIndex;

  const SettingsFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  State<SettingsFixMec> createState() => _SettingsFixMec();
}

class _SettingsFixMec extends State<SettingsFixMec> {
  bool _isDark = false;
  bool _isnoti = false;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDark;
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
    return Scaffold(
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
                    widget.onIndexChanged(7);
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
                _CustomListTile(
                  title: "intervals",
                  icon: Icons.timelapse_outlined,
                  onTap: () {
                    widget.onIndexChanged(8);
                  },
                ),
                _CustomListTile(
                  title:
                      "Probar Worker", // Usamos texto literal ya que es un tile de debug
                  icon: Icons.work_history_outlined,
                  onTap: () async {
                    // Llamamos a la función directamente, pasando un mapa vacío.
                    await backgroundCheck({});
                    log("Worker de prueba manual finalizado.");
                  },
                ),
              ],
            ),
          ],
        ),
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
