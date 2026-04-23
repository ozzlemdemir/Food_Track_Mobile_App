import 'dart:io';
import 'package:flutter/foundation.dart';

class ConnectivityChecker {
  Future<bool> get isConnected async {
    // Web platformunda her zaman bağlı say
    if (kIsWeb) return true;

    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}