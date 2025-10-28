import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageFixMec extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<int> onIndexChanged;
  final int currentIndex;

  const LanguageFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  State<LanguageFixMec> createState() => _LanguageFixMecState();
}

class _LanguageFixMecState extends State<LanguageFixMec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            widget.onIndexChanged(5);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF00B4DB)),
        ),
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
