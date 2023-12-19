import 'package:bedesten/LoginClass/User.dart';
import 'package:flutter/foundation.dart';

class UserModel with ChangeNotifier {
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  set user(User? user) {
    _user = user;
    notifyListeners(); // Kullanıcı bilgileri değiştiğinde ilgili widget'ları yeniden inşa eder
  }

  set token(String? token) {
    _token = token;
    notifyListeners(); // Token değiştiğinde ilgili widget'ları yeniden inşa eder
  }

  void setUserAndToken(AuthResponse authResponse) {
    _user = authResponse.user;
    _token = authResponse.token;
    notifyListeners(); // Hem kullanıcı bilgileri hem de token değiştiğinde ilgili widget'ları yeniden inşa eder
  }
}
