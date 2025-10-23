import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:fixmec/widgets/percent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InicioFixMec extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final int currentIndex;
  const InicioFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    this.currentIndex = 0,
  });

  @override
  State<InicioFixMec> createState() => _InicioFixMec();
}

class _InicioFixMec extends State<InicioFixMec> {
  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        children: [
          const SizedBox(height: 20),
          AutoSizeText(
            loc.translate("welcome"),
            style: const TextStyle(
              fontFamily: "MiFuente",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          AutoSizeText(
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
          const SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              loc.translate("alerts"),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: "MiFuente",
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.3,
            children: [
              PercentFixMec(
                title: loc.translate("oil"),
                image: "assets/icons/oil.png",
                subtitle: loc.translate("leveloil"),
                progress: 0.28,
              ),
              PercentFixMec(
                title: loc.translate("tires"),
                image: "assets/icons/racing.png",
                subtitle: loc.translate("checktires"),
                progress: 0.56,
              ),
              PercentFixMec(
                title: loc.translate("brakes"),
                image: "assets/icons/disc-brake.png",
                subtitle: loc.translate("checkbrakes"),
                progress: 0.9,
              ),
              PercentFixMec(
                title: loc.translate("chain"),
                image: "assets/icons/chain.png",
                subtitle: loc.translate("checkchain"),
                progress: 0.67,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
