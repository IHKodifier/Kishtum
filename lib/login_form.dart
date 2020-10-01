import 'package:Kishtum/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool isBusy = false;
  bool isHidden = true;
  //  FirebaseAuth _instance = FirebaseAuth.instance;
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      child: this.isBusy
          ? showLoadingSpinner()
          : Material(
              elevation: 5,
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    TextField(
                      // keyboardType: email,
                      decoration: InputDecoration(
                        hintText: 'enter email',
                        labelText: 'Email',
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    Stack(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            // border: Border.all(),

                            hintText: 'enter password',

                            labelText: 'Password',
                          ),
                          obscureText: this.isHidden,
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                        Positioned(
                          child: IconButton(
                              icon: Icon(FontAwesomeIcons.eye,
                              color:this.isHidden? Colors.grey:Theme.of(context).primaryColor ,),
                              onPressed: () {
                                setState(() {
                                  this.isHidden = !this.isHidden;
                                });
                              }),
                          right: 0,
                          top: 0,
                          bottom: 0,
                        )
                      ],
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

  Widget showLoadingSpinner() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void attemptLogin(String email, String password) async {
    setState(() {
      this.isBusy = true;
    });
    await Firebase.initializeApp();
    var attemptedUser = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (attemptedUser != null) {
      setState(() {
        this.isBusy = false;
      });
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
