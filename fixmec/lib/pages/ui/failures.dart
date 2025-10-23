import 'package:auto_size_text/auto_size_text.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FailuresFixMec extends StatefulWidget {
  final int currentIndex;
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  const FailuresFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    this.currentIndex = 3,
  });

  @override
  State<FailuresFixMec> createState() => _FailuresFixMec();
}

class _FailuresFixMec extends State<FailuresFixMec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildFailuresMotor(context),
                    _buildFailuresElctronics(context),
                    _buildFailuresFuel(context),
                    _buildFailuresPhysical(context),
                    _buildFailuresDiagnosis(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // cuadro de fallas
  Widget _buildFailuresMotor(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _showFailureDialogMotor(context),
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animation/Engine Animation.json",
                height: 100,
              ),
              const SizedBox(height: 10),
              AutoSizeText(
                loc.translate("motorfailures"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "MiFuente",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFailuresElctronics(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _showFailureDialogElectricas(context),
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(2, 2),
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animation/Lightning Lottie Animation.json",
                height: 100,
              ),
              const SizedBox(height: 10),
              AutoSizeText(
                loc.translate("electricalfailures"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "MiFuente",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFailuresFuel(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _showFailureDialogCombustible(context),
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(2, 2),
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/animation/Fuel meter.json", height: 100),
              AutoSizeText(
                loc.translate("fuelfailures"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "MiFuente",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFailuresPhysical(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _showFailureDialogFisicas(context),
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(2, 2),
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/animation/Settings icon.json", height: 100),
              const SizedBox(height: 10),
              AutoSizeText(
                loc.translate("physicalfailures"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "MiFuente",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFailuresDiagnosis(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _showFailureDialogDetalladas(context),
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(2, 2),
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animation/Vital Sign Heart Beat Line Electrocardiogram.json",
                height: 100,
              ),
              const SizedBox(height: 10),
              AutoSizeText(
                loc.translate("diagnostic_help"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "MiFuente",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //informaciom de fallas
  void _showFailureDialogMotor(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          loc.translate("motorfailures"),
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "MiFuente"),
        ),
        content: Text(
          loc.translate("Mfailures_content"),
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "MiFuente"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              loc.translate("close"),
              style: TextStyle(
                fontFamily: "MiFuente",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //electricas
  void _showFailureDialogElectricas(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          loc.translate("electricalfailures"),
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "MiFuente"),
        ),
        content: Text(
          loc.translate("Efailures_content"),
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "MiFuente"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              loc.translate("close"),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "MiFuente",
              ),
            ),
          ),
        ],
      ),
    );
  }

  //fuil
  void _showFailureDialogCombustible(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          loc.translate("fuelfailures"),
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "MiFuente"),
        ),
        content: Text(
          loc.translate("Cfailures_Content"),
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "MiFuente"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              loc.translate("close"),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "MiFuente",
              ),
            ),
          ),
        ],
      ),
    );
  }

  //pyhsical
  void _showFailureDialogFisicas(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          loc.translate("physicalfailures"),
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "MiFuente"),
        ),
        content: Text(
          loc.translate("Pfailures_content"),
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "MiFuente"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              loc.translate("close"),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "MiFuente",
              ),
            ),
          ),
        ],
      ),
    );
  }

  //detalladas
  void _showFailureDialogDetalladas(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          loc.translate("diagnostic_help"),
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "MiFuente"),
        ),
        content: Text(
          loc.translate("Dfailures_content"),
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "MiFuente"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              loc.translate("close"),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "MiFuente",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
