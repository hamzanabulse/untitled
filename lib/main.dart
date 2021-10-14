import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/AllScreens/Patient.dart';
import 'package:untitled/AllScreens/PatientHome.dart';
import 'package:untitled/AllScreens/RegisterationScreen.dart';
import 'package:untitled/AllScreens/WelcomeScreen.dart';
import 'package:untitled/AllScreens/LoginScreen.dart';
import 'AllScreens/LoginScreen.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Patient.idScreen,
      routes:
      {
        RegistrationScreen.idScreen : (context) => RegistrationScreen(),
        LoginScreen.idScreen : (context) => LoginScreen(),
        WelcomeScreen.idScreen : (context) => WelcomeScreen(),
        Patient.idScreen : (context) => Patient(),
        PatientHome.idScreen : (context) => PatientHome(),

      },
    );
  }
}

