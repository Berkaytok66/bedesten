import 'dart:async';
import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/MesageScreen/SmsScreenPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class TamirInfoPage extends StatefulWidget {
  /// TamirInfoPage seçilen cihaz ile alakalı bilgileri saklar ve ekranda listeleyen sayfadır
  final String eventName;
  final String logoIndex;
  final String locasyon;


  TamirInfoPage({required this.eventName, required this.logoIndex,required this.locasyon});
  @override
  _TamirInfoPageState createState() => _TamirInfoPageState();

}
class _TamirInfoPageState extends State<TamirInfoPage> with TickerProviderStateMixin {

  var ekranWidht;
  var ekranHeight;
  double k_puan = 3.5;
  double enlem = 0.0;
  double boylam = 0.0;

  Future<void> konumBilgisiAl() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      enlem = position.latitude;
      boylam = position.longitude;
    });
  }
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    String Title = widget.eventName;
    String LogoIndex = widget.logoIndex;
    String Locasyon = widget.locasyon;
    ekranWidht = MediaQuery.of(context).size.width;
    ekranWidht =MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [

        ],
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Replace with your color
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
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
                              fit:BoxFit.fitWidth,
                            ),
                            borderRadius: BorderRadius.circular(15.0),  // Yuvarlak köşeler için
                          ),
                        ),

                        Row(
                          children: [

                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: MediaQuery.of(context).size.height /1.5,
              width: double.infinity,
              padding: EdgeInsets.only(top: 20,left: 15,right: 15),
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
                          Text(
                            Title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(CupertinoIcons.location_solid,size: 12,),
                                  Text(Locasyon,style: TextStyle(fontSize: 12),)
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(height:20),
                          Text(AppLocalizations.of(context).translate("TamirInfoPage.Services"),style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black54,
                          ),),
                          SizedBox(height:10),
                          Table(
                            children: [
                              TableRow(
                                children: [
                                  Text(AppLocalizations.of(context).translate("TamirInfoPage.Fix")),
                                  Text('Var'),
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
                                  Text(AppLocalizations.of(context).translate("TamirInfoPage.Software_Repair")),
                                  Text('Var'),
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
                                  Text(AppLocalizations.of(context).translate("TamirInfoPage.Expertise")),
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
                                  Text(AppLocalizations.of(context).translate("TamirInfoPage.Estimated_repair_time")),
                                  Text('1 Saat'),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(height:20),
                          Divider(),
                          SizedBox(height: 10,),
                          Text(AppLocalizations.of(context).translate("TamirInfoPage.Explanation"),style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black54,
                          ),),
                          SizedBox(height: 15,),
                          Text("Ürün acıklaması buraya yazılacak varsayalımki acıklama uzun Ürün acıklaması buraya yazılacak varsayalımki acıklama uzun Ürün acıklaması buraya yazılacak varsayalımki acıklama uzun "),
                          Divider(),
                          SizedBox(height: 100,)
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
                children: List.generate(5, (index) {
                  // Kullanıcı puanına göre yıldız ikonunu belirle
                  IconData iconData;
                  if (index + 1 <= k_puan) {
                    iconData = Icons.star; // Her tam puan için dolu yıldız
                  } else if (index < k_puan) {
                    iconData = Icons.star_half; // Ondalıklı kısım için yarım yıldız
                  } else {
                    iconData = Icons.star_border; // Kalan için boş yıldız
                  }
                  return Icon(
                    iconData,
                    color: Colors.redAccent,
                  );
                }),
              ),

              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SmsScreenPage(imgLogoIndex: LogoIndex,NameIndex: Title,),));
                    }, // SmsScreenPage sayfasına yönlendir
                    child: Container(
                      width: MediaQuery.of(context).size.width/2.5,
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
                                  "Sohbete Başla",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                Icon(CupertinoIcons.chat_bubble, color: Colors.white,),
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
        )


    );

  }
}
