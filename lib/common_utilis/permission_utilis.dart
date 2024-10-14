import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  // Check and request Camera and Storage permissions
  static Future<bool> requestCameraAndStoragePermissions() async {
    // Check the status of each permission
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus storageStatus = await Permission.storage.status;

    // Request camera permission if not granted
    if (!cameraStatus.isGranted) {
      cameraStatus = await Permission.camera.request();
    }

    // Request storage permission if not granted
    if (!storageStatus.isGranted) {
      storageStatus = await Permission.storage.request();
    }

    // Return true if both permissions are granted, false otherwise
    return cameraStatus.isGranted && storageStatus.isGranted;
  }

  // Check if permissions are permanently denied (no way to ask again)
  static Future<bool> arePermissionsPermanentlyDenied() async {
    return await Permission.camera.isPermanentlyDenied ||
        await Permission.storage.isPermanentlyDenied;
  }

  // Open app settings to allow the user to manually grant permissions
  static Future<void> openAppSettings() async {
    await openAppSettings();
  }
}
