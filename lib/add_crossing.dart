import 'dart:collection';

import 'package:Kishtum/cargo.dart';
import 'package:Kishtum/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

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
  double numberOfWheels = 6;
  double emptyWeightTons = 0;
  double emptyWeightKilos = 0;
  double cargoWeightTons = 0;
  double cargoWeightKilos = 0;
  List<String> _crossingType = [
    'Import',
    'Export',
    'Transit',
    'NATO',
    'WHO',
    'Other'
  ];
  String _selectedCrossingType;
  List<String> _locations = [
    'Islamabad',
    'Peshawar',
    'Lasbela',
    'Karachi',
    'Quetta',
    'D I Khan'
  ];
  String _selectedLocation;
  List<String> _clearingAgents = [
    'Khushal Agency',
    'Immad port services',
    'afridi custom agency',
    'Naya sawera agency',
    'Orya Maqbool Jan Agency',
    'Wazir Port services company'
  ];
  String _selectedAgent;
  DocumentReference currentDocRef = null;
  TextEditingController _letterController=TextEditingController();
  TextEditingController _digitController=TextEditingController();
  TextEditingController _driverNameController=TextEditingController();
  TextEditingController _driverContactController=TextEditingController();
  Map<String, dynamic> crossingDataMap = Map<String, dynamic>();

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    // shape: Border.c
                    elevation: 5,
                    child: Column(
                      children: [
                        gateDropdown(),
                        importExportButtons(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      registrationNumber(),
                      driverNameBuilder(),
                      agent(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Text(
                        'vehicle Details',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      wheelSpinBox(),
                      Text(
                        'Empty weight in KG?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      Container(
                        // color: Theme.of(context).primaryColorDark,
                        padding: EdgeInsets.all(8),
                        child: SpinBox(
                          min: 1,
                          max: 99000,
                          value: 2000,
                          onChanged: (value) => print(value),
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Text(
                        'Cargo details',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        'Gross weight (in KG)',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SpinBox(
                          min: 1,
                          max: 20000,
                          value: 1000,
                          onChanged: (value) => print(value),
                        ),
                      ),
                      Text(
                        'Cargo items',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                            ),
                      ),
                      cargoContainer(),
                    ],
                  ),
                ),
              ),
              myButtonsBar(),
            ],
          ),
        ),
      ),
    );
  }

  driverNameBuilder() {
    return Card(
      color: Colors.white70,
      elevation: 5,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text('Vehicle Kirb Weight'),
          driverName(),
          driverPhone(),
        ],
      ),
    );
  }

  gateDropdown() {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          // height: 50,
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
            hint: Text(
              'Select a gate',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Theme.of(context).primaryColor, fontSize: 16),
            ),
            elevation: 5,
            value: this.selectedGate,
          ),
        ));
  }

  registrationNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 90,
        width: double.infinity,
        // color: Colors.blue[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'vehicle Registration',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                regAlphaTextField(),
                regnumericTextField(),
                city(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  driverName() {
    return Container(
        // height: 50,
        // width: 100,
        padding: EdgeInsets.all(4),
        child: TextField(
          decoration: TEXTINPUTDECORATION.copyWith(
            fillColor: Theme.of(context).primaryColorLight.withAlpha(120),
            labelText: 'Driver Name',
            icon: Icon(Icons.account_circle),
          ),
          controller: _driverNameController,
        ));
  }

  driverPhone() {
    return Container(
        // height: 50,
        // width: 100,
        padding: EdgeInsets.all(4),
        child: TextField(
          decoration: TEXTINPUTDECORATION.copyWith(
            fillColor: Theme.of(context).primaryColorLight.withAlpha(120),
            labelText: 'Driver contact number',
            icon: Icon(Icons.phone_android),
          ),
          controller: _driverContactController,
        ));
  }

  regAlphaTextField() {
    return Container(
        // height: 40,
        width: 90,
        padding: EdgeInsets.all(4),
        child: TextField(
          decoration: TEXTINPUTDECORATION.copyWith(
            fillColor: Theme.of(context).primaryColorLight.withAlpha(120),
            labelText: 'Letters',
          ),
          controller: _letterController,
        ));
  }

  regnumericTextField() {
    return Container(
      width: 100,
      // height: 50,
      padding: EdgeInsets.all(4),
      child: TextField(
        decoration: TEXTINPUTDECORATION.copyWith(
          fillColor: Theme.of(context).primaryColorLight.withAlpha(120),
          labelText: 'Digits',
        ),
        controller: _digitController,
      ),
    );
  }

  wheelSpinBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 100,
        width: double.infinity,
        // color: Colors.blue,
        child: Column(
          children: [
            Text(
              'Number of wheels: ${this.numberOfWheels.ceil().toString()}',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            SpinBox(),
          ],
        ),
      ),
    );
  }

  cargoContainer() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          width: double.infinity,
          // color: Colors.green,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
          child: Cargo(),
        ));
  }

  myButtonsBar() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      buttonMinWidth: 150,
      children: [
        OutlineButton(
          onPressed: null,
          color: Theme.of(context).primaryColor,
          child: Text('Cancel'),
        ),
        RaisedButton(
          onPressed: saveCrossing,
          color: Theme.of(context).primaryColor,
          child: Text('Save'),
        )
      ],
    );
  }

  importExportButtons() {
    return DropdownButton(
      hint: Text(
        'Crossing Type',
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Theme.of(context).primaryColor, fontSize: 16),
      ),
      items: _crossingType
          .map(
            (e) => DropdownMenuItem(
              child: Text(
                e,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 16),
              ),
              value: e,
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCrossingType = value;
        });
      },
      value: this._selectedCrossingType,
      elevation: 5,
    );
  }

  city() {
    return DropdownButton(
      hint: Text(
        'Location',
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Theme.of(context).primaryColor, fontSize: 16),
      ),
      items: _locations
          .map(
            (e) => DropdownMenuItem(
              child: Text(
                e,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 16),
              ),
              value: e,
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedLocation = value;
        });
      },
      value: this._selectedLocation,
      elevation: 5,
    );
  }

  agent() {
    return DropdownButton(
      hint: Text(
        'Clearing Agent',
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Theme.of(context).primaryColor, fontSize: 16),
      ),
      items: _clearingAgents
          .map(
            (e) => DropdownMenuItem(
              child: Text(
                e,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 16),
              ),
              value: e,
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedAgent = value;
        });
      },
      value: this._selectedAgent,
      elevation: 5,
    );
  }

  // getFormData() {
  //   this.crossingDataMap = {
  //     'crossingGate': this.selectedGate,
  //     'crossingType': this._selectedCrossingType,
  //     'registration': this._letterController.text +
  //         '-' +
  //         this._digitController.text +
  //         '-' +
  //         this._selectedLocation,
  //     'driverName': this._driverNameController.text,
  //     'driverContact': this._driverContactController.text,
  //     'clearingAgent': this._selectedAgent,
  //     'crossingDate': DateTime.now(),
  //     'logCreatedBy': 'AqleemKhattak@Gmail.com',
  //   };
  //   print(this.crossingDataMap.toString());
  // }

  saveCrossing() async {
    this.currentDocRef =
        FirebaseFirestore.instance.collection('Crossing').doc();
    // getFormData();
  //  print(_letterController.text);
    String fullregNumber = this._letterController.value.text.toUpperCase() +this._digitController.value.text +'-'+this._selectedLocation;
    print('registration number = $fullregNumber');
    await this.currentDocRef.set({
      'registration': fullregNumber,
      'driverName': this._driverNameController.text,
      'driverContact': this._driverContactController.text,
      'clearingAgent': this._selectedAgent,
      'crossingGate': this.selectedGate,
      'crossingType': this._selectedCrossingType,
      'crossingDate': DateTime.now(),
      'logCreatedBy': 'AqleemKhattak@Gmail.com',
    }).then((value) {
      print('record added');
      Navigator.of(context).pop();
    }
    );
  }
}
