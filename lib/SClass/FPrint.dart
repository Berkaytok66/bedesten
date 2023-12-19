import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class HMACSignature {
  final String secretKey;

  HMACSignature(this.secretKey);

  String createHmacSignature(String message) {
    final key = utf8.encode(secretKey);
    final msg = utf8.encode(message);

    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(msg);
    return hex.encode(digest.bytes);
  }
}