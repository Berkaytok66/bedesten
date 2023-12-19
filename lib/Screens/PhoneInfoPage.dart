import 'dart:async';
import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/MesageScreen/SmsScreenPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class PhoneInfoPage extends StatefulWidget {
  /// PhoneInfoPage seçilen cihaz ile alakalı bilgileri saklar ve ekranda listeleyen sayfadır
  final String eventName;
  final String logoIndex;
  final String MarketlogoIndex;
  final String urunFiyat;
  final String locasyon;


  PhoneInfoPage({required this.eventName, required this.logoIndex,required this.urunFiyat,required this.locasyon,required this.MarketlogoIndex});
  @override
  _PhoneInfoPageState createState() => _PhoneInfoPageState();



}
class _PhoneInfoPageState extends State<PhoneInfoPage> with TickerProviderStateMixin {

  var ekranWidht;
  var ekranHeight;

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
    String marketLogoIndex = widget.MarketlogoIndex;
    String Locasyon = widget.locasyon;
    String Fiyat = widget.urunFiyat;
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
                        height:MediaQuery.of(context).size.width/2.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/${LogoIndex}.jpg"),
                            fit: BoxFit.fitHeight,
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
                        SizedBox(height: 5.0),
                        Text(
                          Fiyat,
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
                            Row(
                              children: [
                                Icon(CupertinoIcons.location_solid,size: 12,),
                                Text(Locasyon,style: TextStyle(fontSize: 12),)
                              ],
                            ),
                            Row(
                              children: [
                                Text("Tarih",style: TextStyle(fontSize: 12),)
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height:20),
                        Text(AppLocalizations.of(context).translate("PhoneInfoPage.Detail"),style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black54,
                        ),),
                        SizedBox(height:10),
                        Table(
                          children: [
                            TableRow(
                              children: [
                                Text(AppLocalizations.of(context).translate("PhoneInfoPage.BRAND")),
                                Text('Apple'),
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
                                Text(AppLocalizations.of(context).translate("PhoneInfoPage.MODEL")),
                                Text('Iphone 11 Pro Max'),
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
                                Text(AppLocalizations.of(context).translate("PhoneInfoPage.COLOUR")),
                                Text('Beyaz'),
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
                                Text(AppLocalizations.of(context).translate("PhoneInfoPage.GUARANTEE")),
                                Text('Yok'),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height:20),
                        Text(AppLocalizations.of(context).translate("PhoneInfoPage.Device_Status"),style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black54,
                        ),),
                        SizedBox(height:10),
                        Table(
                          children: [
                            TableRow(
                              children: [
                                Text(AppLocalizations.of(context).translate("PhoneInfoPage.device_status")),
                                // Yeni olarak Stack widget'ı ile birlikte LinearProgressIndicator ve Text widget'ı eklendi
                                SizedBox(
                                  height: 20, // LinearProgressIndicator ve Text için yükseklik
                                  child: Stack(
                                    alignment: Alignment.center, // Stack içindeki widget'ları ortalar
                                    children: <Widget>[
                                      LinearProgressIndicator(
                                        value: 0.5, // %50 doluluk için 0.5 değeri
                                        backgroundColor: Colors.grey[600],
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                      ),
                                      Text(
                                        ' ', // Yüzdelik değeri Text widget'ı içinde göster
                                        style: TextStyle(color: Colors.white), // Text rengini belirle
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                SizedBox(height: 10), // Boşluk eklemek için SizedBox
                                SizedBox(height: 10,),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(AppLocalizations.of(context).translate("PhoneInfoPage.Till")),
                                // Yeni olarak LinearProgressIndicator eklendi
                                SizedBox(
                                  height: 20, // LinearProgressIndicator ve Text için yükseklik
                                  child: Stack(
                                    alignment: Alignment.center, // Stack içindeki widget'ları ortalar
                                    children: <Widget>[
                                      LinearProgressIndicator(
                                        value: 0.5, // %50 doluluk için 0.5 değeri
                                        backgroundColor: Colors.grey[600],
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                      ),
                                      Text(
                                        ' ', // Yüzdelik değeri Text widget'ı içinde göster
                                        style: TextStyle(color: Colors.white), // Text rengini belirle
                                      ),
                                    ],
                                  ),
                                ),
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
                                Text(AppLocalizations.of(context).translate("PhoneInfoPage.Screen")),
                                // Yeni olarak LinearProgressIndicator eklendi
                                SizedBox(
                                  height: 20, // LinearProgressIndicator ve Text için yükseklik
                                  child: Stack(
                                    alignment: Alignment.center, // Stack içindeki widget'ları ortalar
                                    children: <Widget>[
                                      LinearProgressIndicator(
                                        value: 0.5, // %50 doluluk için 0.5 değeri
                                        backgroundColor: Colors.grey[600],
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                      ),
                                      Text(
                                        ' ', // Yüzdelik değeri Text widget'ı içinde göster
                                        style: TextStyle(color: Colors.white), // Text rengini belirle
                                      ),
                                    ],
                                  ),
                                ),
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
                                Text(AppLocalizations.of(context).translate("PhoneInfoPage.Battery")),
                                // Yeni olarak LinearProgressIndicator eklendi
                                SizedBox(
                                  height: 20, // LinearProgressIndicator ve Text için yükseklik
                                  child: Stack(
                                    alignment: Alignment.center, // Stack içindeki widget'ları ortalar
                                    children: <Widget>[
                                      LinearProgressIndicator(
                                        value: 0.5, // %50 doluluk için 0.5 değeri
                                        backgroundColor: Colors.grey[600],
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                      ),
                                      Text(
                                        ' ', // Yüzdelik değeri Text widget'ı içinde göster
                                        style: TextStyle(color: Colors.white), // Text rengini belirle
                                      ),
                                    ],
                                  ),
                                ),
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
                                Text(AppLocalizations.of(context).translate("PhoneInfoPage.Camera")),
                                // Yeni olarak LinearProgressIndicator eklendi
                                SizedBox(
                                  height: 20, // LinearProgressIndicator ve Text için yükseklik
                                  child: Stack(
                                    alignment: Alignment.center, // Stack içindeki widget'ları ortalar
                                    children: <Widget>[
                                      LinearProgressIndicator(
                                        value: 0.5, // %50 doluluk için 0.5 değeri
                                        backgroundColor: Colors.grey[600],
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                      ),
                                      Text(
                                        ' ', // Yüzdelik değeri Text widget'ı içinde göster
                                        style: TextStyle(color: Colors.white), // Text rengini belirle
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 10,),
                        Text("Acıklama"),
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
              children: [
                Text("${Fiyat} TL",style: TextStyle(fontSize: 20,color: Colors.redAccent,fontWeight: FontWeight.bold),)
              ],
            ),

            Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SmsScreenPage(imgLogoIndex: marketLogoIndex,NameIndex: Title,),));
                  },//Alıcıya sor buttonu sms ekranına yönlendir.
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
                            Icon(CupertinoIcons.chat_bubble,color: Colors.white,),
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
