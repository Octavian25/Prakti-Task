import 'package:permission_handler/permission_handler.dart';

void requestPermission() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.notification,
    Permission.scheduleExactAlarm,
    Permission.accessNotificationPolicy,
    Permission.storage,
  ].request();
}
