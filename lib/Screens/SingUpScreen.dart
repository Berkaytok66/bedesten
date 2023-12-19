import 'dart:convert';

import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/Screens/Login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPassController = TextEditingController();
  String? _errorMesageUserName;
  String? _errorEmailMesage;
  String? _errorPassMesage;
  String? _errorPassTekrarMesage;
  bool passtogle = true;

  void _validController(){
    setState(() {
      if(_userNamecontroller.text.isNotEmpty){
        _errorMesageUserName = null;
        if(_userEmailController.text.isNotEmpty){
          _errorEmailMesage = null;
          if(_userPassController.text.isNotEmpty){
            _errorPassMesage = null;
            login();
          }else{_errorPassMesage = AppLocalizations.of(context).translate("register._errorPassMesage");}
        }else{_errorEmailMesage = AppLocalizations.of(context).translate("register._errorEmailMesage");}
      }else{_errorMesageUserName =AppLocalizations.of(context).translate("register._errorMesageUserName");}
    });
  }
  void login() async {
    try {
      Response response = await post(
          Uri.parse("http://192.168.1.102:8887/api/v1/Auth/register"),
          body: {
            "username": _userNamecontroller.text.toString(),
            "email": _userEmailController.text.toString(),
            "name": _userNamecontroller.text.toString(),
            "password": _userPassController.text.toString(),
          });

      var responseBody = json.decode(response.body);
      print(response.statusCode);
      // Başarılı kayıt olma durumu için özel bir kontrol
      if (response.statusCode >= 200 &&response.statusCode <=400 && responseBody.containsKey('token')) {
         showSuccsesSabitMesaj(QuickAlertType.success,AppLocalizations.of(context).translate("register.Success_Mesage"),AppLocalizations.of(context).translate("register.Success"));
      } else if(responseBody.containsKey('username') || responseBody.containsKey('email')) {
        if(responseBody['username'][0] == "The username has already been taken.") {
          _errorMesageUserName = AppLocalizations.of(context).translate("register.This_username_already_exists");
        }
        if(responseBody['email'][0] == "The email has already been taken.") {
          _errorEmailMesage = AppLocalizations.of(context).translate("register.This_email_address_is_already_taken");
        }
        setState(() {});  // Hata mesajlarını güncellemek için
      } else {
        showSuccsesSabitMesaj(QuickAlertType.error,responseBody.toString(),AppLocalizations.of(context).translate("register.Server_Error")) ;


      }
    } catch (e) {
      showSuccsesSabitMesaj(QuickAlertType.error,AppLocalizations.of(context).translate("register.Failure"),e.toString());
    }
  }


  void showSuccsesSabitMesaj(QuickAlertType quickAlertType, String mesage, String tittle,) {
    QuickAlert.show(context: context, type: quickAlertType, text: mesage, title: tittle,onConfirmBtnTap: (){_navigateToLoginScreen();});
  }
  void _navigateToLoginScreen() {


    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Login_screen(),
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
  }



  void backLogin (BuildContext context){
     Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => Login_screen()));
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
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.all(20),
              child: Image.asset("images/kayit_ol_logo.png"),
              ),
              SizedBox(height: 15,),
              Padding(padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
              child: TextField(
                controller: _userNamecontroller,
                decoration: InputDecoration(

                  labelText: AppLocalizations.of(context).translate("register.user_name"),
                  border: OutlineInputBorder(),
                  errorText: _errorMesageUserName,
                  prefixIcon: Icon(Icons.person),


                ),
              ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                child: TextField(
                  controller: _userEmailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate("register.email"),
                    border: OutlineInputBorder(),
                    errorText: _errorEmailMesage,
                    prefixIcon: Icon(Icons.mail),

                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                child: TextField(
                  controller: _userPassController,
                  obscureText: passtogle ? true : false,
                  decoration: InputDecoration(
                      labelText:AppLocalizations.of(context).translate("register.Password"),
                      border: OutlineInputBorder(),
                      errorText: _errorPassMesage,
                      prefixIcon: Icon(Icons.password),

                      suffixIcon: InkWell(
                        onTap:(){
                          if(passtogle == true){
                              passtogle =false;
                          }else{
                            passtogle = true;
                          }
                          setState(() {
                            
                          });
                        },
                        child: passtogle ? Icon(CupertinoIcons.eye_slash_fill): Icon(CupertinoIcons.eye_fill),
                      )
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                        onTap: () {_validController();},
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                          child: Center(
                            child: Text(AppLocalizations.of(context).translate("register.Register_Button"),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context).translate("register.I_already_have_an_account"),style: TextStyle(color: Colors.grey),),
                  const SizedBox(width: 4,),
                  new GestureDetector(
                    onTap: () => backLogin(context),
                    child: new Text(AppLocalizations.of(context).translate("register.Login"),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
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



































