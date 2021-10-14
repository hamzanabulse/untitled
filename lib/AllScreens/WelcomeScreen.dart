import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'LoginScreen.dart';
import 'RegisterationScreen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String idScreen = "welcome";
  late Position currentPosition ;
  var geoLocator = Geolocator();
  void locatePosition() async
  {
    LocationPermission permission = await Geolocator.requestPermission();
    LocationPermission checkPermission = await Geolocator.checkPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position ;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
  }
  @override
  void initState(){
  locatePosition();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 360.0,),
            Text(
              "Welcome To Our App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0,),
            ),
            SizedBox( height: 10.0,),
        RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: Container(
            height: 50.0,
            child: Center(
              child: Text(
                "Login",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(24.0),
          ),
          onPressed : (){
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
            locatePosition();
          }
        ),

            SizedBox( height: 10.0,),
            RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Container(
                  height: 50.0,
                  child: Center(
                    child: Text(
                      "Register Here ",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(24.0),
                ),
                onPressed : (){
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                  locatePosition();
                }
            ),
          ],
        ),
      ),

    );
  }
}




