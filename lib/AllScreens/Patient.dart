import 'package:flutter/material.dart';
import 'package:untitled/AllScreens/PatientHome.dart';

class Patient extends StatefulWidget {
const Patient({Key? key}) : super(key: key);

  static const String idScreen = "patient";

  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient"),
        centerTitle: true,
      ),
      key: scaffoldkey,
      drawer: Container(
        color: Colors.white,
        width: 250.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/user_icon.png", height: 65.0,width: 65.0,
                      ),
                      SizedBox(width: 16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("profile name",style: TextStyle(fontSize: 16.0,color: Colors.white),),
                          SizedBox(height: 6.0,),
                          Text("Visit Profile",style: TextStyle(fontSize: 16.0,color: Colors.white),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              SizedBox(height: 12.0,),

              ListTile(
                leading: Icon(Icons.home_outlined),
                title: Text("Home",style: TextStyle(fontSize: 15.0),),
                onTap: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, PatientHome.idScreen, (route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.person_outline),
                title: Text("Visit Profile",style: TextStyle(fontSize: 15.0),),
                onTap: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, Patient.idScreen, (route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.file_copy_outlined),
                title: Text("Report Us",style: TextStyle(fontSize: 15.0),),
                onTap: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, Patient.idScreen, (route) => false);
                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}
