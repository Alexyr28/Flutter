import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fixmec/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String periodicTaskName = "fixmePeriodicMaintenanceCheck";

const List<Map<String, String>> maintenanceFields = [
  {'field': 'progressoil', 'title': 'Cambio de Aceite'},
  {'field': 'progesstires', 'title': 'Revisión de Neumáticos'},
  {'field': 'progressbrakes', 'title': 'Revisión de Frenos'},
  {'field': 'progresschain', 'title': 'Revisión de Cadena'},
  {'field': 'progresslight', 'title': 'Revisión de Luces'},
];

double calculateProgress(dynamic dateValue, [int intervalDays = 30]) {
  if (dateValue == null) return 0.0;

  DateTime lastDate;

  if (dateValue is Timestamp) {
    lastDate = dateValue.toDate();
  } else if (dateValue is DateTime) {
    lastDate = dateValue;
  } else {
    try {
      lastDate = DateTime.parse(dateValue.toString());
    } catch (e) {
      log("Error al parsear fecha: $e");
      return 0.0;
    }
  }

  final dif = DateTime.now().difference(lastDate).inDays;

  double newProgress = 1.0 - (dif / intervalDays);

  return newProgress;
}

@pragma('vm:entry-point')
Future<void> backgroundCheck(Map<String, dynamic> data) async {
  log("🔥 Worker ejecutado. Iniciando chequeo de mantenimiento.");
  try {
    await Firebase.initializeApp();
    await NotificationService.initNotifications();
  } catch (e) {
    log("❌ Error al inicializar Firebase: $e");
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  final String? userId = prefs.getString('uid');

  if (userId == null || userId.isEmpty) {
    log(
      "❌ User ID no encontrado en SharedPreferences. No se puede cargar el progreso.",
    );
    return;
  }

  DocumentSnapshot userDoc;
  try {
    userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();
  } catch (e) {
    log("❌ Error al obtener documento del usuario: $e");
    return;
  }

  if (!userDoc.exists || userDoc.data() == null) {
    log("! Documento del usuario no encontrado o vacío.");
    return;
  }

  final userData = userDoc.data() as Map<String, dynamic>;
  int notificationCount = 0;

  for (var item in maintenanceFields) {
    final field = item['field']!;
    final title = item['title']!;

    final dateValue = userData['${field}Date'];
    final intervalDays = userData['${field}Interval'] as int? ?? 30;

    if (dateValue == null) {
      log('Saltando $title: Falta la fecha.');
      continue;
    }

    final progress = calculateProgress(dateValue, intervalDays);
    final progressPercent = progress * 100.0;

    final id = field.hashCode;

    String? notificationBody;
    String notificationTitle = '⚠️ Recordatorio FixMec: $title';

    if (progressPercent < 10.0) {
      notificationBody =
          '¡URGENTE! $title (${progressPercent.toStringAsFixed(1)}%) está por vencer o ya ha vencido.';
      notificationTitle = '¡Mantenimiento URGENTE!';
    } else if (progressPercent < 25.0) {
      notificationBody =
          '¡ALERTA! $title (${progressPercent.toStringAsFixed(1)}%) necesita ser revisado pronto.';
    } else if (progressPercent < 50.0) {
      notificationBody =
          'AVISO: $title (${progressPercent.toStringAsFixed(1)}%) se acerca a la mitad de su vida útil. Planifica su mantenimiento.';
    }

    if (notificationBody != null) {
      log(
        '🚨 Alerta para $title. Progreso: ${progressPercent.toStringAsFixed(1)}%',
      );
      await NotificationService.showNotification(
        id: id,
        title: notificationTitle,
        body: notificationBody,
        payload: 'item_field_$field',
      );
      notificationCount++;
    }
  }
  log(
    "🎉 Comprobación de mantenimientos finalizada. Notificaciones enviadas: $notificationCount.",
  );
}
