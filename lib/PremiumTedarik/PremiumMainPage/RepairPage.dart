import 'dart:async';
import 'dart:convert';
import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/PremiumTedarik/PremiumMainPage/Map/MapLocationsSettingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RepairPage extends StatefulWidget {
  @override
  _RepairPageState createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  final TextEditingController _controllerName = TextEditingController();

  final TextEditingController _controllerInfo = TextEditingController();
  String? _token;
  final storage = FlutterSecureStorage();

  String? selectedText;
  String? selectedTextRenk;
  String tersCografi = "";
  bool isTersCografiLoading = true;//TersCografi İşlemin yüklenme durumunu takip etmek için
  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  CameraPosition? initialCameraPosition;
  var startLocation;


  CameraPosition? initialCameraPosition2;
  Set<Marker> markers = Set();
  Marker? selectedMarker;
  LatLng? selectedLocation;

  double? latitude; //konumu tutmak için enlem konumu
  double? longitude;//konumu tutmak için boylam konumu

  Future<void> konum() async {
    var LocasyonInfo= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      startLocation = CameraPosition(target: LatLng(LocasyonInfo.latitude,LocasyonInfo.longitude));
    });
  }
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Konum servisinin etkin olup olmadığını kontrol edin
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Konum servisleri etkin değil.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Konum izinleri reddedildi.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Konum izinleri kalıcı olarak reddedildi, ayarları değiştiremeyiz.');
    }

    // Gerçek konum bilgisini al
    return await Geolocator.getCurrentPosition();
  }
  Future<void> _loadUserData() async {
    final userData = await storage.read(key: "user");
    _token = await storage.read(key: "token");
    if (userData != null && _token != null) {
      final userMap = jsonDecode(userData);
      _controllerName.text = userMap['name'];
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserData();
    _determineInitialPosition();
    _determineInitialPosition2(); // Dayalog için

   // konum();
  }
  Future<void> _determineInitialPosition2() async {
    var currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      initialCameraPosition2 = CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 14.0,
      );
      selectedLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
      _updateMarker(selectedLocation!);
      getPlaceMark(currentLocation.latitude, currentLocation.longitude);
    });
  }
  void _updateMarker(LatLng location) {
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId("selectedLocation"),
          position: location,
          draggable: true,
          onDragEnd: (newPosition) {
            selectedLocation = newPosition;
            getPlaceMark(newPosition.latitude, newPosition.longitude);
          },
        ),
      );
    });
  }
  Future<void> _determineInitialPosition() async {
    var currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      initialCameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 14.0,
      );
      getPlaceMark(currentLocation.latitude, currentLocation.longitude);
    });
  }
  Future<void> getPlaceMark(double latitude, double longitude) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(latitude, longitude);
      var firstPlacemark = placemarks.first;
      setState(() {
        tersCografi = "${firstPlacemark.country}/${firstPlacemark.administrativeArea}/${firstPlacemark.subAdministrativeArea}/${firstPlacemark.subLocality}/${firstPlacemark.thoroughfare}/${firstPlacemark.subThoroughfare}";
        isTersCografiLoading = false;
      });
      // _controllerLocation.text = "${firstPlacemark.country}/${firstPlacemark.administrativeArea}/${firstPlacemark.subAdministrativeArea}/${firstPlacemark.subLocality}/${firstPlacemark.thoroughfare}/${firstPlacemark.subThoroughfare}";
    } catch (e) {
      print("Ters coğrafi kodlama hatası: $e");
      setState(() {
        isTersCografiLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(

        title: Text("Tamir Hizmeti Paylaş"),
        // AppBar özelleştirmelerinizi burada yapın
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //CustomButton(title: TersCografi!, price: "Güncelle", onTap: () {}),
            FutureBuilder<Widget>(
              future: _Map(), // Asenkron fonksiyonunuzu burada çağırın
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Asenkron işlem devam ederken gösterilecek widget
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Hata oluştuysa gösterilecek widget
                  return Center(child: Text('Bir hata oluştu!'));
                } else {
                  // Asenkron işlem tamamlandığında gösterilecek widget
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(300), // Sağ alt köşeyi kıvır
                        ),
                        child: snapshot.data ?? Center(child: Text('Harita yüklenemedi!')),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 0,
                        child: Container(
                          // Burada PNG resminizi ekleyin
                          child: Image.asset('images/logo/logo.png'),
                          width: 100,  // İhtiyacınıza göre ayarlayın
                          height: 100, // İhtiyacınıza göre ayarlayın
                        ),
                      ),
                    ],
                  );
                }
              },
            ),

            SizedBox(height: 10),
            _isletmeNameTextField(),
            SizedBox(height: 20),
            Card(
              elevation: 10.0, // Gölge büyüklüğünü artırarak kartın daha belirgin hale gelmesini sağlar
              child: Column(
                children: [
                  _DropdownTextFieldRepair(),
                  _DropdownTextFieldSoftwareRepair(),
                  _DropdownTextFieldExpert(),
                  _DropdownTextEstimatedRepairTime(),
                ],
              ),
            ),

            SizedBox(height: 20),
            _Info(),
            SizedBox(height: 20),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            "Hizmete Başla",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          Icon(CupertinoIcons.rectangle_paperclip,color: Colors.white,),
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
  Future<Widget> _Map() async {
    print(initialCameraPosition);
    var ekranWidtg = MediaQuery.of(context).size.width;
    var ekranHeight = MediaQuery.of(context).size.height;

    // Özel marker ikonu oluşturma
    final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)), // İkonun boyutunu belirleyin
        'images/dialog/google_map_icons.png' // İkonunuzun yolunu buraya girin
    );
    // Marker oluşturma
    Set<Marker> markers = Set();
    if (initialCameraPosition != null) {
      markers.add(
          Marker(
            markerId: MarkerId('initialPos'),
            position: initialCameraPosition!.target, // initialCameraPosition'un LatLng değerini kullanır
            infoWindow: InfoWindow(
              title: tersCografi,  // Buraya marker'ınızın ismini yazabilirsiniz
              //snippet: 'Açıklama veya ek bilgi'  // İsteğe bağlı ekstra açıklama
            ),
            icon: customIcon, // Özel ikonu burada kullan
          )
      );
    }

    return SizedBox( width: ekranWidtg*1,height: ekranHeight*0.30,
      child: initialCameraPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition!,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);
        },
        onTap: (LatLng position) {
          // Navigator kullanarak yeni sayfaya yönlendirme
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MapLocationsSettingPage(),
            ),
          );
        },
      ),
    );
  }
  Widget _isletmeNameTextField() {

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
                      controller: _controllerName,
                      readOnly: true, // Yazma iznini kapatır.
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).translate("RepairPage.Bai_Name"),
                          helperText: AppLocalizations.of(context).translate("RepairPage.Bai_Name_info") // Bilgilendirme metni.
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
  Widget _DropdownTextFieldSoftwareRepair(){
    const List<String> list = <String>['Hizmet Var', 'Hizmet Yok'];
    String dropdownValue; // Seçilen element burada tutulur, sunucuya verilecek değer

    return Row(
      children: [
        Expanded(
          // Text widget ekleniyor
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Yazılım Onarım:",
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
  Widget _DropdownTextFieldExpert(){
    const List<String> list = <String>['Android', 'IOS', 'Android & iOS'];
    String dropdownValue; // Seçilen element burada tutulur, sunucuya verilecek değer

    return Row(
      children: [
        Expanded(
          // Text widget ekleniyor
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Uzman Alan:",
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
  Widget _DropdownTextEstimatedRepairTime(){
    const List<String> list = <String>['1 Saat', '2 Saat','3 Saat','4+ Saat'];
    String dropdownValue; // Seçilen element burada tutulur, sunucuya verilecek değer

    return Row(
      children: [
        Expanded(
          // Text widget ekleniyor
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Tahmini tamir süresi:",
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

  Widget _Info(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            elevation: 10.0, // Gölge büyüklüğünü artırarak kartın daha belirgin hale gelmesini sağlar

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/1.1, // Bu sayede tüm genişliği kaplar
                    child:TextField(
                      controller: _controllerInfo,
                      maxLength: 240,
                      maxLines: null, // Bu, maksimum satır sayısını sınırlamaz
                      keyboardType: TextInputType.multiline, // Çok satırlı metin girişi için klavyeyi ayarlar
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate("RepairPage.A_Few_Words_About_the_Service_I_Provide"),
                        helperText: AppLocalizations.of(context).translate("RepairPage.For_example_you_can_provide_information_about_software_and_iOS_repair"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

}

