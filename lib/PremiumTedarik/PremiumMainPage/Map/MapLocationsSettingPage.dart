import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konum Güncelle',
      home: MapLocationsSettingPage(),
    );
  }
}

class MapLocationsSettingPage extends StatefulWidget {
  @override
  _MapLocationsSettingPageState createState() => _MapLocationsSettingPageState();
}

class _MapLocationsSettingPageState extends State<MapLocationsSettingPage> {
  final TextEditingController _controllerMCS = TextEditingController();
  final TextEditingController _controllerIl = TextEditingController();
  final TextEditingController _controllerIlce = TextEditingController();
  final TextEditingController _controllerBinaNo = TextEditingController();
  final TextEditingController _controllerKat = TextEditingController();
  final TextEditingController _controllerDaire = TextEditingController();
  final TextEditingController _controllerAcikAdres = TextEditingController();
  GoogleMapController? mapController;
  LatLng _currentPosition = LatLng(37.42796133580664, -122.085749655962); // Default to a fallback location
  String _address = 'Searching...';
  Marker? _marker;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _updateMarker(_currentPosition);
      mapController?.animateCamera(CameraUpdate.newLatLngZoom(_currentPosition, 15.0));
    });
  }

  void _updateMarker(LatLng newPosition) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(newPosition.latitude, newPosition.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      _controllerMCS.text="${place.isoCountryCode} / ${place.subLocality} / ${place.thoroughfare}";
      _controllerIl.text = "${place.administrativeArea}";
      _controllerIlce.text="${place.subAdministrativeArea}";
      _controllerBinaNo.text="${place.subThoroughfare}";
    }

    setState(() {
      _marker = Marker(
        markerId: MarkerId('currentPos'),
        position: newPosition,
        draggable: true,
        onDragEnd: (position) {
          _updatePosition(position);
        },
      );
      _address = "ADRES GÜNCELLE";
    });
  }

  void _updatePosition(LatLng newPosition) {
    setState(() {
      _currentPosition = newPosition;
      _updateMarker(newPosition);
      mapController?.animateCamera(CameraUpdate.newLatLng(newPosition));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('ADRES GÜNCELLE'),
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Replace with your color
        ),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Container(
              height: 300, // Haritanın yüksekliği
              width: double.infinity, // Haritanın genişliği
              child: GoogleMap(
                onMapCreated: (controller) {
                  mapController = controller;
                  mapController?.animateCamera(CameraUpdate.newLatLngZoom(_currentPosition, 15.0));
                },
                initialCameraPosition: CameraPosition(
                  target: _currentPosition,
                  zoom: 15.0,
                ),
                markers: _marker != null ? {_marker!} : {},
                onTap: _onMapTapped,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child:Text('$_address'),
            ),
            Divider(height:5,color: Colors.black,),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 10.0, // Gölge büyüklüğünü artırarak kartın daha belirgin hale gelmesini sağlar
                    color: Theme.of(context).scaffoldBackgroundColor, // Kartın arkaplan rengi
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity, // TextField'ın genişliği
                        child: TextField(
                          controller: _controllerIl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(), // Çerçeve ekleme
                            labelText: 'İl',

                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 10.0, // Gölge büyüklüğünü artırarak kartın daha belirgin hale gelmesini sağlar
                    color: Theme.of(context).scaffoldBackgroundColor, // Kartın arkaplan rengi
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity, // TextField'ın genişliği
                        child: TextField(
                          controller: _controllerIlce,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(), // Çerçeve ekleme
                            labelText: 'İlçe',

                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              
            ),
           
            Card(
              elevation: 10.0, // Gölge büyüklüğünü artırarak kartın daha belirgin hale gelmesini sağlar
              color: Theme.of(context).scaffoldBackgroundColor, // Kartın arkaplan rengi
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity, // TextField'ın genişliği
                  child: TextField(
                    controller: _controllerMCS,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(), // Çerçeve ekleme
                      labelText: 'Mahalle / Cadde / Sokak',

                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 10.0, // Gölge büyüklüğünü artırarak kartın daha belirgin hale gelmesini sağlar
                    color: Theme.of(context).scaffoldBackgroundColor, // Kartın arkaplan rengi
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity, // TextField'ın genişliği
                        child: TextField(
                          controller: _controllerBinaNo,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(), // Çerçeve ekleme
                            labelText: 'Bina No',

                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 10.0, // Gölge büyüklüğünü artırarak kartın daha belirgin hale gelmesini sağlar
                    color: Theme.of(context).scaffoldBackgroundColor,// Kartın arkaplan rengi
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity, // TextField'ın genişliği

                        child: TextField(
                          controller: _controllerKat,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(), // Çerçeve ekleme
                            labelText: 'Kat',

                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 10.0, // Gölge büyüklüğünü artırarak kartın daha belirgin hale gelmesini sağlar
                    color: Theme.of(context).scaffoldBackgroundColor, // Kartın arkaplan rengi
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity, // TextField'ın genişliği
                        child: TextField(
                          controller: _controllerDaire,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(), // Çerçeve ekleme
                            labelText: 'Daire',

                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                ),
              ],

            ),
            Card(
              elevation: 10.0, // Gölge büyüklüğünü artırarak kartın daha belirgin hale gelmesini sağlar
              color: Theme.of(context).scaffoldBackgroundColor, // Kartın arkaplan rengi
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity, // TextField'ın genişliği
                  child: TextField(
                    controller: _controllerAcikAdres,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(), // Çerçeve ekleme
                      labelText: 'Adresi tarifi (Örn: Taxi durağı karşısı)',
                      labelStyle: TextStyle(fontSize: 14)
                    ),
                  ),
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [


            InkWell(
              onTap: (){

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
                            "Güncelle",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          Icon(CupertinoIcons.arrow_2_circlepath,color: Colors.white,),
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
  void _onMapTapped(LatLng location) {
    setState(() {
      _marker = Marker(
        markerId: MarkerId("selectedLocation"),
        position: location, // Tıklanan konuma marker'ı taşı
        draggable: true,
        onDragEnd: (newPosition) {
          _updatePosition(newPosition);
        },
      );
    });
    _updatePosition(location); // Kamera konumunu ve adres bilgisini güncelle
  }
}

/*class MapLocationsSettingPage extends StatefulWidget {
  @override
  State<MapLocationsSettingPage> createState() => MapLocationsSettingPageState();
}

class MapLocationsSettingPageState extends State<MapLocationsSettingPage> {
  Completer<GoogleMapController> _controller = Completer();
  String _address = "";
  late Marker _marker;
  CameraPosition _initialPosition = CameraPosition(target: LatLng(0, 0), zoom: 15);

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

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

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _initialPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17,
      );
      _marker = Marker(
        markerId: MarkerId("currentLocation"),
        position: LatLng(position.latitude, position.longitude),
        draggable: true,
        onDragEnd: (newPosition) {
          _updatePosition(newPosition);
        },
      );
      _updatePosition(LatLng(position.latitude, position.longitude));
    });
  }

  void _updatePosition(LatLng newPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(newPosition));

    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        newPosition.latitude, newPosition.longitude);

    setState(() {
      _address = "${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}";
      _marker = _marker.copyWith(
        positionParam: newPosition,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

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
                  // Burada ClipRRect kullanarak sağ alt köşeyi kıvırıyoruz
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30), // Sağ alt köşeyi kıvır
                      bottomLeft: Radius.circular(30), // Sağ alt köşeyi kıvır
                    ),
                    child: snapshot.data ?? Center(child: Text('Harita yüklenemedi!')),
                  );
                }
              },
            ),

            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Adres: $_address"),
            ),
          ],
        ),
      ),
    );
  }

  Future<Widget> _Map() async {
    var ekranWidtg = MediaQuery.of(context).size.width;
    var ekranHeight = MediaQuery.of(context).size.height;

    return SizedBox( width: ekranWidtg*1,height: ekranHeight*0.38,
      // ignore: unnecessary_null_comparison
      child: _initialPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        markers: Set.of([_marker]),
        onTap: _onMapTapped, // Haritaya tıklama işlemini ele alacak fonksiyon
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  void _onMapTapped(LatLng location) {
    setState(() {
      _marker = Marker(
        markerId: MarkerId("selectedLocation"),
        position: location, // Tıklanan konuma marker'ı taşı
        draggable: true,
        onDragEnd: (newPosition) {
          _updatePosition(newPosition);
        },
      );
    });
    _updatePosition(location); // Kamera konumunu ve adres bilgisini güncelle
  }

}*/
