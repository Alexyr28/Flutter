import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:fixmec/services/progress_alert_service.dart';
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
  double progressoil = 0.0;
  double progesstires = 0.0;
  double progressbrakes = 0.0;
  double progresschain = 0.0;
  double progresslight = 0.0;

  int oilInterval = 30;
  int tiresInterval = 30;
  int brakesInterval = 30;
  int chainInterval = 30;
  int lightInterval = 30;

  @override
  void initState() {
    super.initState();
    loadUserProgress();
  }

  Future<DateTime?> showCustomDate(BuildContext context) async {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    DateTime selectedDate = DateTime.now();

    return await showModalBottomSheet<DateTime>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          child: Column(
            children: [
              Text(
                loc.translate("selectbirthdate"),
                style: TextStyle(
                  fontFamily: "MiFuente",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: CalendarDatePicker(
                  initialDate: selectedDate,
                  firstDate: DateTime(2018),
                  lastDate: DateTime.now(),
                  onDateChanged: (date) {
                    selectedDate = date;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context, selectedDate);
                },
                label: Text(loc.translate("confirm")),
                icon: const Icon(Icons.check),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00B4DB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //Carga el progreso del usuario desde Firestore
  Future<void> loadUserProgress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!userDoc.exists) return;

    setState(() {
      oilInterval = userDoc['progressoilInterval'] ?? 30;
      tiresInterval = userDoc['progesstiresInterval'] ?? 30;
      brakesInterval = userDoc['progressbrakesInterval'] ?? 30;
      chainInterval = userDoc['progresschainInterval'] ?? 30;
      lightInterval = userDoc['progresslightInterval'] ?? 30;

      progressoil = calcProgress(
        userDoc['progressoil'],
        userDoc['progressoilDate'],
        oilInterval,
      );
      progesstires = calcProgress(
        userDoc['progesstires'],
        userDoc['progesstiresDate'],
        tiresInterval,
      );
      progressbrakes = calcProgress(
        userDoc['progressbrakes'],
        userDoc['progressbrakesDate'],
        brakesInterval,
      );
      progresschain = calcProgress(
        userDoc['progresschain'],
        userDoc['progresschainDate'],
        chainInterval,
      );
      progresslight = calcProgress(
        userDoc['progresslight'],
        userDoc['progresslightDate'],
        lightInterval,
      );
    });
  }

  double calcProgress(
    dynamic progessValue,
    dynamic dateValue, [
    int intervalDays = 30,
  ]) {
    if (progessValue == null || dateValue == null) return 0.0;
    DateTime lastDate;

    //Conversion de Firebase
    if (dateValue is Timestamp) {
      lastDate = dateValue.toDate();
    } else {
      lastDate = DateTime.parse(dateValue.toString());
    }

    int dif = DateTime.now().difference(lastDate).inDays;

    //Mes igual a 30 dias
    double newProgress = 1.0 - (dif / intervalDays);

    if (newProgress < 0) newProgress = 0.0;

    return newProgress;
  }

  //Actualiza el progreso del usuario en Firestore
  Future<void> updateUserProgress(
    String field,
    double progress,
    DateTime date,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      field: progress,
      "${field}Date": date,
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        children: [
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
            childAspectRatio: 2.0,
            children: [
              PercentFixMec(
                title: loc.translate("oil"),
                image: "assets/icons/oil.png",
                subtitle: loc.translate("leveloil"),
                progress: progressoil,
                onTap: () async {
                  DateTime? date = await showCustomDate(context);
                  if (date != null) {
                    double newProgress = calcProgress(1.0, date, oilInterval);
                    setState(() {
                      progressoil = newProgress;
                    });

                    await updateUserProgress("progressoil", newProgress, date);
                    ProgressAlertService.checkProgress(
                      title: loc.translate("oil"),
                      progress: newProgress,
                    );
                  }
                  await loadUserProgress();
                },
              ),
              PercentFixMec(
                title: loc.translate("tires"),
                image: "assets/icons/racing.png",
                subtitle: loc.translate("checktires"),
                progress: progesstires,
                onTap: () async {
                  DateTime? date = await showCustomDate(context);
                  if (date != null) {
                    double newProgress = calcProgress(1.0, date, tiresInterval);
                    setState(() {
                      progesstires = newProgress;
                    });

                    await updateUserProgress("progesstires", newProgress, date);
                    ProgressAlertService.checkProgress(
                      title: loc.translate("tires"),
                      progress: newProgress,
                    );
                  }
                  await loadUserProgress();
                },
              ),
              PercentFixMec(
                title: loc.translate("brakes"),
                image: "assets/icons/disc-brake.png",
                subtitle: loc.translate("checkbrakes"),
                progress: progressbrakes,
                onTap: () async {
                  DateTime? date = await showCustomDate(context);
                  if (date != null) {
                    double newProgress = calcProgress(
                      1.0,
                      date,
                      brakesInterval,
                    );
                    setState(() {
                      progressbrakes = newProgress;
                    });

                    await updateUserProgress(
                      "progressbrakes",
                      newProgress,
                      date,
                    );
                    ProgressAlertService.checkProgress(
                      title: loc.translate("brakes"),
                      progress: newProgress,
                    );
                  }
                  await loadUserProgress();
                },
              ),
              PercentFixMec(
                title: loc.translate("chain"),
                image: "assets/icons/chain.png",
                subtitle: loc.translate("checkchain"),
                progress: progresschain,
                onTap: () async {
                  DateTime? date = await showCustomDate(context);
                  if (date != null) {
                    double newProgress = calcProgress(1.0, date, chainInterval);
                    setState(() {
                      progresschain = newProgress;
                    });

                    await updateUserProgress(
                      "progresschain",
                      newProgress,
                      date,
                    );

                    ProgressAlertService.checkProgress(
                      title: loc.translate("chain"),
                      progress: newProgress,
                    );
                  }
                  await loadUserProgress();
                },
              ),
              PercentFixMec(
                title: loc.translate("light"),
                image: "assets/icons/puzzle.png",
                subtitle: loc.translate("checklight"),
                progress: progresslight,
                onTap: () async {
                  DateTime? date = await showCustomDate(context);
                  if (date != null) {
                    double newProgress = calcProgress(1.0, date, lightInterval);
                    setState(() {
                      progresslight = newProgress;
                    });

                    await updateUserProgress(
                      "progresslight",
                      newProgress,
                      date,
                    );
                    ProgressAlertService.checkProgress(
                      title: loc.translate("light"),
                      progress: newProgress,
                    );
                  }
                  await loadUserProgress();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
