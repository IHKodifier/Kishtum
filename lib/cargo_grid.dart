import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CargoGrid extends StatefulWidget {
  //  List<dynamic> list=[1,2,3,4,5,6,7,8];

  CargoGrid({Key key}) : super(key: key);
  @override
  _CargoGridState createState() => _CargoGridState();
}

class _CargoGridState extends State<CargoGrid> {
  List<dynamic> list1 = List<dynamic>();
  List<dynamic> list2 = List<dynamic>();
  // initializeLists();

  initializeLists() async {
    Firebase.initializeApp().then((value) => (value) {
          try {
            FirebaseFirestore.instance
                .collection('items')
                .orderBy('name')
                .get()
                .then((value) => list1.add(value.docs));
            // if list2list2.clear();
            // list2.add(Text('i dont count'));
            print(list1);
          } catch (e) {
            print(e.toString());
          }
        });
  }

  initializeFirebase() async {
    await Firebase.initializeApp();
    // Firebase.instance = await Firebase.initializeApp();
  }

  @override
  void initState() {
    // initializeFirebase();
    super.initState();
    initializeLists();
  }

  @override
  Widget build(BuildContext context) {
    // list1 = widget.li

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: GridView.count(
                crossAxisCount: 6,
                children: list1
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            list1.remove(e);
                            // list.add(e);
                          });
                        },
                        child: Container(
                          // color: Colors.green[index*100],
                          height: 50,
                          child: Card(
                            child: Text(
                              e.toString(),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Container(
              height: 10,
              color: Colors.black,
            ),
            Flexible(
              flex: 1,
              child: GridView.count(
                crossAxisCount: 6,
                children: list1.map((e) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        // Positioned(
                        //   bottom: 0,
                        //   left: 0,
                        //   right: 0,
                        //   child: Image.network(
                        //     e['photoUrl'],
                        //     fit: BoxFit.fill,
                        //   ),
                        // ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              color: Colors.yellow,
                              child: Text(
                                e['name'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(fontSize: 12.5),
                              )),
                        ),
                        // BoxFit
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        // ],
      ),
    );
    // );
  }
}
