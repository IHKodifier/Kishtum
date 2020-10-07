import 'package:Kishtum/home.dart';
import 'package:Kishtum/login_page.dart';
import 'package:Kishtum/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class StartUp extends StatefulWidget {
  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  void initState() {
    // TODO: implement initState
    letsInitFirebase();
    super.initState();
  }

  letsInitFirebase() async {
    Utilities().printLog('initializing Firebase');
    try {
      await Firebase.initializeApp();
    } catch (e) {
      Utilities().printLog(e.toString());
    }
    Utilities().printLog('Firebase Init successfull');
  }

  @override
  Widget build(BuildContext context) {
    //  Firebase.initializeApp();
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, snapshot) {
if (snapshot.connectionState==ConnectionState.waiting) {
            return  Center(child: CircularProgressIndicator()); 
  
} else if (snapshot.data.runtimeType == User){
              Utilities().printLog(snapshot.data.toString());
              return HomePage();

} else return LoginPage();

}
    );
        
  }
}
