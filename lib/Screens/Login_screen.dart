import 'dart:convert';

import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/Companent/my_button.dart';
import 'package:bedesten/Companent/square_title.dart';
import 'package:bedesten/LoginClass/User.dart';
import 'package:bedesten/Screens/SingUpScreen.dart';
import 'package:bedesten/wigets/navbar_roots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';


class Login_screen extends StatefulWidget {
  const Login_screen({super.key});

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _PassNcontroller = TextEditingController();
  String? _errorMesage;
  String? _errorPassMesage;
  late final bool loggedIn;

  final storage = FlutterSecureStorage(); // flutter_secure_storage  kaydetme

  void _validateInput() {
    setState(() {
      if (_userNamecontroller.text.isNotEmpty) {
        _errorMesage = null;
        if(_PassNcontroller.text.isNotEmpty){
          _errorPassMesage=null;
          login();
          //Navigator.push(
          //  context,
          //  MaterialPageRoute(builder: (context) => navbar_roots()),
          //);
        }else{
          _errorPassMesage = AppLocalizations.of(context).translate("login._errorPassMesage");
        }
      } else {

        _errorMesage = AppLocalizations.of(context).translate("login._errorMesage");
      }
    });
  }
  void login() async {
    try {
      Response response = await post(
        Uri.parse("http://192.168.1.102:8887/api/v1/Auth/log-in"),
        body: {
          'email': _userNamecontroller.text.toString(),
          'password': _PassNcontroller.text.toString(),
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        AuthResponse authResponse = AuthResponse.fromJson(jsonResponse);
        var user = authResponse.user.name;
        if (user != null) {

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  navbar_roots(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                var begin = Offset(0.0, -1.0);
                var end = Offset.zero;
                var curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
           await saveUserData(authResponse); // Giriş yaptıktan sonra kullanıcı Bilgilerini SharedPreferences a kaydeder ve bir sonraki girişte login istemez
         //  checkData();
        } else {
          print("user Boş");
        }
      } else {
        print("Sunucuya Bağlanılamadı");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool passToggle = true;
  void GoToLoginPage (BuildContext context){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SingUpScreen()));
  }
  /*Future<void> loadUserDataToModel(UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token') && prefs.containsKey('user')) {
      String? token = prefs.getString('token');
      String? userJson = prefs.getString('user');

      if (token != null && userJson != null) {
        User user = User.fromJson(json.decode(userJson));
        AuthResponse authResponse = AuthResponse(user: user, token: token);

        userModel.setUserAndToken(authResponse);
      }
    }
  }*/

  Future<void> saveUserData(AuthResponse authResponse) async {
    try {
      // Token'ı güvenli bir şekilde kaydet
      await storage.write(key: 'token', value: authResponse.token);

      // User bilgisini güvenli bir şekilde kaydet
      // User objesini JSON'a çevirerek kaydediyoruz
      await storage.write(key: 'user', value: json.encode(authResponse.user.toJson()));
    } catch (e) {
      print("saveUserData hatası: $e");
    }
  }
  Future<void> checkData() async {
    try {
      String? token = await storage.read(key: 'token');
      String? userJson = await storage.read(key: 'user');

      if(token != null && userJson != null) {
        print("Token: $token");
        print("User: $userJson");
      } else {
        print("Veri kaydedilmedi.");
      }
    } catch (e) {
      print("Veri kontrol hatası: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    // Tema verisini al
    ThemeData theme = Theme.of(context);
    return Material(
      color: theme.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Padding(padding: EdgeInsets.all(20),
              child: Image.asset("images/login_bedesten_logo.png"),),
              SizedBox(height: 10,),
              Padding(padding: EdgeInsets.all(10),
              child: TextField(
                controller: _userNamecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(AppLocalizations.of(context).translate("login.email"),),
                  prefixIcon: Icon(Icons.person),
                  errorText: _errorMesage,
                ),
              ),
              ),
              Padding(padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _PassNcontroller,
                  obscureText: passToggle ? true : false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(AppLocalizations.of(context).translate("login.password")),
                      prefixIcon: Icon(Icons.lock),
                      errorText: _errorPassMesage,
                      suffixIcon: InkWell(
                        onTap: (){
                          if(passToggle == true){
                            passToggle = false;
                          }else{
                            passToggle = true;
                          }
                          setState(() {});
                        },
                        child: passToggle 
                            ? Icon(CupertinoIcons.eye_slash_fill)
                            : Icon(CupertinoIcons.eye_slash)
                      ),

                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(AppLocalizations.of(context).translate("login.I_dont_remember_my_password"),style: TextStyle(color: Colors.grey),),
                    const SizedBox(width: 4,),
                    new GestureDetector(
                      onTap: () {

                      },
                      child: new Text(AppLocalizations.of(context).translate("login.reset_my_password"),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  child: MyButton(
                    onTap: () {

                      _validateInput();

                    },

                    buttonText: AppLocalizations.of(context).translate("login.Login_Button"),
                    buttonColor: Colors.black,
                    textColor: Colors.white,
                    buttonHeight: MediaQuery.of(context).size.height/50,
                    buttonWeight: MediaQuery.of(context).size.width/50,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,),
                ),
              ),
              SizedBox(height: 20,),



              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child:  Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(AppLocalizations.of(context).translate("login.Dont_you_have_a_search_text_account"),style: TextStyle(color: Colors.grey.shade700),),
                    ),
                    Expanded(
                      child:  Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context).translate("login.Dont_you_have_a_search_text_account"),style: TextStyle(color: Colors.grey),),
                  const SizedBox(width: 4,),
                  new GestureDetector(
                    onTap: () => GoToLoginPage(context),
                    child: new Text(AppLocalizations.of(context).translate("login.register"),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                  ),

                ],
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child:  Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(AppLocalizations.of(context).translate("login.search_text_or"),style: TextStyle(color: Colors.grey.shade700),),
                    ),
                    Expanded(
                      child:  Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google Button
                  SquareTitle(
                    imagePath: Theme.of(context).brightness == Brightness.dark
                        ? "images/login/google_icons_dark.png" // Koyu tema için resim
                        : "images/login/google_icons_light.png", // Açık tema için resim
                  ),

                  const SizedBox(width: 10),

                  // Apple Button
                  SquareTitle(
                    imagePath: Theme.of(context).brightness == Brightness.dark
                        ? "images/login/apple_icons_dark.png" // Koyu tema için resim
                        : "images/login/apple_icons_light.png", // Açık tema için resim
                  ),
                ],
              )

              
            ],
          ),
        ),
      ),
    );
  }
}







































