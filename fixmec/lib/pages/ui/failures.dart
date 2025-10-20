import 'package:fixmec/services/localization_service.dart';
import 'package:fixmec/widgets/appbar.dart';
import 'package:fixmec/widgets/drawerheader.dart';
import 'package:fixmec/widgets/navigationappbar.dart';
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
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawerheader(
        isDark: widget.isDark,
        onThemeChanged: widget.onThemeChanged,
        currentIndex: _currentIndex,
      ),
      appBar: CustomAppBar(
        title: Provider.of<LocalizationService>(context).translate("fault2"),
      ),
      bottomNavigationBar: CustomNavAppBar(
        currentIndex: _currentIndex,
        isDark: widget.isDark,
        onThemeChanged: widget.onThemeChanged,
      ),

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
              const Text(
                'Fallas Motor',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFailuresElctronics(BuildContext context) {
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
              const Text(
                'Fallas Electricas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFailuresFuel(BuildContext context) {
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
              const Text(
                'Fallas Combustible',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFailuresPhysical(BuildContext context) {
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
              const Text(
                'Fallas Fisicas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFailuresDiagnosis(BuildContext context) {
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
              const Text(
                'Diagnostico ',
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Fallas del Motor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Entre las fallas más comunes de un motor se encuentran:\n\n'
          '• Problemas de encendido: bujías o bobinas defectuosas.\n'
          '• Pérdida de potencia: filtros de aire o combustible sucios.\n'
          '• Sobrecalentamiento: fallas en el sistema de refrigeración.\n'
          '• Consumo excesivo de aceite o combustible.\n'
          '• Ruidos inusuales: desgaste en válvulas o cojinetes.\n\n'
          'Estas fallas suelen ser causadas por falta de mantenimiento preventivo, '
          'uso prolongado del vehículo sin revisiones o la calidad del combustible. '
          'Se recomienda realizar diagnósticos periódicos para evitar daños mayores.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  //electricas
  void _showFailureDialogElectricas(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Fallas del Motor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Entre las fallas eléctricas más comunes se encuentran:\n\n'
          '• Batería descargada o en mal estado.\n'
          '• Alternador defectuoso o que no carga correctamente.\n'
          '• Cortocircuitos o cables sulfatados.\n'
          '• Fusibles quemados o relés dañados.\n'
          '• Fallas en sensores o módulos electrónicos.\n\n'
          'Estas fallas pueden provocar encendido irregular, pérdida de funciones '
          'electrónicas o fallos en la inyección del motor. '
          'Es importante revisar el sistema eléctrico y la batería de forma periódica.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  //fuil
  void _showFailureDialogCombustible(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Fallas del Motor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Entre las fallas más comunes en el sistema de combustible se encuentran:\n\n'
          '• Bomba de combustible defectuosa o con baja presión.\n'
          '• Inyectores sucios o dañados.\n'
          '• Filtros de combustible obstruidos.\n'
          '• Fugas en líneas o conexiones del sistema.\n'
          '• Uso de combustible de baja calidad.\n\n'
          'Estos problemas pueden causar dificultad para arrancar, pérdida de potencia '
          'o un consumo excesivo. Se recomienda limpiar los inyectores y cambiar el filtro periódicamente.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  //pyhsical
  void _showFailureDialogFisicas(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Fallas del Motor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Las fallas físicas más comunes en una motocicleta o vehículo incluyen:\n\n'
          '• Pérdida de tornillos, tuercas o pernos por vibración.\n'
          '• Rotura o desgaste de partes plásticas o metálicas.\n'
          '• Problemas en la suspensión o chasis.\n'
          '• Desgaste irregular en las llantas o frenos.\n'
          '• Golpes o deformaciones por caídas o choques leves.\n\n'
          'Estas fallas suelen afectar la seguridad y estabilidad del vehículo. '
          'Es recomendable hacer inspecciones visuales frecuentes y mantenimiento preventivo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  //detalladas
  void _showFailureDialogDetalladas(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Fallas del Motor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'El diagnóstico detallado permite analizar de forma precisa el estado del vehículo:\n\n'
          '• Escaneo de códigos de error del sistema electrónico.\n'
          '• Revisión de sensores, actuadores y sistemas de inyección.\n'
          '• Evaluación del rendimiento del motor y consumo.\n'
          '• Análisis de vibraciones, ruidos o fugas.\n'
          '• Generación de reportes para mantenimiento preventivo.\n\n'
          'Un diagnóstico detallado ayuda a identificar fallas ocultas antes de que se conviertan '
          'en reparaciones costosas y mejora la eficiencia del vehículo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
