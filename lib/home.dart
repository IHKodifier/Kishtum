import 'dart:math';

import 'package:Kishtum/add_crossing.dart';
import 'package:Kishtum/login_page.dart';
import 'package:Kishtum/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> cargoItemList = List<String>();
  String docId;

  // String cargoItems = 'empty list';
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
                this.docId = snapshot.data.docs[index].id;
                Utilities().printLog(
                    'The first document fetched has id = ${this.docId}');

                // awaitCargoItems();
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                  child: Container(
                    child: ExpansionTile(
                        onExpansionChanged: (val){setState(() {
                          
                        });},
                        title:
                            registrationPlate(snapshot.data.docs[index].data()),
                        children: [
                          Column(
                            children: [
                              clearingAgentName(
                                  snapshot.data.docs[index].data()),
                              driverName(snapshot.data.docs[index].data()),
                              cargoList(snapshot.data.docs[index].data()),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.share,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {}),
                                ],
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                          ),
                        ]),
                  ),
                );
              },
            );
          }
        });
  }

  clearingAgentName(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        data['clearingAgent'],
        style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: 16),
      ),
    );
  }

  cargoList(Map<String, dynamic> data) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Crossing')
            .doc(this.docId)
            .collection('cargoItems')
            .get(),
        builder: (context, snapshot) { 
          // return Padding(
          //   padding: const EdgeInsets.all(4.0),
          //   child: Text(
          //     data['clearingAgent'],
          //     style: Theme.of(context).textTheme.bodyText2.copyWith(
          //         fontWeight: FontWeight.bold,
          //         color: Theme.of(context).primaryColor,
          //         fontSize: 16),
          //   ),
          // );
          // 11ghulam haider =0302 504 7978
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            
           
            return LimitedBox(
              maxHeight: 200,
                          child: GridView.count(
                crossAxisCount: 5,
                children:cargoGridChildren(snapshot.data.docs)
              ),
            );
          }
        });
  }
  List<Widget> cargoGridChildren (List<QueryDocumentSnapshot> docs){

    return docs.map((e){return Padding(
                  padding: const EdgeInsets.all(4),
                  child: GestureDetector(
                   
                    child: Card(  
                        // color: Colors.blueGrey.shade50,
                        elevation: 5,
                        child: Container(
                            padding: EdgeInsets.all(4),
                            // color: Colors.black.withOpacity(0.5),
                            child: Center(child: Text(e.data()['itemName']))
                          ),
                      ),
                  ),
                );}).toList();
  }

  registrationPlate(Map<String, dynamic> data) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              data['registrationNumber'],
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 30),
            ),
            Text(
              data['registrationCity'],
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.black87, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  driverName(Map<String, dynamic> data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.account_circle,
              size: 25,
              color: Theme.of(context).primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                data['driverName'],
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Icon(
                Icons.phone_android,
                size: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 8),
              child: Text('${data['driverContact']} ',
                  style: Theme.of(context).textTheme.bodyText2.copyWith()),
            ),
          ],
        ),
      ],
    );
  }
}
