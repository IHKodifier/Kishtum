import 'package:flutter/material.dart';

class Cargo extends StatefulWidget {
  @override
  _CargoState createState() => _CargoState();
}

class _CargoState extends State<Cargo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Icon(Icons.add_circle_outline,size:35),
          // // ClipOval(
          // //   child: Container(
          // //     color: Colors.black,
              // Text('Add Cargo'),
              IconButton(
                icon: Icon(Icons.add_circle_outline, size: 55,),
                onPressed: _showMyDialog,
              ),
          //   ),
          // )
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cargo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    leading: Icon(Icons.restaurant),
                    title: Text('Tomato'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    leading: Icon(Icons.restaurant),
                    title: Text('Potato'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    leading: Icon(Icons.add_circle_outline),
                    title: Text('Diesel Engines'),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              // color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
