import 'dart:convert';
import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ProfileSettingScreen extends StatefulWidget {
  @override
  _ProfileSettingScreenState createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final storage = FlutterSecureStorage();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAbout = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await storage.read(key: "user");
    _token = await storage.read(key: "token");
    if (userData != null && _token != null) {
      final userMap = jsonDecode(userData);
      _controllerName.text = userMap['name'];
      _controllerEmail.text = userMap['email'];
      _controllerAbout.text = userMap['bio'];
      _controllerPhone.text = userMap['phone'];



    }
  }
  //Profil bilgilerini güncelle
  Future<void> _updateProfile(String name, String bio,String phone) async {
    print("Token: $_token");
    final url = "http://192.168.1.102:8887/api/v1/profile/update-profile";
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_token" // Token burada
    };
    final body = jsonEncode({"name": name, "bio": bio,"phone": phone});
    final response = await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      print("Profil başarıyla güncellendi");
      await _updateLocalUserData(name, bio,phone);
    } else {
      print("Profil güncellenirken bir hata oluştu: ${response.body}");
    }
  }

  Future<void> _updateLocalUserData(String name, String bio,String phone) async {
    final userData = await storage.read(key: "user");
    if (userData != null) {
      final userMap = jsonDecode(userData);
      userMap['name'] = name;
      userMap['bio'] = bio;
      userMap['phone'] = phone;
      await storage.write(key: "user", value: jsonEncode(userMap));
    }
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppBar(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [

                  _buildProfileInformation(),
                  SizedBox(height: 40,),
                  _buildContactInformation(),
                  SizedBox(height: 40,),
                  _buildUpdatePasswordTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(),
        TextButton(
          onPressed: () => _updateProfile(_controllerName.text,_controllerAbout.text,_controllerPhone.text),
          child: Text(AppLocalizations.of(context).translate("SettingProfileScreenHome.save"), style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildProfileInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).translate("SettingProfileScreenHome.Basic_Knowledge"), style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        _buildProfilePhotoAndNameField(),
        _buildAboutField(),
      ],
    );
  }

  Widget _buildProfilePhotoAndNameField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfilePhoto(),
        SizedBox(width: 15),
        Expanded(child: _buildNameTextField()),
      ],
    );
  }

  Widget _buildProfilePhoto() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CircleAvatar(
          radius: MediaQuery.of(context).size.width / 8,
          backgroundImage: NetworkImage("https://avatars.githubusercontent.com/u/93052055?s=400&u=edbdbc2d6f5712c21dd69ea109971e6cac828f0b&v=4"),
        ),
        _buildAddPhotoIcon(),
      ],
    );
  }

  Widget _buildAddPhotoIcon() {
    return GestureDetector(
      onTap: () {

      },
      child: CircleAvatar(
        backgroundColor: Colors.blue.withOpacity(0.9),
        radius: 13,
        child: Icon(Icons.add, color: Colors.white, size: 20.0),
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextField(
      controller: _controllerName,
      maxLength: 20,
      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate("SettingProfileScreenHome.User_Name")),
    );
  }

  Widget _buildAboutField() {
    return TextField(
      controller: _controllerAbout,
      maxLength: 120,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate("SettingProfileScreenHome.write_something_about")),
    );
  }

  Widget _buildContactInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        Text(AppLocalizations.of(context).translate("SettingProfileScreenHome.Contact_information"), style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        _buildPhoneNumberField(),
        SizedBox(height: 20,),
        _buildEmailField(),
      ],
    );
  }

  Widget _buildPhoneNumberField() {
    return IntlPhoneField(
      initialCountryCode: 'TR',
      controller: _controllerPhone,
      onChanged: (phone) {
        print(phone.completeNumber);
      },
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

  Widget _buildEmailField() {
    // Temaya göre renkleri burada tanımlayabiliriz.
    var inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    var labelStyle = inputDecorationTheme.labelStyle ??
        TextStyle(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black,
        );
    return TextField(
      controller: _controllerEmail,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate("SettingProfileScreenHome.Email_address"),
        labelStyle: labelStyle,
      ),
      // TextField'ın etkin olup olmadığı durumu.
      enabled: false,
      // Etkin değilken text rengini değiştirmek için.
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildUpdatePasswordTile() {
    return ListTile(
      onTap: () {
        _showPasswordChangeDialog(context);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.cyan.shade800,
        child: Icon(CupertinoIcons.lock_shield_fill, color: Colors.white, size: 25),
      ),
      title: Text(AppLocalizations.of(context).translate("SettingProfileScreenHome.Update_My_Password"), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
    );
  }
  void _showPasswordChangeDialog(BuildContext context) {
    final TextEditingController _CurrentPassword = TextEditingController();
    final TextEditingController _NewPassword = TextEditingController();
    final TextEditingController _NewPasswordAgain = TextEditingController();
    var passwordUpdateTimer = "02.07.2000";
    //Hata mesajları String Tutucu
    String? _ErrorMesageCurrentPassword;
    String? _ErrorMesageNewPassword;
    String? _ErrorMesageNewPasswordAgain;
    //Şifre Standartlara uyuyormu kontrol
    bool validatePassword(String password) {
      // En az 8 karakter olmalı
      if (password.length < 8) return false;
      // Rakam içermeli
      bool hasDigit = password.contains(RegExp(r'\d'));
      // Harf içermeli
      bool hasLetter = password.contains(RegExp(r'[a-zA-Z]'));

      return hasDigit && hasLetter;
    }

    //Password Update Fonksiyon
    Future<void> updatePassword(String token, String currentPassword, String newPassword) async {
      final url = Uri.parse('http://192.168.1.102:8887/api/v1/profile/update-password');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({
        'password': currentPassword,
        'new_password': newPassword,
      });

      try {
        final response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          if (responseBody['success'] == true) {
            print('Şifre başarıyla güncellendi!');
            showSuccsesSabitMesaj(QuickAlertType.success,AppLocalizations.of(context).translate("SettingProfileScreenHome.Your_password_has_been_successfully_updated"),AppLocalizations.of(context).translate("SettingProfileScreenHome.successfully"));
          } else {
            print('Şifre güncelleme başarısız: ${responseBody['message']}');
            showSuccsesSabitMesaj(QuickAlertType.error,"${AppLocalizations.of(context).translate("SettingProfileScreenHome.An_error_was_encountered_while_updating_the_password_Mistake")} ${responseBody['message']}",AppLocalizations.of(context).translate("SettingProfileScreenHome.Error_Found"));
          }
        } else {
          print('Şifre güncelleme başarısız: ${response.body}');
          showSuccsesSabitMesaj(QuickAlertType.error,"${AppLocalizations.of(context).translate("SettingProfileScreenHome.A_connection_to_the_server_could_not_be_established_Mistake")} ${response.body}",AppLocalizations.of(context).translate("SettingProfileScreenHome.Error_Found"));
        }
      } catch (error) {
        print('Bir hata oluştu: $error');
        showSuccsesSabitMesaj(QuickAlertType.error,"${AppLocalizations.of(context).translate("SettingProfileScreenHome.Something_Went_Wrong")} ${error}",AppLocalizations.of(context).translate("SettingProfileScreenHome.Unknown_Error"));
      }
    }

    Future<void> Controller() async{
      if (_CurrentPassword.text.isNotEmpty){
          if(_NewPassword.text.isNotEmpty){
            if(_NewPasswordAgain.text.isNotEmpty){
              if(_NewPassword.text == _NewPasswordAgain.text){
                if(validatePassword(_NewPassword.text)){
                  print(_CurrentPassword.text);
                  print(_NewPasswordAgain.text);
                  updatePassword(_token!,_CurrentPassword.text,_NewPasswordAgain.text);

                }else{
                  setState(() {
                    _ErrorMesageNewPassword = AppLocalizations.of(context).translate("SettingProfileScreenHome.Set_a_valid_password");
                  });
                }
              }else{
                setState(() {
                  _ErrorMesageNewPasswordAgain = AppLocalizations.of(context).translate("SettingProfileScreenHome.The_entered_password_does_not_match");
                });
              }
            }else{
              setState(() {
                _ErrorMesageNewPasswordAgain = AppLocalizations.of(context).translate("SettingProfileScreenHome.Please_enter_your_password_again");
              });
            }
          }else{
            setState(() {
              _ErrorMesageNewPassword = AppLocalizations.of(context).translate("SettingProfileScreenHome.The_new_password_cannot_be_left_blank");
            });
          }
      }else{
        setState(() {
          _ErrorMesageCurrentPassword = AppLocalizations.of(context).translate("SettingProfileScreenHome.Current_password_cannot_be_left_blank");
        });
      }
    }


    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: EdgeInsets.all(0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffb7b7b7),
                  Color(0xFFEFE8E8),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Text(
                    'berkaytoktm - Bedesten',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black54),
                  ),
                  SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context).translate("SettingProfileScreenHome.Change_Password"),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context).translate("SettingProfileScreenHome.Change_Password_info_one"),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context).translate("SettingProfileScreenHome.Change_Password_info_Two"),

                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 40),
                  Text("${AppLocalizations.of(context).translate("SettingProfileScreenHome.Current_password_Updated")}${passwordUpdateTimer}", style: TextStyle(color: Colors.black)),
                  SizedBox(height: 5),
                  TextField(
                    controller: _CurrentPassword,
                    decoration: InputDecoration(
                      errorText: _ErrorMesageCurrentPassword,
                      hintText: AppLocalizations.of(context).translate("SettingProfileScreenHome.Current_Password"),
                      hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black54,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _NewPassword,
                    decoration: InputDecoration(
                      errorText: _ErrorMesageNewPassword,
                      hintText: AppLocalizations.of(context).translate("SettingProfileScreenHome.New_Password"),
                      hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black54,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _NewPasswordAgain,
                    decoration: InputDecoration(
                      errorText: _ErrorMesageNewPasswordAgain,
                      hintText: AppLocalizations.of(context).translate("SettingProfileScreenHome.Retype_new_password"),
                      hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black54,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      //TODO: Şifremi unuttum işlemleri
                    },
                    child: Text(AppLocalizations.of(context).translate("SettingProfileScreenHome.Did_you_forget_your_password"), style: TextStyle(color: Colors.blue)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/9),
                  Divider(),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50), // Bu, ElevatedButton'un genişliğini tamamına yayar ve yüksekliğini 50 olarak belirler.
                          foregroundColor: Colors.blue
                      ),
                      onPressed: () {
                        //TODO: Şifre değiştirme işlemleri
                        setState(() {
                          Controller();
                        });

                      },
                      child: Text(AppLocalizations.of(context).translate("SettingProfileScreenHome.Update_My_Password"), style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 1),  // Düğme ile alt kenar arasındaki boşluğu sağlar.
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showSuccsesSabitMesaj(QuickAlertType quickAlertType, String mesage, String tittle,) {
    QuickAlert.show(
        context: context,
        type: quickAlertType,
        text: mesage,
        title: tittle,
        onConfirmBtnTap: (){
            Navigator.of(context).pop();
          }
        );
  }

}
