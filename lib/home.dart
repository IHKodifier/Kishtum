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
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                  child: Container(
                    // height: 120,
                    child: Card(
                      // margin: EdgeInsets.symmetric(horizontal: 8),
                      // shape: ,
                      // margin: EdgeInsets.all(4),
                      elevation: 5,
                      color: Colors.purple[50],
                      child: Column(
                        children: [
                          leadingBuilder(snapshot.data.docs[index].data()),
                          Divider(
                            height: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                          titleBuilder(snapshot.data.docs[index].data()),
                          subtitleBuilder(snapshot.data.docs[index].data()),
                          Divider(color: Theme.of(context).primaryColor,),
                          weightTable(snapshot.data.docs[index].data()),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
  }

  leadingBuilder(Map<String, dynamic> data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 4),
          child: Text(
            data['registration'],
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 12),
          ),
        ),
        Text(
          '${data['wheeler'].toString()} Wheeler',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 12),
        ),
        Text(
          '${data['crossingGate']}',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 12),
        ),
      ],
    );
  }

  titleBuilder(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        data['clearingAgent'],
        style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14),
      ),
    );
  }

  subtitleBuilder(Map<String, dynamic> data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            data['driverName'],
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Icon(
                Icons.phone_android,
                size: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 8),
              child: Text('${data['driverContact']} '),
            ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     Wrap(
        //       alignment: WrapAlignment.start,
        //       direction: Axis.horizontal,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Text(
        //               data['wheeler'].ceil().toString(),
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .bodyText1
        //                   .copyWith(fontWeight: FontWeight.bold),
        //             ),
        //             Text(' wheeler'),
        //           ],
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Text('BW:'),
        //             Text(data['baseWeight'].ceil().toString()),
        //           ],
        //         ),
        //       ],
        //     ),
        //     Wrap(
        //       alignment: WrapAlignment.start,
        //       direction: Axis.horizontal,
        //       children: [
        //         // Row(
        //         //   mainAxisAlignment: MainAxisAlignment.start,
        //         //   children: [
        //         //     Text('GW:'),
        //         //     Text(data['grossWeight'].ceil().toString()),
        //         //   ],
        //         // ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Text('GW:'),
        //             Text(data['grossWeight'].ceil().toString()),
        //           ],
        //         ),
        //       ],
        //     ),

        //     // Text('B.W:'),
        //     // Text(data['baseWeight'].toString()),
        //   ],
        // ),
      ],
    );

    // );
  }

  weightTable(Map<String, dynamic> data) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.9,
      child: Column(
        children: [
          Row(
            children: [Text('Weights (Kg)')],
          ),
          Row(
            children: [
              Text('B:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text(data['baseWeight'].ceil().toString()),
            ],
          ),
          Row(
            children: [
              Text('G:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text(data['grossWeight'].ceil().toString()),
            ],
          ),
          Row(
            children: [
              Text('C:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text(data['cargoWeight'].ceil().toString()),
            ],
          ),
        ],
      ),
    );
  }
}
