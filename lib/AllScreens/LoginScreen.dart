import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/AllScreens/Patient.dart';
import 'package:untitled/AllScreens/RegisterationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/main.dart';


class LoginScreen extends StatelessWidget {
static const String idScreen = "login";

TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox( height: 45.0,),
              SizedBox( height: 1.0,),
              Text(
                "Login Please",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0,),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    SizedBox( height: 1.0,),
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

                    SizedBox( height: 1.0,),
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
                      onPressed : ()
                      {
                        if (!emailTextEditingController.text.contains("@"))
                        {
                          displayToastMessage("email not valid", context);
                        }
                        else if (passwordTextEditingController.text.isEmpty)
                        {
                          displayToastMessage("insert Password", context);
                        }
                        else
                        {
                          loginAndAuthinticateUser(context);
                          Navigator.pushNamedAndRemoveUntil(context, Patient.idScreen, (route) => false);
                        }
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed : ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                },
                child : Text(
                      "Not Register , Sign Up Here",
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

void loginAndAuthinticateUser(BuildContext context) async
{
  final User? firebaseUser = (await _firebaseAuth
      .signInWithEmailAndPassword(
      email: emailTextEditingController.text,
      password: passwordTextEditingController.text).catchError((errMsg){
    displayToastMessage("Error :" + errMsg.toString(),context);
  })).user;

  if (firebaseUser != null)
  {
    userRef.child(firebaseUser.uid).once().then((DataSnapshot snap)
      {
      if(snap.value != null )
      {
        displayToastMessage("logged in successfuly ", context);
      }
      else
        {
          _firebaseAuth.signOut();
          displayToastMessage("no user exist ", context);
        }
    });
  }
  else
  {
    displayToastMessage("Error in the database,cannot sign in " ,context);
  }

}
}
