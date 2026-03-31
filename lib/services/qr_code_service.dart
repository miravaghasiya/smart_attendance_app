import 'dart:convert';
import 'package:crypto/crypto.dart';

class QRCodeService {
  /// Generate QR code data with user ID and timestamp
  static String generateQRCode(String userId) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final data = '$userId:$timestamp';
    return base64Encode(utf8.encode(data));
  }

  /// Generate a unique QR code ID
  static String generateQRCodeId(String userId) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final data = '$userId:$timestamp';
    return md5.convert(utf8.encode(data)).toString();
  }

  /// Validate QR code format
  static bool validateQRCode(String qrCode) {
    try {
      utf8.decode(base64Decode(qrCode));
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Decode QR code to get user ID
  static String? decodeQRCode(String qrCode) {
    try {
      final decoded = utf8.decode(base64Decode(qrCode));
      final parts = decoded.split(':');
      return parts.isNotEmpty ? parts[0] : null;
    } catch (e) {
      return null;
    }
  }
}
