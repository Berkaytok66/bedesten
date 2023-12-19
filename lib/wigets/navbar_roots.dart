import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/Ekle/EklePage.dart';
import 'package:bedesten/MesageScreen/MessageScrenHom.dart';
import 'package:bedesten/PremiumTedarik/PremiumMainPage/PremiumPageMain.dart';
import 'package:bedesten/PremiumTedarik/PremiumPacketSettingFile/BuyControllerClass.dart';
import 'package:bedesten/Screens/FavoriteScreen.dart';
import 'package:bedesten/Screens/HomeScreenFile/home_design_course.dart';
import 'package:bedesten/Screens/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class navbar_roots extends StatefulWidget {
  const navbar_roots({Key? key}) : super(key: key);

  @override
  State<navbar_roots> createState() => _navbar_rootsState();
}

class _navbar_rootsState extends State<navbar_roots> {
  int _selectedIndex = 0;
  BuyControllerClass _isFabActive = BuyControllerClass();// FloatingActionButton bar değişkenliği
  final List<Widget> _screens = [
    DesignCourseHomeScreen(),
    MessageScrenHom(),
    FavoriteScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    _isFabActive.checkBuyControllerStatus();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Container(
          height: 70,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(CupertinoIcons.bold, AppLocalizations.of(context).translate("navbar_roots.Bedesten"), 0),
              _buildNavItem(CupertinoIcons.chat_bubble_2, AppLocalizations.of(context).translate("navbar_roots.Messages"), 1),
              SizedBox(width: 30), // FAB için boşluk bırakıyoruz.
              _buildNavItem(CupertinoIcons.square_favorites_alt_fill, AppLocalizations.of(context).translate("navbar_roots.My_Favorites"), 2),
              _buildNavItem(CupertinoIcons.settings_solid, AppLocalizations.of(context).translate("navbar_roots.Settings"), 3),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index)  {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: _selectedIndex == index ? Colors.blue : Colors.grey),
          Text(label, style: TextStyle(color: _selectedIndex == index ? Colors.blue : Colors.grey, fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blueGrey, Colors.blueAccent],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.4),
            blurRadius: 8,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          // _isFabActive true olduğunda Bai girişi aktif demektir

          if (_isFabActive.hasBoughtPremium) {
         //   print("FAB aktif.");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EklePage()),
            );

          } else {
            // _isFabActive false olduğunda Kullanıcı cihaz ekleme ekranı aktif demektir
          //  print("FAB pasif.");
            //_showMyBottomSheet(context);
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => EklePage(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.5, -1.0); // Başlangıç konumu (yukarıdan aşağı)
                  const end = Offset(0.0, -1.0); // Bitiş konumu (sıfır, yani normal konum)
                  const curve = Curves.ease; // Kullanılacak animasyon eğrisi

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          }

        },
        child: Icon(CupertinoIcons.camera_circle_fill, color: Colors.white,size: 70,),
        backgroundColor: Colors.transparent,

      ),
    );
  }


}

