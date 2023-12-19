// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'dart:io';
import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/PremiumTedarik/Class/BrandModels.dart';
import 'package:bedesten/PremiumTedarik/Class/SelectedMark.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_camera/camera/camera_whatsapp.dart';

class UpdateAndRemoveAd extends StatefulWidget {
  const UpdateAndRemoveAd({super.key});

  @override
  State<UpdateAndRemoveAd> createState() => _UpdateAndRemoveAdState();
}

class _UpdateAndRemoveAdState extends State<UpdateAndRemoveAd> {
  final files = ValueNotifier(<File>[]);
  final TextEditingController _controllerUrunName = TextEditingController();
  final TextEditingController _controllerUrunFiat = TextEditingController();
  BrandModels brandModels = BrandModels();
  @override
  void initState() {
    super.initState();
    files.addListener(() => setState(() {}));
    someFunction();
  }

  @override
  void dispose() {
    super.dispose();
    files.dispose();
  }
  void someFunction() async {
    await brandModels.loadData();

    String brand = 'Samsung';
    List<String> models = brandModels.getModelsByBrand(brand);
    print(models); // Samsung markasına ait modelleri yazdırır

    List<String> allBrands = brandModels.getBrands();
    print(allBrands); // Tüm markaları yazdırır
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Güncelle'),
        actions: <Widget>[
          TextButton(
              onPressed: (){
                ///Ürünü Kaldırma işlemi burda yapılır.
                },
              child: Text("İlanı Kaldır"))
        ],
          iconTheme: IconThemeData(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Replace with your color
          )
      ),
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 30,
                child: Container(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: files.value.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < files.value.length) {
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            // Resimlere çerçeve ekleyen Container
                            Container(
                              margin: EdgeInsets.all(5.0), // Çerçeve ile resim arasındaki boşluk
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue, // Çerçevenin rengi
                                  width: 3.0, // Çerçevenin kalınlığı
                                ),
                                borderRadius: BorderRadius.circular(10), // Çerçevenin yuvarlak köşeleri
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.file(
                                  File(files.value[index].path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () {
                                files.value.removeAt(index);
                                // ignore: invalid_use_of_protected_member
                                files.notifyListeners();
                              },
                            ),
                          ],
                        );
                      } else {
                        return files.value.length < 8 ? GestureDetector(
                          onTap: () async {
                            List<File>? newFiles = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WhatsappCamera(),
                              ),
                            );

                            if (newFiles != null) {
                              files.value = [...files.value, ...newFiles];
                            }
                          },
                          child: Container(
                            width: 100,
                            color: Colors.transparent,
                            child: Image.asset("images/add.png"),
                          ),
                        ) : Container(); // Eğer 8 resim varsa yeni ekleme butonunu gösterme
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          // Buraya diğer widgetlarınızı ekleyebilirsiniz

          _urunNameTextField(),
          _urunFiatTextField(),
          _ModelTextField(),
          Card(
            elevation: 10.0, // Gölge büyüklüğünü artırarak kartın daha belirgin hale gelmesini sağlar
            child: Column(
              children: [
                _DropdownTextFieldRepair(),

              ],
            ),
          ),
        ],
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            InkWell(
              onTap: (){

              },//Yayınla button
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
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
                          Expanded(
                            child: Text(
                              "İlanı Güncelle",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          Icon(CupertinoIcons.upload_circle_fill,color: Colors.white,),
                        ],
                      ),
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _urunNameTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            elevation: 10.0, // Gölge büyüklüğünü artırarak kartın daha belirgin hale gelmesini sağlar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.1, // Bu sayede tüm genişliği kaplar
                    child: TextField(
                      controller: _controllerUrunName,
                      readOnly: false, // Yazma iznini kapatır.
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).translate("UpdateAndRemoveAd.Product_Name"),
                   //       helperText: AppLocalizations.of(context).translate("RepairPage.Bai_Name_info") // Bilgilendirme metni.
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _urunFiatTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            elevation: 10.0, // Gölge büyüklüğünü artırarak kartın daha belirgin hale gelmesini sağlar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.1, // Bu sayede tüm genişliği kaplar
                    child: TextField(
                      controller: _controllerUrunFiat,
                      readOnly: false, // Yazma iznini kapatır.
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate("UpdateAndRemoveAd.price"),
                        //       helperText: AppLocalizations.of(context).translate("RepairPage.Bai_Name_info") // Bilgilendirme metni.
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _ModelTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            elevation: 10.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(  // TextField ve IconButton'ı içeren Row widget'ı
                      children: [
                        Expanded(  // TextField'ı genişletmek için Expanded kullanılır
                          child: TextField(
                            controller: _controllerUrunFiat,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).translate("UpdateAndRemoveAd.Brand_Model"),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(CupertinoIcons.arrow_down), // İkonunuzu buraya ekleyin
                          onPressed: () async {
                            // IconButton'a basıldığında yapılacak işlem
                            navigateToPage(context, SelectedMark(),begin: Offset(4.0, -1.0));

                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _DropdownTextFieldRepair(){

    const List<String> list = <String>['Hizmet Var', 'Hizmet Yok'];
    String dropdownValue; // Seçilen element burada tutulur, sunucuya verilecek değer

    return Row(
      children: [
        Expanded(
          // Text widget ekleniyor
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Donanım Onarım:",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        Expanded(
          // DropdownMenu widget için Container veya SizedBox kullanılıyor
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1), // Padding ekleyerek taşmayı önleyebiliriz

            child: DropdownMenu<String>(
              inputDecorationTheme: InputDecorationTheme(
                border: InputBorder.none,  // Çerçeveyi kaldırır
                // Diğer stil özelliklerini burada tanımlayabilirsiniz
              ),
              initialSelection: list.first,
              onSelected: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                  print("Selected Value: ${dropdownValue}");
                });
              },
              dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
          ),
        ),
      ],
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

class InfoSection extends StatelessWidget {
  final String title;
  final String content;

  const InfoSection({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(content),
    );
  }

}
