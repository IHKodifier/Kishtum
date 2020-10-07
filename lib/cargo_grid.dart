import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CargoGrid extends StatefulWidget {
  @override
  _CargoGridState createState() => _CargoGridState();
}

class _CargoGridState extends State<CargoGrid> {
  QuerySnapshot querySnapshot;
  List<dynamic> cargoItemsMap = List<dynamic>();
  @override
  void initState() {
    // TODO: implement initState
    getAllCargoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: Center(
                      child: Text('Selected/Added Cargo Grid Will be here'))),
              buildAllCargoGrid(context),
              RaisedButton(
                onPressed: () {},
                child: Text('Create New Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAllCargoGrid(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Center(
        child: GridView.count(
          crossAxisCount: 3,
          children: cargoItemsMap.map((e) {
            return Padding(
              padding: const EdgeInsets.all(4),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    // print
                    cargoItemsMap.remove(e.data());
                  });
                },
                child: Stack(
                  children: [
                    ClipOval(
                      child: Image.network(e.data()['photoUrl']),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 80,
                      ),
                      child: Positioned(
                        child: Container(
                          padding: EdgeInsets.all(4),
                          color: Colors.black.withOpacity(0.5),
                          child: Text(
                            e.data()['name'],
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  getAllCargoList() async {
    await FirebaseFirestore.instance.collection('items').get().then((value) {
      setState(() {
        cargoItemsMap = value.docs;
      });
    });

    // print('\n\n\n printing IHK log query snapshot status\n\n\n' +
    //     querySnapshot.docs.length.toString() +
    //     '\n' +
    //     querySnapshot.docs[0].data().toString());

    print('\n\n\n printing IHK log local variable status\n\n\n' +
        cargoItemsMap.length.toString() +
        '\n' +
        cargoItemsMap[0].data().toString());

    // });

    // });
  }
}
