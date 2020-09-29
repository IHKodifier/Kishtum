import 'package:Kishtum/add_crossing.dart';
import 'package:Kishtum/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gate crossing log',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        // iconTheme: Theme.of(context).appBarTheme.actionsIconTheme.copyWith(color:Theme.of(context).primaryColor),
      ),
      drawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('aqleemkhattak@Gmail.com'),
              // Image.asset(name)
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Sign out',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  print('you were signed out');
                },
              )
            ],
          ),
        ),
      ),
      body: Center(
        child: crossingList(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddCrossing()));
          },
          child: Icon(
            Icons.add,
            size: 35,
          )),
    );
  }

  crossingList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Crossing').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.purple[50],
                  child: ListTile(
                    leading: leadingBuilder(snapshot.data.docs[index].data()),
                    title: titleBuilder(snapshot.data.docs[index].data()),
                    subtitle: subtitleBuilder(snapshot.data.docs[index].data()),
                    trailing: trailingBuilder(snapshot.data.docs[index].data()),
                    isThreeLine: true,
                  ),
                );
              },
            );
          }
        });
  }

  leadingBuilder(Map<String, dynamic> data) {
    return Container(
      width: MediaQuery.of(context).size.width / 6,
      child: Wrap(
        children: [
          Text(
            data['registration'],
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 12),
          ),
        ],
      ),
    );
  }

  titleBuilder(Map<String, dynamic> data) {
    return Text(
      data['clearingAgent'],
      style: Theme.of(context).textTheme.bodyText2.copyWith(
          fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16),
    );
  }

  subtitleBuilder(Map<String, dynamic> data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Text(data['driverName']),
        Row(
          
          children: [
           
            Icon(Icons.phone_android,size: 18,),
            Text('${data['driverContact']} '),
          ],
        ),
        Row(
          children: [
            Text(data['wheeler']),
            Text(' wheeler'),

          ],
        ),
      ],
    );
  }

  trailingBuilder(Map<String, dynamic> data) {}
  
}
