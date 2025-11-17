import 'package:fixmec/services/localization_service.dart';
import 'package:fixmec/services/notification_service.dart';

class ProgressAlertService {
  static void checkProgress({required String title, required double progress}) {
    final loc = LocalizationService.instance;
    if (progress <= 0.10) {
      NotificationService.showNotification(
        id: title.hashCode,
        title: "${loc.translate("urgent")} $title",
        body: loc.translate("progress_below_10"),
      );
    } else if (progress <= 0.25) {
      NotificationService.showNotification(
        id: title.hashCode,
        title: "${loc.translate("attention")} $title",
        body: loc.translate("progress_below_25"),
      );
    } else if (progress <= 0.50) {
      NotificationService.showNotification(
        id: title.hashCode,
        title: "${loc.translate("advertence")} $title",
        body: loc.translate("progress_below_50"),
      );
    }
  }
}
