import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntervalFixMec extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<int> onIndexChanged;
  final int currentIndex;
  const IntervalFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  State<IntervalFixMec> createState() => _IntervalFixMecState();
}

class _IntervalFixMecState extends State<IntervalFixMec> {
  Map<String, int> intervals = {
    "progressoilInterval": 30,
    "progesstiresInterval": 30,
    "progressbrakesInterval": 30,
    "progresschainInterval": 30,
    "progresslightInterval": 30,
  };

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadIntervals();
  }

  Future<void> loadIntervals() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      setState(() {
        for (final key in intervals.keys) {
          intervals[key] = doc.data()![key] ?? 30;
        }
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateInterval(String key, int value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      key: value,
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildIntervalTile(loc.translate("oil"), "progressoilInterval"),
                _buildIntervalTile(
                  loc.translate("tires"),
                  "progesstiresInterval",
                ),
                _buildIntervalTile(
                  loc.translate("brakes"),
                  "progressbrakesInterval",
                ),
                _buildIntervalTile(
                  loc.translate("chain"),
                  "progresschainInterval",
                ),
                _buildIntervalTile(
                  loc.translate("light"),
                  "progresslightInterval",
                ),
              ],
            ),
    );
  }

  Widget _buildIntervalTile(String title, String key) {
    final loc = Provider.of<LocalizationService>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const Icon(Icons.timer),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "MiFuente",
          ),
        ),
        subtitle: Text("${intervals[key]} ${loc.translate("days")}"),
        trailing: IconButton(
          onPressed: () async {
            int? newVal = await showModalBottomSheet<int>(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => _IntervalSelector(current: intervals[key]!),
            );
            if (newVal != null && newVal != intervals[key]) {
              setState(() {
                intervals[key] = newVal;
              });
              await updateInterval(key, newVal);
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "${loc.translate("intervalof")} $title "
                    "${loc.translate("auptaded")} $newVal ${loc.translate("days")}",
                    style: TextStyle(
                      fontFamily: "MiFuente",
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
          icon: const Icon(Icons.check),
        ),
      ),
    );
  }
}

class _IntervalSelector extends StatelessWidget {
  final int current;
  const _IntervalSelector({required this.current});

  @override
  Widget build(BuildContext context) {
    final options = [15, 30, 45, 60, 90];

    return Container(
      padding: const EdgeInsets.all(16),
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Selecciona un nuevo intervalo",
            style: TextStyle(
              fontFamily: "MiFuente",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: options.map((days) {
                return ListTile(
                  title: Text("$days días"),
                  trailing: days == current
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () => Navigator.pop(context, days),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
