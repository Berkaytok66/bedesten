

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final double enlem;
  final double boylam;
  MapPage({required this.enlem, required this.boylam});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {


  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    var enlem = widget.enlem;
    var boylam = widget.boylam;
    print(enlem);
    print(boylam);
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(enlem, boylam),
            zoom: (enlem != 0.0 && boylam != 0.0) ? 14.4746 : 0.0, // Harita başlangıçta gizlendiğinde zoom 0 olacak
          ),
        ),
        Positioned(
          bottom: 20, // Düğmelerin alt kenarına ne kadar yakın olacağını ayarlayın
          right: 60, // Düğmelerin sağ kenarına ne kadar yakın olacağını ayarlayın
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {

                },
                child: Text('Düğme 1'),
              ),
              SizedBox(width: 8), // Düğmeler arasında boşluk bırakmak için SizedBox ekleyebilirsiniz
              ElevatedButton(
                onPressed: () {
                  // Diğer bir işlemi burada tetikleyin

                },
                child: Text('Düğme 2'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
