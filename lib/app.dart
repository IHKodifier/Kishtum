import 'package:Kishtum/login_Page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kishtum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        // appBarTheme: Theme.of(context).appBarTheme.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
        // textTheme: Theme.of(context).appBarTheme
        // iconTheme: Theme.of(context).appBarTheme.iconTheme.copyWith(color:Theme.of(context).primaryColor),
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonColor: Theme.of(context).primaryColor,
        sliderTheme: Theme.of(context).sliderTheme.copyWith(
          
      
        ),
        // textTheme: Theme.of(context).textTheme.copyWith(color:)
        
      ),
      home: LoginPage(),
    );
  }
}