import 'package:Kishtum/constants.dart';
import 'package:flutter/material.dart';

class AddCrossing extends StatefulWidget {
  @override
  _AddCrossingState createState() => _AddCrossingState();
}

class _AddCrossingState extends State<AddCrossing> {
  List<String> _gatesList = [
    'TorKham',
    'Nawab Pass',
    'Khojak Pass',
    'Angoor Ada',
    'Karak chungi'
  ];
  String selectedGate;
  double numberOfWheels=6;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: Text('Add crossing'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              gateDropdown(),
              Divider(),
              // crossingDirection(),
              // Divider(),
              registrationNumber(),
              wheelSlider(),
              cargo(),
            ],
          ),
        ),
      ),
    );
  }

  gateDropdown() {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 50,
          // fallbackWidth: 50,
          // color: Theme.of(context).primaryColorLight,
          child: DropdownButton(
            dropdownColor: Theme.of(context).primaryColorLight,
            items: _gatesList
                .map((e) => DropdownMenuItem(
                      child: Text(
                        e,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                      ),
                      value: e,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                this.selectedGate = value;
              });
            },
            hint: Text('Select a gate'),
            elevation: 5,
            value: this.selectedGate,
          ),
        ));
  }

  // crossingDirection() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Container(
  //       height: 100,
  //       width: double.infinity,
  //       color: Colors.blue[400],
  //     ),
  //   );
  // }

  registrationNumber() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 90,
        width: double.infinity,
        // color: Colors.blue[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'vehicle Registration',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                regAlphaTextField(),
                regnumericTextField(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  regAlphaTextField() {
    return Container(
        height: 50,
        width: 100,
        child: TextField(
          decoration: TEXTINPUTDECORATION.copyWith(
            fillColor: Colors.blueGrey.shade100,
            labelText: 'Letters',
          ),
        ));
  }

  regnumericTextField() {
    return Container(
      width: 100,
      height: 50,
      child: TextField(
        decoration: TEXTINPUTDECORATION.copyWith(
          fillColor: Colors.blueGrey.shade100,
          labelText: 'Digits',
        ),
      ),
    );
  }

  wheelSlider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 100,
        width: double.infinity,
        // color: Colors.blue,
        child: Column(
          children: [
            Text('Number of wheels: ${this.numberOfWheels.ceil().toString()}',style: Theme.of(context).textTheme.headline6,),
            Slider(
              value: this.numberOfWheels,
              onChanged: (val) {
                setState(() {
                  this.numberOfWheels = val;
                });
              },
            min: 6,
            max: 28,
            divisions: 8,
            label: '${numberOfWheels.ceil().toString()}',

            ),
          ],
        ),
      ),
    );
  }

  cargo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: double.infinity,
        color: Colors.green,
      ),
    );
  }
}
