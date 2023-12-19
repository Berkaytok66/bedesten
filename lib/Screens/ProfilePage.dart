import 'dart:convert';

import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/GenerateSettingScreen/GeneralSettingPage.dart';
import 'package:bedesten/PremiumTedarik/PremiumMainPage/PremiumPageMain.dart';
import 'package:bedesten/PremiumTedarik/PremiumPacketSettingFile/BuyControllerClass.dart';
import 'package:bedesten/PremiumTedarik/PremiumPacketSettingFile/BuyPremiumPage.dart';
import 'package:bedesten/Screens/Login_screen.dart';
import 'package:bedesten/Screens/SettingScrenn/AboutUsPage.dart';
import 'package:bedesten/Screens/SettingScrenn/ProfileSettingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final storage = FlutterSecureStorage();
  BuyControllerClass _isIlanControler = BuyControllerClass();// İlanlarım kontrol sayfası
  String? _token;
  String? _valueName;
  bool _isLoading = true; // Yükleme durumunu kontrol etmek için değişken

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _loadUserData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Future<void> _loadUserData() async {
    final userData = await storage.read(key: "user");
    _token = await storage.read(key: "token");
    if (userData != null && _token != null) {
      final userMap = jsonDecode(userData);
      _valueName = userMap['name'];
      // _MailController.text = userMap['email'];
      //_controllerAbout.text = userMap['bio'];
      //_controllerPhone.text = userMap['phone'];
      // UI'ı güncellemek için setState kullanın
      setState(() {
        _isLoading = false; // Yükleme tamamlandı
      });


    }
  }
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context).translate("SettingScreenHome.Profile"),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,

                    ),

                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                if (_isIlanControler.hasBoughtPremium){
                  ///Bai sayfası
                  navigateToPage(context, PremiumMainPage(),begin: Offset(0.0, -1.0));
                }else(
                ///kullanıcı sayfası
                );
              },
              child: Card(
                  elevation: 20,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15,
                                    spreadRadius: 6,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *0.2,
                                    height: MediaQuery.of(context).size.height *0.1,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage("https://avatars.githubusercontent.com/u/93052055?s=400&u=edbdbc2d6f5712c21dd69ea109971e6cac828f0b&v=4"),
                                        fit: BoxFit.fitHeight,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(child: Stack(

                            children: [
                              Positioned(
                                top: 0,
                                left: 15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, // Tüm çocukları sola hizalar
                                  children: [
                                    if (_isLoading)
                                      Center(child: CircularProgressIndicator())
                                    else
                                      Text(_valueName ?? 'İsim yüklenemedi',style: TextStyle(fontSize: 20),), // İlk Text widget'ı
                                    Text("Ürün Listeme Git",style: TextStyle(fontSize: 14),), // İkinci Text widget'ı
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios_rounded), // İkonunuzu buraya yerleştirin
                                  onPressed: () {
                                    // İkon buton tıklama işlevi
                                  },
                                ),
                              )
                            ],
                          ))
                        ],),],)
              ),
            ),

            SizedBox(height: 20,),
            ListTile(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ProfileSettingScreen();
                  },
                );

              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade800,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: Text(AppLocalizations.of(context).translate("SettingScreenHome.Profile_Settings"),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  )),
              trailing: Icon(Icons.arrow_forward_ios_rounded,size: 12,),
            ),
            SizedBox(height: 10,),
            ListTile(
              onTap: (){

                navigateToPage(context, BuyPremiumPage(),begin: Offset(0.0, -1.0));

              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  shape: BoxShape.circle,

                ),
                child: Icon(
                  CupertinoIcons.cart_badge_plus,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: Text(AppLocalizations.of(context).translate("SettingScreenHome.View_Package"),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  )),
              trailing: Icon(Icons.arrow_forward_ios_rounded,size: 12,),
            ),
            SizedBox(height: 10,),
            ListTile(
              onTap: (){},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: Text(AppLocalizations.of(context).translate("SettingScreenHome.Notification_Settings"),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  )),
              trailing: Icon(Icons.arrow_forward_ios_rounded,size: 12,),
            ),
            SizedBox(height: 10,),
            ListTile(
              onTap: (){
                navigateToPage(context, AboutUsPage(),begin: Offset(4.0, -1.0));
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade500,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: Text(AppLocalizations.of(context).translate("SettingScreenHome.About_Us"),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  )),
              trailing: Icon(Icons.arrow_forward_ios_rounded,size: 12,),
            ),
            SizedBox(height: 10,),
            ListTile(
              onTap: ()  {
                navigateToPage(context, GeneralSettingPage(),begin: Offset(4.0, -1.0));

              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: Text(AppLocalizations.of(context).translate("SettingScreenHome.General_Settings"),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  )),
              trailing: Icon(Icons.arrow_forward_ios_rounded,size: 12,),
            ),
            Divider(height: 40,),
            SizedBox(height: 20,),
            ListTile(
              onTap: () async {
                // Yüklenme göstergesini göster
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 10),
                            Text(AppLocalizations.of(context).translate("SettingScreenHome.Logging_out_Please_Wait")),
                          ],
                        ),
                      ),
                    );
                  },
                );

                await Future.delayed(Duration(seconds: 2));

                await storage.deleteAll();

                // Çıkış işlemi tamamlandığında yüklenme göstergesini kapat
                Navigator.of(context).pop();

                // Kullanıcıyı Login_screen'e yönlendir ve önceki tüm sayfaları sil
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login_screen()),
                      (Route<dynamic> route) => false,
                );
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: Text(
                AppLocalizations.of(context).translate("SettingScreenHome.Log_Out"),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void navigateToPage(BuildContext context, Widget page, {Offset begin = Offset.zero, Offset end = Offset.zero, Curve curve = Curves.ease}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

}




