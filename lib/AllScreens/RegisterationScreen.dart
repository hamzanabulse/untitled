import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:untitled/AllScreens/LoginScreen.dart';
import 'package:untitled/AllScreens/WelcomeScreen.dart';
import 'package:untitled/main.dart';
import 'package:gender_picker/gender_picker.dart';

import 'Patient.dart';



class RegistrationScreen extends StatefulWidget {

  static const String idScreen = "register";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

   String? dropDownValue ;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding (
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 45.0,),
              SizedBox(height: 1.0,),
              Text(
                "Register Please",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0,),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 16.0,),
                    GenderPickerWithImage(
                      selectedGender: Gender.Male,
                      selectedGenderTextStyle: TextStyle(
                          color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
                      unSelectedGenderTextStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                      onChanged: (Gender? gender) {
                        print(gender);
                      },
                      //Alignment between icons
                      equallyAligned: true,
                      animationDuration: Duration(milliseconds: 300),
                      isCircular: true,
                      // default : true,
                      opacityOfGradient: 0.4,
                      padding: const EdgeInsets.all(3),
                      size: 50, //default : 40
                    ),

                    SizedBox(height: 15.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton(
                          hint : Text("Select Your Situation"),
                          dropdownColor : Colors.blue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 36.0,
                          isExpanded : true ,
                          style : TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                          ),  onChanged: (String? newValue) {
                            setState(() {
                              dropDownValue = newValue!;
                            });
                            },
                            value: dropDownValue,
                            items: <String>['Doctor', 'Patinte']
                                .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            );
                            }).toList(),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.0,),
                    RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: ()
                      {
                        if (nameTextEditingController.text.length < 4)
                        {
                          displayToastMessage("Name is too short", context);
                        }
                        else if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage("email not valid", context);
                        }
                        else if (passwordTextEditingController.text.length < 8)
                        {
                          displayToastMessage("pass is too short", context);
                        }
                        else
                        {
                          registerNewUser(context);
                          Navigator.pushNamedAndRemoveUntil(context, Patient.idScreen, (route) => false);
                        }
                      },
                    ),
                  ],
                ),

              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Already have an account , LogIn Here",
                  style: TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async
  {
    final User? firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text).catchError((errMsg){
          displayToastMessage("Error :" + errMsg.toString(),context);
    })).user;

    if (firebaseUser != null)
      {
        Map userDataMap = {
          "name" : nameTextEditingController.text.trim(),
          "email" : emailTextEditingController.text.trim(),
          "password" : passwordTextEditingController.text.trim(),
        };
        userRef.child(firebaseUser.uid).set(userDataMap);
        displayToastMessage("Account Created", context);
        Navigator.pushNamedAndRemoveUntil(context,WelcomeScreen.idScreen, (route) => false);
      }
    else
      {
        displayToastMessage("New account has not been created" ,context);
      }
  }
}
displayToastMessage(String message, BuildContext context)
{
  Fluttertoast.showToast(msg: message);

}

