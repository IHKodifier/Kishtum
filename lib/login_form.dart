import 'package:Kishtum/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  //  FirebaseAuth _instance = FirebaseAuth.instance;
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      child: Material(
        elevation: 5,
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(height: 50),
              TextField(
                decoration: InputDecoration(
                  hintText: 'enter email',
                  labelText: 'Email',
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  // border: Border.all(),
                  hintText: 'enter password',
                  labelText: 'Password',
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    attemptLogin(email, password);
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void attemptLogin(String email, String password) async {
    await Firebase.initializeApp();
    var attemptedUser = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (attemptedUser != null) {
      print('\nlogin success');
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    } else {
      print('\nlogin fail');
    }

    // print(attemptedUser.runtimeType.toString());
    // FirebaseAuth.instance.signOut();
    // print('signed out successfully');
  }
}
