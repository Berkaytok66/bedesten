import 'dart:convert';
import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/PremiumTedarik/PremiumMainPage/RepairPage.dart';
import 'package:bedesten/PremiumTedarik/PremiumMainPage/UpdateAndRemoveAd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PremiumMainPage extends StatefulWidget {
  const PremiumMainPage({super.key});

  @override
  State<PremiumMainPage> createState() => _PremiumMainPageState();
}
enum MenuOptions { option1, option2, option3 }
class _PremiumMainPageState extends State<PremiumMainPage> {
  final storage = FlutterSecureStorage();
  String? _token;

  final TextEditingController _NameController = TextEditingController();
  //final TextEditingController _MailController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserData();
  }
  Future<void> _loadUserData() async {
    final userData = await storage.read(key: "user");
    _token = await storage.read(key: "token");
    if (userData != null && _token != null) {
      final userMap = jsonDecode(userData);
      _NameController.text = userMap['name'];
     // _MailController.text = userMap['email'];
      //_controllerAbout.text = userMap['bio'];
      //_controllerPhone.text = userMap['phone'];



    }
  }
  List<Product> products = [
    Product('Ürün 1', 'images/phone_demo.jpg'),
    Product('Ürün 2', 'images/phone_demo.jpg'),
    Product('Ürün 2', 'images/phone_demo.jpg'),
    Product('Ürün 2', 'images/phone_demo.jpg'),
    Product('Ürün 2', 'images/phone_demo.jpg'),
    Product('Ürün 2', 'images/phone_demo.jpg'),
    Product('Ürün 2', 'images/phone_demo.jpg'),
    Product('Ürün 2', 'images/phone_demo.jpg'),
    Product('Ürün 2', 'images/phone_demo.jpg'),
    Product('Ürün 2', 'images/phone_demo.jpg'),
    // Daha fazla ürün eklenebilir
  ];
  @override
  Widget build(BuildContext context) {
    // Burada ekran boyutlarını alıyoruz
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(

        title: Text(AppLocalizations.of(context).translate("SettingScreenHome.My_business")),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // İkon rengi
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          PopupMenuButton<MenuOptions>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (MenuOptions result) {
              // Handle your action on selection here
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
              const PopupMenuItem<MenuOptions>(
                value: MenuOptions.option1,
                child: Row(
                  children: [
                    Icon(CupertinoIcons.settings_solid,color: Colors.blue,size: 18,),
                    SizedBox(width: 5,),
                    Text("Ayarlar"),
                  ],
                ),
              ),
              const PopupMenuItem<MenuOptions>(
                value: MenuOptions.option2,
                child: Row(
                  children: [
                    Icon(CupertinoIcons.person,color: Colors.blue,size: 18,),
                    SizedBox(width: 5,),
                    Text("Profil Ayarları"),
                  ],
                ),
              ),
              const PopupMenuItem<MenuOptions>(
                value: MenuOptions.option3,
                child:  Row(
                  children: [
                    Icon(Icons.share,color: Colors.blue,size: 18,),
                    SizedBox(width: 5,),
                    Text("Paylaş"),
                  ],
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor, // AppBar arkaplan rengi
        elevation: 0, // Gölgelik kaldırıldı
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    CircleAvatar(
                    backgroundImage: AssetImage('images/logo/logo.png'),
                    radius: screenSize.width *0.08,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          textAlign: TextAlign.start,
                          controller: _NameController,
                          readOnly: true, // Yazma iznini kapatır.
                          decoration: InputDecoration(
                            border: InputBorder.none, // Kenarlık yok
                          ),
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ),),

                  ],
                ),
                SizedBox(height: 10),
                Text("Hesap Durumu"),
                Divider(color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(CupertinoIcons.rosette,color: Colors.blue,),
                        Text('Rozet'),
                      ],
                    ),
                    SizedBox(width: 5,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(CupertinoIcons.checkmark_seal_fill,color: Colors.blue,),
                        Text('Onaylı'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),

                MaterialButton(
                  color: Colors.red,
                   shape: StadiumBorder(),
                  onPressed: () {
                    // Profil düzenleme sayfasına yönlendirme
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RepairPage())
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Tamir Hizmeti',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  minWidth: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                )
                

              ],
            ),
          ),
          // Burada kullanıcının ilanlarını gösteren bir widget eklenebilir
          // Örneğin GridView.builder kullanılabilir

          Center(child: Text("Ürünlerim",style: TextStyle(fontSize: 22),)),
          Divider(color: Colors.black),
          Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Card(
                elevation: 30.0,
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Satır başına düşen ürün sayısı
                    crossAxisSpacing: 20, // Yatay aralık
                    mainAxisSpacing: 20, // Dikey aralık
                    childAspectRatio: 0.70, // Genişlik ve yükseklik oranı (daha yüksek kutular için bu değeri azaltın)
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        print(products[index].name);

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UpdateAndRemoveAd())
                        );
                      },
                      child: Card(
                        elevation: 30.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch, // Resmi yatay olarak genişlet
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  products[index].imageUrl,
                                  fit: BoxFit.fitHeight, // Resmi orantılı olarak sığdır
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                products[index].name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              child: OutlinedButton(
                                onPressed: () {
                                  // Respond to button press
                                },
                                child: Text("Öne Çıkart"),
                              )
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;

  Product(this.name, this.imageUrl);
}