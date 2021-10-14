import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'WelcomeScreen.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({Key? key}) : super(key: key);

  static const String idScreen = "patientHome";
  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> with AutomaticKeepAliveClientMixin
{
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  late double seedValue ;
  Location location = new Location();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  BehaviorSubject<double> radius = BehaviorSubject.seeded(100.0);
  late Stream<dynamic> query;
  late StreamSubscription subscription;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              Future<DocumentReference?> _addGeoPoint() async {
              var pos = await location.getLocation();
              GeoFirePoint point = geo.point(latitude: 37.42796133580664, longitude: -122.085749655962);
              return firestore.collection('location').add({
              'postion' : point.data,
              'name' : 'yay i can be queried'
               });
              }
            },
          ),
          Positioned(
              bottom: 50.0,
              left: 10.0,
              child: Slider(
                min: 100.0,
                max: 500.0,
                divisions: 4,
                value: radius.value,
                label: 'Radius ${radius.value} Km',
                onChanged: _updateQuery,
              ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}



