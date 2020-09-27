import 'package:Kishtum/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'KISHTUM ',
                style: Theme.of(context).textTheme.headline3.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w800),
              ),
              LoginForm(),
              SizedBox(height: 20),
              Text('Powered by:\n EnigmaTek.Inc',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
