// mainPage.dart

import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mapapp/favorites.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'setting.dart';
import 'style.dart';

import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'MapEasy',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Lotte",
              fontSize: 25,
              color: AppColor.blue1,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Setting(),
                  ),
                );
              },
              icon: const Icon(Icons.account_circle, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMap(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.blue1,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                // Customize the appearance of the dialog
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Favorites(),
              );
            },
          );
        },
        child: Icon(
          Icons.star,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.search, color: Colors.grey),
                ),
                Container(
                  width: 200,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '장소를 입력하세요',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // TODO: 검색 버튼을 눌렀을 때의 동작 추가
            },
            style: ElevatedButton.styleFrom(
              primary: AppColor.blue1,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Text(
              '검색',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  GoogleMapController? mapController;
  String location = "Search Location";
  String? store;
  Set<Marker> markers = {};

  Widget _buildMap() {
    const CameraPosition _set =
        CameraPosition(target: LatLng(37.4988064, 127.0274241), zoom: 15.0);

    final googleMapWidget = GoogleMap(
      //Map widget from google_maps_flutter package
      zoomGesturesEnabled: true, //enable Zoom in, out on map
      initialCameraPosition: _set,
      mapType: MapType.normal, //map type
      markers: markers,
      onMapCreated: (controller) {
        //method called when map is created
        setState(() {
          mapController = controller;
        });
      },
    );

    final locationPicker = Positioned(
        //search input bar
        top: 10,
        child: InkWell(
            onTap: () async {
              if (mapController == null) {
                return;
              }
              var place = await PlacesAutocomplete.show(
                  context: context,
                  apiKey: 'AIzaSyCqYAEKcONd4UWLvPF6WtmSzJQbrVxtoAY',
                  mode: Mode.overlay,
                  types: [],
                  strictbounds: false,
                  //components: [Component(Component.country, 'np')],
                  //google_map_webservice package
                  onError: (err) {
                    print(err);
                  });

              if (place != null) {
                List<String> address = place.description.toString().split(',');
                store = address.last.trim();

                setState(() {
                  location = store!;
                });

                //form google_maps_webservice package
                final plist = GoogleMapsPlaces(
                  apiKey: 'AIzaSyCqYAEKcONd4UWLvPF6WtmSzJQbrVxtoAY',
                  apiHeaders: await const GoogleApiHeaders().getHeaders(),
                  //from google_api_headers package
                );
                String placeid = place.placeId ?? "0";
                final detail = await plist.getDetailsByPlaceId(placeid);
                final geometry = detail.result.geometry!;
                final lat = geometry.location.lat;
                final lang = geometry.location.lng;
                var newlatlang = LatLng(lat, lang);
                setState(() {
                  markers.clear();
                });

                // 새로운 마커 추가
                setState(() {
                  markers.add(
                    Marker(
                      markerId: MarkerId(store!),
                      position: newlatlang,
                      infoWindow: InfoWindow(
                        title: store,
                      ),
                    ),
                  );
                });
                log(placeid);

                //move map camera to selected place with animation
                mapController?.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: newlatlang, zoom: 17)));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                child: Container(
                    padding: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width - 40,
                    child: ListTile(
                      title: Text(
                        location,
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: const Icon(Icons.search),
                      dense: true,
                    )),
              ),
            )));

    return Scaffold(
      body: Stack(
        children: [googleMapWidget, locationPicker],
      ),
    );
  }
}
