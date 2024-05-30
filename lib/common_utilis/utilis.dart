import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class RAUtilis {
  final RegExp _urlRegExp = RegExp(r'^(?:https?:\/\/)?'
      r'(?:www\.)?'
      r'(?:(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,})'
      r'(?:\/[^\s]*)?');

  bool validateUrl(String url) {
    return _urlRegExp.hasMatch(url);
  }

  // Regular expression for email validation
  static bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(r'^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  // static String encrypt(String encryptKey, String initVector, String value) {
  //   try {
  //     final iv = enc.IV.fromUtf8(initVector);
  //     final key = enc.Key.fromUtf8(encryptKey);
  //     final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
  //
  //     final encrypted = encrypter.encrypt(value, iv: iv);
  //
  //     return encrypted.base64.toString();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   return "";
  // }

  static enc.Encrypted encryptWithAES(String keyValue, String plainText) {
    final cipherKey = enc.Key.fromUtf8(keyValue);
    final encryptService = enc.Encrypter(enc.AES(cipherKey, mode: enc.AESMode.cbc));
    final initVector = enc.IV.fromUtf8(keyValue.substring(0, 16)); //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.
    enc.Encrypted encryptedData =encryptService.encrypt(plainText, iv: initVector);
    return encryptedData;
  }

  static String decryptWithAES(String key, enc.Encrypted encryptedData) {
    final cipherKey = enc.Key.fromUtf8(key);
    final encryptService = enc.Encrypter(enc.AES(cipherKey, mode: enc.AESMode.cbc)); //Using AES CBC encryption
    final initVector = enc.IV.fromUtf8(key.substring(0, 16)); //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.
    return encryptService.decrypt(encryptedData, iv: initVector);
  }

  static void debugLog(String log) {
    if (foundation.kDebugMode) {
      debugPrint(log);
    }
  }

  static void setStorage(String key, String value) {
    if (value.isNotEmpty) {
      GetStorage().write(key, value);
    } else {
      GetStorage().write(key, value);
    }
  }

  static dynamic getStorage(String key) {
    if (GetStorage().read(key) != null && GetStorage().read(key) != "") {
      return GetStorage().read(key);
    } else {
      return "";
    }
  }
}
