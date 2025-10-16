import 'package:fixmec/services/localization_service.dart';
import 'package:fixmec/widgets/appbar.dart';
import 'package:fixmec/widgets/drawerheader.dart';
import 'package:fixmec/widgets/navigationappbar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class HomeFixMec extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final int currentIndex;

  const HomeFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    this.currentIndex = 0,
  });

  @override
  State<HomeFixMec> createState() => _HomeFixMecState();
}

class _HomeFixMecState extends State<HomeFixMec> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);
    return Scaffold(
      endDrawer: CustomDrawerheader(
        isDark: widget.isDark,
        onThemeChanged: widget.onThemeChanged,
        currentIndex: _currentIndex,
      ),
      appBar: CustomAppBar(title: loc.translate("app_name")),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              loc.translate("welcome"),
              style: const TextStyle(
                fontFamily: "MiFuente",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              loc.translate("systemis"),
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
      bottomNavigationBar: CustomNavAppBar(
        currentIndex: _currentIndex,
        isDark: widget.isDark,
        onThemeChanged: widget.onThemeChanged,
      ),
    );
  }
}
