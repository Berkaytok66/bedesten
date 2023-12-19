import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/Screens/HomeScreenFile/design_course_app_theme.dart';
import 'package:bedesten/Screens/PhoneInfoPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaiScreen extends StatelessWidget {

  ///Esnaflar > esnaf bilgileri > ürünleri içeren page


  String locasyon="Manisa / Alaşehir";

  final String eventName;
  final String logoIndex;
  BaiScreen({required this.eventName,required this.logoIndex});
  List urunList=[
      "phone_demo",
      "phone_demo",
      "phone_demo",
      "phone_demo",
      "phone_demo",
      "phone_demo",

  ];
  List urunName=[
      "Xiaomi sıfır cihaz",
      "Xiaomi sıfır cihaz",
      "Xiaomi sıfır cihaz",
      "Xiaomi sıfır cihaz",
      "Xiaomi sıfır cihaz",
      "Xiaomi sıfır cihaz",

  ];
  List urunFiat=[
    "1200",
    "7500",
    "6200",
    "6200",
    "6200",
    "6200",


  ];

  @override
  Widget build(BuildContext context) {
    // Ekran boyutunu al
    var screenSize = MediaQuery.of(context).size;
    // Ekran genişliğine göre crossAxisCount değerini belirle
    int crossAxisCount = screenSize.width > 600 ? 3 : 2; // 600px'den geniş ekranlar için 4 sütun, diğerleri için 2 sütun
    return Scaffold(
      appBar: AppBar(
        actions: [

        ],
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Replace with your color
        ),
        title: Text("Ürünler"),
      ),
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 3,),
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(

                            image: AssetImage(logoIndex),
                            fit: BoxFit.fitWidth,
                          ),
                          borderRadius: BorderRadius.circular(10)

                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(eventName,style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : DesignCourseAppTheme.darkerText,
                    ),),
                    SizedBox(height: 5,),
                    Text(locasyon,style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : DesignCourseAppTheme.darkerText,
                        fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width/40
                    ),),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFF00B6F0),
                            shape: BoxShape.circle
                          ),
                          child: Icon(
                            CupertinoIcons.chat_bubble_text_fill,
                            size: 20,
                            color: DesignCourseAppTheme.nearlyWhite,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFF00B6F0),
                              shape: BoxShape.circle
                          ),
                          child: Icon(
                            CupertinoIcons.location_solid,
                            size: 20,
                            color: DesignCourseAppTheme.nearlyWhite,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFF00B6F0),
                              shape: BoxShape.circle
                          ),
                          child: Icon(
                            Icons.favorite_border,
                            size: 20,
                            color: DesignCourseAppTheme.nearlyWhite,
                          ),
                        ),
                      ],
                    )
                  ],
                ),

              ],
            ),
            SizedBox(height: 10,),
            Divider(height: 5,color: Colors.red,),
            Container(
              height: MediaQuery.of(context).size.height/1.5,
              width: double.infinity,
          //    padding: EdgeInsets.only(top: 15,left: 15,right: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                ),

              ),
              child: SingleChildScrollView(

                child: Card(
                  elevation: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Text(AppLocalizations.of(context).translate("BaiScrenn.Products"),style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : DesignCourseAppTheme.darkerText,
                        fontWeight: FontWeight.w500,
                        fontSize: 21,
                      ),),
                      SizedBox(height: 10,),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 0.5,
                          // Ekran genişliğine göre childAspectRatio değerini ayarla
                          // Örneğin, tablet için başka bir aspect ratio belirleyebilirsiniz.
                          childAspectRatio: screenSize.width > 600 ? 1 : 0.8,
                        ),
                        itemCount:urunList.length,//eklenen bayi listesi burdan eklendi
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneInfoPage(urunFiyat: urunFiat[index],eventName: urunName[index],locasyon: locasyon,MarketlogoIndex: logoIndex,logoIndex: urunList[index])));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color:  Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Color(0xFFF8FAFB),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        spreadRadius: 2
                                    )
                                  ]
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height/7,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("images/${urunList[index]}.jpg"),
                                        fit: BoxFit.fitHeight,
                                      ),
                                     // borderRadius: BorderRadius.circular(0),  // Yuvarlak köşeler için
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(urunName[index],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).brightness == Brightness.dark ? Color(0xFFF8FAFB) :  Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(urunFiat[index],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 :  Colors.black54,
                                    ),
                                  ),

                                ],),
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
