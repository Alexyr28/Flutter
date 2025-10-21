import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
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
              Image.asset('assets/fallas/motor.png', height: 70),
              const SizedBox(height: 10),
              Text(
                loc.translate("motorfailures"),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              Image.asset('assets/fallas/electricas.png', height: 70),
              const SizedBox(height: 10),
              Text(
                loc.translate("electricalfailures"),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              Image.asset('assets/fallas/combustibles.png', height: 70),
              const SizedBox(height: 10),
              Text(
                loc.translate("fuelfailures"),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              Image.asset('assets/fallas/fisicas.png', height: 70),
              const SizedBox(height: 10),
              Text(
                loc.translate("physicalfailures"),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              Image.asset('assets/fallas/diagnostico.png', height: 70),
              const SizedBox(height: 10),
              Text(
                loc.translate("diagnostic_help"),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(loc.translate("Mfailures_content")),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.translate("close")),
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(loc.translate("Efailures_content")),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.translate("close")),
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(loc.translate("Cfailures_Content")),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.translate("close")),
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(loc.translate("Pfailures_content")),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.translate("close")),
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(loc.translate("Dfailures_content")),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.translate("close")),
          ),
        ],
      ),
    );
  }
}
