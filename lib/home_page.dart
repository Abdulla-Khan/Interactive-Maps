import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong/latlong.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const _latitude = 24.8937;
    const _longitude = 67.2163;
    MapController mapController = MapController();

    List<Marker> marker = <Marker>[];
    Map<String, LatLng> coords = Map<String, LatLng>();

    coords.putIfAbsent(
        'Home', () => LatLng(24.887408305112604, 67.19658741354614));

    for (int i = 0; i < coords.length; i++) {
      marker.add(Marker(
          point: coords.values.elementAt(i),
          builder: (_) => Icon(Icons.pin_drop)));
    }

    void show(int index) {
      mapController.move(coords.values.elementAt(index), 1000);
    }

    List<Widget> makebutton() {
      List<Widget> list = [];
      for (int i = 0; i < coords.length; i++) {
        list.add(ElevatedButton(
            onPressed: () => show, child: Text(coords.keys.elementAt(i))));
      }
      return list;
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              Row(children: makebutton()),
              Flexible(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center: new LatLng(41.8781, -87.6298),
                    zoom: 10.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(markers: marker)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
