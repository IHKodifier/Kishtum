import 'package:Kishtum/add_crossing.dart';
import 'package:Kishtum/cargo.dart';
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
  bool isExpanded = false;

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
      body: Container(
          // child: crossingList(),
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

// crossingList() {
//   return LimitedBox(
//     maxHeight: MediaQuery.of(context).size.height - 84,
//     child: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('Crossing')
//             .orderBy('crossingDate')
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data.docs.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
//                   child: Container(
//                     margin: EdgeInsets.zero,
//                     child: Card(
//                       elevation: 24,
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Container(
//                               height: 100,
//                               color: Colors.red,
// ),
// cardTitle(snapshot.data.docs[index].data()),

// // Container(
//   height: 400,
//   child: ExpansionTile(
//     title: Text('MORE...'),
//     children: [
//       // Text('i was just expanded'),
//        Container(
//          height: 400,
//          child: Container(height: 50,
//          color: Colors.green,),
//         //  Cargo(),
//          ),
//     ],
//   ),
// ),

// ButtonBar(
//   // buttonHeight: 0,
//   buttonPadding: EdgeInsets.zero,
//   alignment: MainAxisAlignment.center,
//   children: [
//     Container(
//       margin: EdgeInsets.all(8),
//       child: Center(
//         child: IconButton(
//             icon: Icon(
//               Icons.edit,
//               color: Theme.of(context).primaryColor,
//             ),
//             // iconSize: 35,
//             onPressed: () {
//               showDialog(
//                   context: context,
//                   barrierDismissible: true,
//                   builder: (context) => AlertDialog(
//                         title: Text(
//                             'is peature k liyey intizaar parmaye'),
//                         actions: [
//                           FlatButton(
//                             onPressed: () {
//                               Navigator.of(context)
//                                   .pop();
//                             },
//                             child: Text('ok Janab'),
//                           )
//                         ],
//                       ));
//             }),
//       ),
//     ),
//     Container(
//       margin: EdgeInsets.all(8),
//       child: Center(
//         child: IconButton(
//             icon: Icon(
//               Icons.delete,
//               color: Theme.of(context).primaryColor,
//             ),
//             // iconSize: 35,
//             onPressed: () {
//               showDialog(
//                   context: context,
//                   barrierDismissible: true,
//                   builder: (context) => AlertDialog(
//                         title: Text(
//                             'is peature k liyey intizaar parmaye'),
//                         actions: [
//                           FlatButton(
//                             onPressed: () {
//                               Navigator.of(context)
//                                   .pop();
//                             },
//                             child: Text('ok Janab'),
//                           )
//                         ],
//                       ));
//             }),
//       ),
//     ),
//     Container(
//       margin: EdgeInsets.all(8),
//       child: Center(
//         child: IconButton(
//           icon: Icon(
//             Icons.share,
//             color: Theme.of(context).primaryColor,
//           ),
//           // iconSize: 35,
//           onPressed: () {
//             showDialog(
//                 context: context,
//                 barrierDismissible: true,
//                 builder: (context) => AlertDialog(
//                       title: Text(
//                           'is peature k liyey intizaar parmaye'),
//                       actions: [
//                         FlatButton(
//                           onPressed: () {
//                             Navigator.of(context)
//                                 .pop();
//                           },
//                           child: Text('ok Janab'),
//                         )
//                       ],
//                     ));
//           },
//         ),
//       ),
//     ),
//   ],
// ),

// ,
// positioned
// positionedWheels(snapshot.data.docs[index].data()),
//                             ],
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           }),
//     );
//   }
// }
// cardTitle(Map<String, dynamic> data) {
//   return Container(
//     // width: MediaQuery.of(context).size.width * .9,

//     child: Column(
//       children: [
//         Row(
//           children: [
//             profileIcon(),
//             Container(
//               width: 250,
//               padding: EdgeInsets.only(left: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   driverName(data),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 2, right: 4),
//                     child: Row(
//                       children: [
//                         Container(
//                           // color: Colors.black,
//                           child: Icon(
//                             Icons.phone,
//                             size: 20,
//                             color: Theme.of(context).accentColor,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 2, left: 4),
//                           child: Text(
//                             '${data['driverContact']}',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .subtitle2
//                                 .copyWith(
//                                   color: Theme.of(context).accentColor,
//                                 ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(0.0),
//                     child: Text(
//                       '${data['clearingAgent']} ',
//                       style: Theme.of(context).textTheme.subtitle2.copyWith(
//                             color: Colors.black54,
//                           ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         licensebuilder(data),
//       ],
//     ),
//   );
//   // );
// }

// Text driverName(Map<String, dynamic> data) {
//   return Text(
//     data['driverName'],
//     style: Theme.of(context).textTheme.headline6.copyWith(
//         fontWeight: FontWeight.bold,
//         // color: Theme.of(context).primaryColor,
//         fontSize: 14),
//   );
// }

// Container profileIcon() {
//   return Container(
//     // width: double.infinity,
//     child: Icon(
//       FontAwesomeIcons.solidUserCircle,
//       size: 40,
//       color: Colors.grey[400],
//     ),
//   );
// }

// licensebuilder(Map<String, dynamic> data) {
//   return Container(
//     // width: double.infinity,
//     width: MediaQuery.of(context).size.width * .9,
//     // height: 100,
//     color: Colors.white38,
//     child: Stack(
//       children: [
//         Center(
//           child: Container(
//             margin: EdgeInsets.symmetric(
//               vertical: 8,
//             ),
//             decoration: BoxDecoration(
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 width: 1,
//                 // color:
//               ),
//               color: Colors.transparent,
//             ),

//             width: 200,
//             // height: 50,
//             child: Center(
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   data['registrationNumber'],
//                   style: Theme.of(context).textTheme.headline3.copyWith(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 38,
//                       ),
//                 ),
//                 Container(
//                   // color: Colors.green,
//                   child: Text(
//                     data['registrationCity'],
//                     style: Theme.of(context).textTheme.bodyText2.copyWith(
//                           // fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                   ),
//                 ),
//               ],
//             )),
//           ),
//         ),
//       ],
//     ),
//   );
//   // );
//   // }

// Positioned positionedCargoWeight(Map<String, dynamic> data) {
//   return Positioned(
//     bottom: 60,
//     right: 0,
//     child: Container(
//       padding: EdgeInsets.all(4),
//       height: 40,
//       width: MediaQuery.of(context).size.width / 4.4,
//       // color: Colors.black38,
//       decoration: BoxDecoration(
//         color: Colors.green[300].withOpacity(.8),
//         shape: BoxShape.rectangle,
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
//         border: Border.all(width: 1, color: Colors.black),
//       ),
//       child: Center(
//           child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             'C: ',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyText2
//                 .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
//           ),
//           Text(
//             '${data['cargoWeight'].ceil().toString()}',
//             style: Theme.of(context).textTheme.bodyText1.copyWith(
//                   fontSize: 13.5,
//                   //  fontWeight: FontWeight.bold),
//                 ),
//           ),
//         ],
//       )),
//     ),
//   );
// }

// Positioned positionedGrossWeight(Map<String, dynamic> data) {
//   return Positioned(
//     bottom: 60,
//     right: 0,
//     child: Container(
//       padding: EdgeInsets.all(4),
//       height: 40,
//       width: MediaQuery.of(context).size.width / 4.4,
//       // color: Colors.black38,
//       decoration: BoxDecoration(
//         color: Colors.orange[300].withOpacity(.8),
//         shape: BoxShape.rectangle,
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
//         border: Border.all(width: 1, color: Colors.black),
//       ),
//       child: Center(
//           child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text(
//             'G: ',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyText2
//                 .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//           Text(
//             '${data['grossWeight'].ceil().toString()}',
//             style: Theme.of(context).textTheme.bodyText1.copyWith(
//                   fontSize: 14,
//                   //  fontWeight: FontWeight.bold),
//                 ),
//           ),
//         ],
//       )),
//     ),
//   );
// }

// Positioned positionedBaseWeight(Map<String, dynamic> data) {
//   return Positioned(
//     bottom: 60,
//     right: 0,
//     child: Container(
//       padding: EdgeInsets.all(4),
//       height: 40,
//       width: MediaQuery.of(context).size.width / 4.4,
//       // color: Colors.black38,
//       decoration: BoxDecoration(
//         color: Colors.blue[300].withOpacity(.8),
//         shape: BoxShape.rectangle,
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
//         border: Border.all(width: 1, color: Colors.black),
//       ),
//       child: Center(
//           child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text(
//             'B: ',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyText2
//                 .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//           Text(
//             '${data['baseWeight'].ceil().toString()}',
//             style: Theme.of(context).textTheme.bodyText1.copyWith(
//                   fontSize: 14,
//                   //  fontWeight: FontWeight.bold),
//                 ),
//           ),
//         ],
//       )),
//     ),
//   );
// }

//   Positioned positionedWheels(Map<String, dynamic> data) {
//     return Positioned(
//       top: 0,
//       bottom: 0,
//       left: 0,
//       child: Container(
//         // padding: EdgeInsets.all(4),
//         margin: EdgeInsets.all(4),
//         // height: 100,
//         // width: MediaQuery.of(context).size.width / 4.4,
//         decoration: BoxDecoration(
//           color: Colors.purple[300].withOpacity(.8),
//           shape: BoxShape.circle,
//           border: Border.all(width: 1, color: Colors.black),
//         ),
//         child: Center(
//             child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '${data['wheeler'].ceil().toString() + ' W'}',
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText1
//                   .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             // Text(
//             //   '   W',
//             //   style: Theme.of(context)
//             //       .textTheme
//             //       .bodyText2
//             //       .copyWith(fontWeight: FontWeight.bold),
//             // ),
//           ],
//         )),
//       ),
//     );
//   }
// }
// }
}
