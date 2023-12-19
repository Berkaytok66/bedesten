import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/Screens/HomeScreenFile/SecondHandStore/SecondHandStoreHome.dart';
import 'package:bedesten/Screens/HomeScreenFile/popular_course_list_view.dart';
import 'package:bedesten/Screens/SettingScrenn/ProfileSettingScreen.dart';
import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';

String searchQuery = ""; //Araama işrevi için global değişken
class DesignCourseHomeScreen extends StatefulWidget {

  @override
  _DesignCourseHomeScreenState createState() => _DesignCourseHomeScreenState();
}
AnimationController? animationController;

class _DesignCourseHomeScreenState extends State<DesignCourseHomeScreen> {
  CategoryType categoryType = CategoryType.ui;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    getSearchBarUI(),
                    getCategoryUI(),
                    Flexible(
                      child: getEsnafUI(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       /* Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            AppLocalizations.of(context).translate("home_design_course.Category"),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),*/
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
              const SizedBox(
                width: 16,
              ),
             /* getButtonUI(
                  CategoryType.coding, categoryType == CategoryType.coding),
              const SizedBox(
                width: 16,
              ),*/
              getButtonUI(
                  CategoryType.basic, categoryType == CategoryType.basic),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget getEsnafUI() {
    switch (categoryType) {
      case CategoryType.ui:
       return getEsnaflar();
      //case CategoryType.coding:
       // return getTamirUI();
      case CategoryType.basic:
        return getEldenUI();
      default:
        return getEsnaflar(); // default olarak CihazlarUI döndürüyoruz.
    }

  }
  Widget getEsnaflar(){
    return Padding(

      padding: const EdgeInsets.only( left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         /* Text(
            AppLocalizations.of(context).translate("home_design_course.Businesses_Offering_Sales_Services"),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),*/
          Flexible(
            child: PopularCourseListView(
              callBack: () {
                // moveTo();
              },
            ),
          )
        ],
      ),
    );
  }
  /*Widget getTamirUI() {
    return Padding(

      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         /* Text(
            AppLocalizations.of(context).translate("home_design_course.Businesses_Providing_Repair_Services"),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),*/
          Flexible(
            child: TamirHomePage(
              callBack: () {

              },
            ),
          )
        ],
      ),
    );

  }*/

  Widget getEldenUI() {
    return Padding(

      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*Text(
            AppLocalizations.of(context).translate("home_design_course.Users_Who_Sell"),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),*/
          Flexible(
            child: SecondHandStoreHome(
              callBack: () {

              },
            ),
          )
        ],
      ),
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = AppLocalizations.of(context).translate("home_design_course.Tradesmen");
    } /*else if (CategoryType.coding == categoryTypeData) {
      txt = AppLocalizations.of(context).translate("home_design_course.Repair");
    } */else if (CategoryType.basic == categoryTypeData) {
      txt = AppLocalizations.of(context).translate("home_design_course.2nd_hand");
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).brightness == Brightness.dark ? Colors.blue : Colors.blueAccent // Tıklandığında renk
                : Theme.of(context).brightness == Brightness.dark ? Colors.white24 : Colors.white, //Tıklanmayan textlerin rengi
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.blueAccent)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blue,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });

            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white
                        : Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.92,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context) == Brightness.dark ? Colors.white38 : Colors.black12,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: DesignCourseAppTheme.darkerText,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context).translate("home_design_course.Search"),
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFFB9BABC),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: Color(0xFFB9BABC),

                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          onEditingComplete: () {},//Kullanıcı metni gitdikden sonra enter tuşu ile arama işrevi buraya eklenecek
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/6,
                      height: MediaQuery.of(context).size.height,
                      child: Icon(Icons.search, color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black,),
                    ),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.location_on_sharp),color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black,)
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Bedesten',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color:Theme.of(context).hintColor,
                  ),
                ),
                Text(
                  AppLocalizations.of(context).translate("home_design_course.Home_Page"),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color:Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Tıklama işlevselliğini buraya yazın, örneğin bir sayfaya yönlendirme yapmak.
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ProfileSettingScreen(),
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
            },
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage("https://avatars.githubusercontent.com/u/93052055?s=400&u=edbdbc2d6f5712c21dd69ea109971e6cac828f0b&v=4"),
            ),
          )
        ],
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}
