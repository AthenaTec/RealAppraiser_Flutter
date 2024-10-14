import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class ImageUtils {
  // Function to check and request permissions before picking image
  static Future<bool> _requestPermissions() async {
    // Check if the platform is Android and the OS version is 33 or higher (Android 13+)
    if (Platform.isAndroid && (await _getSdkVersion()) >= 33) {
      // Request media access for photos and videos
      PermissionStatus photosPermission = await Permission.photos.request();
      PermissionStatus videosPermission = await Permission.videos.request();
      PermissionStatus cameraPermission = await Permission.camera.request();

      // Check if all necessary permissions are granted
      if (photosPermission.isGranted && videosPermission.isGranted && cameraPermission.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      // For lower Android versions, request general storage and camera permissions
      PermissionStatus cameraPermission = await Permission.camera.request();
      PermissionStatus storagePermission = await Permission.storage.request();

      // Check if permissions are granted
      return cameraPermission.isGranted && storagePermission.isGranted;
    }
  }

  // Helper function to get the Android SDK version
  static Future<int> _getSdkVersion() async {
    try {
      return int.parse(await _getProperty('ro.build.version.sdk'));
    } catch (e) {
      return 0; // Default to 0 if version retrieval fails
    }
  }

  // Function to pick image from camera or gallery, compress, and return base64 and filename
  static Future<Map<String, String>?> pickAndCompressImage({
    required ImageSource source, // camera or gallery
    int quality = 85, // Compression quality
  }) async {
    // Request runtime permissions for camera and storage or media access
    bool permissionsGranted = await _requestPermissions();

    if (!permissionsGranted) {
      // If permissions are denied, show a dialog or return
      print("Permissions not granted!");
      return null;
    }

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile == null) {
        return null; // User cancelled the image picker
      }

      File imageFile = File(pickedFile.path);

      // Compress the image
      File? compressedImage = await _compressImage(imageFile, quality: quality);

      if (compressedImage != null) {
        // Convert the compressed image to base64
        List<int> imageBytes = await compressedImage.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        // Get the filename
        String fileName = path.basename(pickedFile.path);

        // Return a map containing both base64 image and filename
        return {
          'base64': base64Image,
          'fileName': fileName,
        };
      } else {
        return null; // Compression failed
      }
    } catch (e) {
      print("Error picking or compressing image: $e");
      return null; // Handle error
    }
  }

  // Private function to compress the image
  static Future<File?> _compressImage(File imageFile, {int quality = 85}) async {
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(dir.absolute.path, "temp_compressed_image.jpg");

    File? result = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,
      targetPath,
      quality: quality,
      minWidth: 1080, // Adjust min width
      minHeight: 1920, // Adjust min height
    );

    return result; // Return compressed image file
  }

  // Helper function to get system properties (SDK version, etc.)
  static Future<String> _getProperty(String key) async {
    try {
      ProcessResult result = await Process.run('getprop', [key]);
      return result.stdout.trim();
    } catch (e) {
      return '0'; // Return '0' if property retrieval fails
    }
  }
}
