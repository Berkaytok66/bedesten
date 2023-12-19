import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = FlutterSecureStorage();

  // Veriyi kaydetme
  Future<void> setSecureData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Veriyi okuma
  Future<String?> getSecureData(String key) async {
    return await _storage.read(key: key);
  }

  // Veriyi silme
  Future<void> deleteSecureData(String key) async {
    await _storage.delete(key: key);
  }

  // Tüm veriyi silme
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  // Veriyi güncelleme
  Future<void> updateSecureData(String key, String newValue) async {
    await setSecureData(key, newValue);
  }
}
