import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/Screens/BaiScreen.dart';
import 'package:bedesten/Screens/HomeScreenFile/TamirScrenPage/TamirInfoPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CourseInfoScreen extends StatefulWidget {
  ///Esnaflar > esnaf bilgilerini içeren page
  final String eventName;
  final String logoIndex;
  final int UrunSayisi;

  CourseInfoScreen({required this.eventName, required this.logoIndex,required this.UrunSayisi});
  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();

}

class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {


  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    String Title = widget.eventName;
    String LogoIndex = widget.logoIndex;
    int UrunIndex = widget.UrunSayisi;


    return Scaffold(
      appBar: AppBar(
        actions: [

          ///App bar geri cıkma özelliğini default olarak ekler
          ///3. gibi ek özellikler eklenebilir
        ],
        title: Text("Bayi Bilgileri"),
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Replace with your color
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(5),
              child: Stack(
                children: [
                  Padding(padding:  EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/3.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(LogoIndex),
                              fit: BoxFit.fitWidth,
                            ),
                            borderRadius: BorderRadius.circular(10.0),  // Yuvarlak köşeler için
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height /1.5,
              width: double.infinity,
              padding: EdgeInsets.only(top: 10,left: 15,right: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),

              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(//Bu text kaldırılabilir bu an sadece fazlalık
                            Title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            Title,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [Icon(CupertinoIcons.location_solid,size: 12,),Text("Manisa/Alaşehir",)],),
                              Row(children: [Icon(Icons.favorite_border)],),
                            ],
                          ),
                          Divider(),
                          SizedBox(height:20),
                          Text(AppLocalizations.of(context).translate("home_dessign_course.about_us"),style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,fontSize: 18),),
                          SizedBox(height:10),
                          Table(
                            children: [
                              TableRow(
                                children: [
                                  Text(AppLocalizations.of(context).translate("home_dessign_course.Experience")),//Tecrübe
                                  Text('3 Yıl'),
                                ],
                              ),
                              TableRow(
                                children: [
                                  SizedBox(height: 10), // Boşluk eklemek için SizedBox
                                  SizedBox(),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Text(AppLocalizations.of(context).translate("home_dessign_course.Services")),//Hizmetler
                                  Text('Android & İos'),
                                ],
                              ),
                              TableRow(
                                children: [
                                  SizedBox(height: 10), // Boşluk eklemek için SizedBox
                                  SizedBox(),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Text(AppLocalizations.of(context).translate("home_dessign_course.Total_product")),
                                  Text(UrunIndex.toString()),
                                ],
                              ),
                              TableRow(
                                children: [
                                  SizedBox(height: 10), // Boşluk eklemek için SizedBox
                                  SizedBox(),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Text(AppLocalizations.of(context).translate("home_dessign_course.Accessory")),
                                  Text('Yok'),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(height:20),

                          Text(AppLocalizations.of(context).translate("home_dessign_course.Explanation"),style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                              fontSize: 18
                          ),),
                          SizedBox(height: 15,),
                          Text("Ürün acıklaması buraya yazılacak varsayalımki acıklama uzun Ürün acıklaması buraya yazılacak varsayalımki acıklama uzun Ürün acıklaması buraya yazılacak varsayalımki acıklama uzun "),
                          Divider(),
                          SizedBox(height: 10,),

                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ),

          ],

        ),

      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        height: 70,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 2,
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (){//harita buttonu harita ekranına yönlendir.
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        TamirInfoPage(
                          eventName:Title,
                          logoIndex: LogoIndex,
                          locasyon: "Manisa/Alaşehir",),
                       )
                    );

                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/4,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text(
                                "Tamir",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              Icon(
                                CupertinoIcons.lock_shield_fill,
                                color: Colors.white,),
                            ],
                          ),
                        )
                    ),
                  ),
                )
              ],
            ),

            Row(
              children: [
                InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => BaiScreen(eventName:Title,logoIndex: LogoIndex,),));},//Alıcıya sor buttonu sms ekranına yönlendir.
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.7,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                "Ürünlere Bak",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}