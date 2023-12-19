import 'dart:convert';

import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/HelloScreen/introduction_animation_screen.dart';
import 'package:bedesten/LoginClass/UserModel.dart';
import 'package:bedesten/SClass/FPrint.dart';
import 'package:bedesten/Thema/ThemeProvider.dart';
import 'package:bedesten/Thema/themes.dart';
import 'package:bedesten/screens/login_screen.dart';
import 'package:bedesten/wigets/navbar_roots.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async{
  try {
    await dotenv.load();
  } catch (e) {
    print("dotenv yükleme hatası: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()), // ThemeProvider eklendi
        // Diğer provider'larınız buraya eklenebilir...
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String createHmacSignature(String secretKey, String message) {
    final key = utf8.encode(secretKey);
    final msg = utf8.encode(message);

    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(msg);
    return hex.encode(digest.bytes);
  }
  Future<bool> _checkFirstLaunch() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final isFirstTime = sp.getBool("appIndex") ?? true;
    if (isFirstTime) {
      await sp.setBool("appIndex", false);
    }
    return isFirstTime;
  }


  Future<bool> _checkUserLoggedIn() async {
    final String? token = await _storage.read(key: "token");
    if (token == null) return false;

  //  const url = "http://192.168.1.102:8887/api/v1/profile/update-profile";
    final secretKey = dotenv.env['YEK_QURE'] ?? 'YEK_QURE not Fount'; // Bu anahtarı güvenli bir yerde saklayın!
    final message = "MEsaj"; // Bu mesaj isteğe bağlıdır.

    final signer = HMACSignature(secretKey);
    final signature = signer.createHmacSignature(message);
    print("AAAAAAAAAAAAAAAAAAAAAAAAA ::::::::::            $signature");
    print(dotenv.get('ASOP',fallback: 'ASOP erişilemez'));
    print(dotenv.env['YEK_QURE'] ?? 'YEK_QURE erişilemez');

    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      "message" : "$message",
      "Signature": signature, // İmzayı başlıklara ekleyin
    };

    try {
      final response = await http.post(Uri.parse(dotenv.env['ASOP'] ?? 'API_URL not found'), headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        return false;
      } else {
        print('Unexpected error occurred: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('An error occurred: $error');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provider ile tema modunu dinleyin.
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('tr', 'TR'),
      ],
      title: 'Bedesten',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme, // Açık tema ayarı
      darkTheme: Themes.darkTheme, // Koyu tema ayarı
      themeMode: themeProvider.themeMode, // Tema modunu provider'dan alın
      home: FutureBuilder<List<bool>>(
        future: Future.wait([_checkFirstLaunch(), _checkUserLoggedIn()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ProgressBar();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final isFirstTime = snapshot.data![0];
            final userLoggedIn = snapshot.data![1];
            if (isFirstTime) {
              return IntroductionAnimationScreen();
            } else if (userLoggedIn) {
              return navbar_roots();
            } else {
              return navbar_roots();//Sunucu aktif iken return Login_screen(); Olmalı
              //  return Login_screen();
            }
          }
        },
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: const [
        SizedBox(
          width: 150,
          height: 150,
          child: CircularProgressIndicator(
            color: Colors.white,
            backgroundColor: Colors.blueAccent,
            strokeWidth: 10,
          ),
        ),
        Text(
          'Bedesten',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
