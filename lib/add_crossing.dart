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
    'ACS-Afridi custom Services',
    'Shinwari Custom Clearance',
    'Naya sawera agency',
    'Orya Maqbool Jan Agency',
    'Wazir Port services company'
  ];
  String _selectedAgent;
  DocumentReference currentDocRef = null;
  TextEditingController _letterController = TextEditingController();
  TextEditingController _digitController = TextEditingController();
  TextEditingController _driverNameController = TextEditingController();
  TextEditingController _driverContactController = TextEditingController();
  Map<String, dynamic> crossingDataMap = Map<String, dynamic>();
  double _wheels = 0, _baseWeight = 0, _grossWeight = 0, _cargoWeight = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: Text('Add crossing'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                locationDetails(),
                vehicleIdentification(),
                Card(
                  elevation: 5,
                  child: Container(
                    height: 280,
                    width: double.infinity,
                    child: Wrap(
                      children: [
                        buildWheelerSpinbox(),
                        buildBaseWeightSpinner(),
                        buildGrossWeightSpinner(),
                        (this._grossWeight - this._baseWeight <= 0)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'GROSS Weight cannot be less than base weight',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(color: Colors.red),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Cargo Weight (Kg) :   ${(this._grossWeight - this._baseWeight).ceil()}'),
                              )
                      ],
                    ),
                  ),
                ),

                // baseWeight(context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
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
      ),
    );
  }

  Padding locationDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              gateDropdown(),
              importExportDropdown(),
            ],
          ),
        ),
      ),
    );
  }

  Padding vehicleIdentification() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            registrationNumber(),
            agent(),
            driverNameBuilder(),
          ],
        ),
      ),
    );
  }

  Padding baseWeight(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 64,
        vertical: 4,
      ),
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
              'Base weight (Kg)',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            Container(
              // color: Theme.of(context).primaryColorDark,
              padding: EdgeInsets.all(8),
              child: SpinBox(
                min: 5000,
                max: 99000,
                value: 1000,
                onChanged: (value) {
                  _baseWeight = value;
                },
              ),
            ),
            SizedBox(height: 4),
          ],
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
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Container(
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
          keyboardType: TextInputType.phone,
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
          // keyboardType: TextInputType.,
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
        keyboardType: TextInputType.number,
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
      padding: const EdgeInsets.all(16.0),
      child: Container(
        // height: 100,
        width: double.infinity,
        // color: Colors.blue,
        child: Column(
          children: [
            Text(
              'Number of wheels: ${this._wheels.toString()}',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            SpinBox(
              min: 4,
              max: 22,
              onChanged: (val) {
                setState(() {
                  this._wheels = val;
                });
              },
              direction: Axis.vertical,
              value: this._wheels,
            ),
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

  importExportDropdown() {
    return DropdownButton(
      dropdownColor: Theme.of(context).primaryColorLight,
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
      dropdownColor: Theme.of(context).primaryColorLight,
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
      dropdownColor: Theme.of(context).primaryColorLight,
      isDense: true,
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

  saveCrossing() async {
    this.currentDocRef =
        FirebaseFirestore.instance.collection('Crossing').doc();
    // getFormData();
    //  print(_letterController.text);
    String fullregNumber = this._letterController.value.text.toUpperCase() +
        this._digitController.value.text +
        '-' +
        this._selectedLocation;
    print('registration number = $fullregNumber');
    await this.currentDocRef.set({
      'registration': fullregNumber,
      'driverName': this._driverNameController.text,
      'driverContact': this._driverContactController.text,
      'clearingAgent': this._selectedAgent,
      'wheeler': this._wheels,
      'baseWeight': this._baseWeight,
      'grossWeight': this._grossWeight,
      'cargoWeight': this._grossWeight - this._baseWeight,
      'crossingGate': this.selectedGate,
      'crossingType': this._selectedCrossingType,
      'crossingDate': DateTime.now(),
      'logCreatedBy': 'AqleemKhattak@Gmail.com',
    }).then((value) {
      print('record added');
      Navigator.of(context).pop();
    });
  }

  buildWheelerSpinbox() {
    return Container(
      width: 110,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Total Number of wheels',
                  textAlign: TextAlign.center,
                ),
                // child: Text('Vehicle Details'),
              ),
              SpinBox(
                direction: Axis.vertical,
                min: 0,
                max: 22,
                value: this._wheels,
                onChanged: (val) {
                  setState(() {
                    this._wheels = val;
                  });
                },
              ),
            ],
          )),
    );
  }

  buildBaseWeightSpinner() {
    return Container(
      width: 110,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Base weight (Kg)',
                  textAlign: TextAlign.center,
                ),
                // child: Text('Vehicle Details'),
              ),
              SpinBox(
                direction: Axis.vertical,
                min: 0,
                max: 130000,
                value: this._baseWeight,
                onChanged: (val) {
                  setState(() {
                    this._baseWeight = val;
                  });
                },
              ),
            ],
          )),
    );
  }

  buildGrossWeightSpinner() {
    return Container(
      width: 110,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'GROSS weight (Kg)',
                  textAlign: TextAlign.center,
                ),
                // child: Text('Vehicle Details'),
              ),
              SpinBox(
                direction: Axis.vertical,
                min: 0,
                max: 130000,
                value: this._grossWeight,
                onChanged: (val) {
                  setState(() {
                    this._grossWeight = val;
                  });
                },
              ),
            ],
          )),
    );
  }
}
