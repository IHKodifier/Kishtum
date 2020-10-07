import 'package:Kishtum/cargo.dart';
import 'package:Kishtum/cargo_grid.dart';
import 'package:Kishtum/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCrossing extends StatefulWidget {
  @override
  _AddCrossingState createState() => _AddCrossingState();
}

class _AddCrossingState extends State<AddCrossing> {
  List<String> _gatesList = [];

  String _selectedTerminal;
  String _selectedCrossingType;
  String _selectedRegCity;
  String _selectedClearingAgent;
  String _newDropdownEntry;
  AlertDialog alertDialogAddTerminal;
  AlertDialog alertDialogAddCrossingType;
  AlertDialog alertDialogAddregCity;
  AlertDialog alertDialogAddClearingAgent;
  List<String> _list = [];
  DocumentReference currentDocRef = null;
  Map<String, dynamic> crossingDataMap = Map<String, dynamic>();
  double _wheels = 0, _baseWeight = 0, _grossWeight = 0, _cargoWeight = 0;

  TextEditingController _letterController = TextEditingController();
  TextEditingController _digitController = TextEditingController();
  TextEditingController _driverNameController = TextEditingController();
  TextEditingController _driverContactController = TextEditingController();
  TextEditingController _newDropdownEntryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    alertDialogAddTerminal = AlertDialog(
      title: Text(' Add Terminal'),
      content: TextField(
        controller: _newDropdownEntryController,
        onChanged: (value) {
          setState(() {
            _newDropdownEntry = value;
          });
        },
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        RaisedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('terminals')
                .doc()
                .set({'name': _newDropdownEntryController.text});
            Navigator.of(context).pop();
          },
          // color: Theme.of(context).primaryColor,
          elevation: 5,
          child: Text('Save'),
        ),
      ],
    );

    alertDialogAddCrossingType = AlertDialog(
      title: Text(' Add Crossing Type'),
      content: TextField(
        controller: _newDropdownEntryController,
        onChanged: (value) {
          setState(() {
            _newDropdownEntry = value;
          });
        },
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        RaisedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('crossingType')
                .doc()
                .set({'name': _newDropdownEntryController.text});
            Navigator.of(context).pop();
          },
          // color: Theme.of(context).primaryColor,
          elevation: 5,
          child: Text('Save'),
        ),
      ],
    );
    alertDialogAddregCity = AlertDialog(
      title: Text(' Add City of Registration'),
      content: TextField(
        controller: _newDropdownEntryController,
        onChanged: (value) {
          setState(() {
            _newDropdownEntry = value;
          });
        },
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        RaisedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('regCities')
                .doc()
                .set({'name': _newDropdownEntryController.text});
            Navigator.of(context).pop();
          },
          // color: Theme.of(context).primaryColor,
          elevation: 5,
          child: Text('Save'),
        ),
      ],
    );

    alertDialogAddClearingAgent = AlertDialog(
      title: Text(' Add Clearing Agent'),
      content: TextField(
        controller: _newDropdownEntryController,
        onChanged: (value) {
          setState(() {
            _newDropdownEntry = value;
          });
        },
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        RaisedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('clearingAgent')
                .doc()
                .set({'name': _newDropdownEntryController.text});
            Navigator.of(context).pop();
          },
          // color: Theme.of(context).primaryColor,
          elevation: 5,
          child: Text('Save'),
        ),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add crossing'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                terminalCard(),
                vehicleCard(),
                weightCard(),
                cargoCard(),
                myButtonsBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialogAddTerminal() async {
    _newDropdownEntryController.clear();
    showDialog(
        context: context,
        builder: (context) => alertDialogAddTerminal,
        barrierDismissible: false);
  }

  Future<void> _showMyDialogAddCrossingType() async {
    _newDropdownEntryController.clear();
    showDialog(
        context: context,
        builder: (context) => alertDialogAddCrossingType,
        barrierDismissible: false);
  }

  Future<void> _showMyDialogAddRegCity() async {
    _newDropdownEntryController.clear();
    showDialog(
        context: context,
        builder: (context) => alertDialogAddregCity,
        barrierDismissible: false);
  }

  Future<void> _showMyDialogAddClearingAgent() async {
    _newDropdownEntryController.clear();
    showDialog(
        context: context,
        builder: (context) => alertDialogAddClearingAgent,
        barrierDismissible: false);
  }

  terminalCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 100,
        width: double.infinity,
        // color: Colors.lightGreen,
        child: Card(
          elevation: 50,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  terminalDropDown(),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _showMyDialogAddTerminal,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // terminalDropDown(),

                  crossingTypeDropdown(),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _showMyDialogAddCrossingType,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  vehicleCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 230,
        // color: Colors.purple,
        width: double.infinity,
        child: Card(
          elevation: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  regAlphaTextField(),
                  // Spacer(flex: 2,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      height: 5,
                      width: 12,
                      color: Colors.black54,
                    ),
                  ),
                  regnumericTextField(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  regCityDropdown(),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _showMyDialogAddRegCity),
                ],
              ),
              driverName(),
              driverPhone(),
              Wrap(
                //  alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                children: [
                  clearingAgentDropdown(),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 30,
                    ),
                    onPressed: _showMyDialogAddClearingAgent,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  weightCard() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        // height: 230,
        // color: Colors.purple,
        width: double.infinity,
        child: Card(
          elevation: 30,
          child: Wrap(
            alignment: WrapAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            direction: Axis.horizontal,
            children: [
              SizedBox(
                height: 10,
              ),
              buildWheelerSpinbox(),
              buildBaseWeightSpinner(),
              buildGrossWeightSpinner(),
              // weightErrorBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  weightErrorBuilder() {
    (this._grossWeight - this._baseWeight <= 0)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'GROSS Weight cannot be less than Base weight',
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
          );
  }

  cargoCard() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        height: 150,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context)=>CargoGrid(),
            ));
          },
          child: Card(
              child: Column(
            children: [
              Text('Cargo'),
              Text('coming Soon'),
            ],
          )),
        ),
      ),
    );
  }

  driverPhone() {
    return Card(
      // elevation: 20,
      child: Container(
          // height: 50,
          // width: 100,
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.all(4),
          child: TextField(
            keyboardType: TextInputType.phone,
            decoration: TEXTINPUTDECORATION.copyWith(
              fillColor: Theme.of(context).primaryColorLight.withAlpha(120),
              labelText: 'Driver contact number',
              icon: Icon(Icons.phone_android),
            ),
            controller: _driverContactController,
          )),
    );
  }

  driverName() {
    return Container(
        // height: 50,
        // width: 100,
        margin: EdgeInsets.symmetric(horizontal: 8),
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

  buttonBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(height: 60, color: Colors.black),
    );
  }

  terminalDropDown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('terminals').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              _list.clear();
              for (var i = 0; i < snapshot.data.docs.length; i++) {
                _list.insert(i, snapshot.data.docs[i].data()['name']);
                // print(_list);
              }
              return DropdownButton(
                items: _list
                    .map((e) => DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    this._selectedTerminal = newValue;
                    print(_selectedTerminal);
                  });
                },
                value: this._selectedTerminal,
                hint: Text('Select Terminal'),
              );
            }
          }),
    );
  }

  crossingTypeDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('crossingType').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              _list.clear();
              for (var i = 0; i < snapshot.data.docs.length; i++) {
                _list.insert(i, snapshot.data.docs[i].data()['name']);
                // print(_list);
              }
              return DropdownButton(
                items: _list
                    .map((e) => DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    this._selectedCrossingType = newValue;
                    print(_selectedCrossingType);
                  });
                },
                value: this._selectedCrossingType,
                hint: Text('Crossing Type'),
              );
            }
          }),
    );
  }

  regCityDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('regCities').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              _list.clear();
              for (var i = 0; i < snapshot.data.docs.length; i++) {
                _list.insert(i, snapshot.data.docs[i].data()['name']);
                // print(_list);
              }
              return DropdownButton(
                items: _list
                    .map((e) => DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    this._selectedRegCity = newValue;
                    print(_selectedRegCity);
                  });
                },
                value: this._selectedRegCity,
                hint: Text('City of Registration'),
              );
            }
          }),
    );
  }

  clearingAgentDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('clearingAgent')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              _list.clear();
              for (var i = 0; i < snapshot.data.docs.length; i++) {
                _list.insert(i, snapshot.data.docs[i].data()['name']);
                // print(_list);
              }
              return Container(
                width: MediaQuery.of(context).size.width * .65,
                child: DropdownButton(
                  items: _list
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      this._selectedClearingAgent = newValue;
                      print(_selectedClearingAgent);
                    });
                  },
                  value: this._selectedClearingAgent,
                  hint: Text('Clearing Agent'),
                ),
              );
            }
          }),
    );
  }

  regAlphaTextField() {
    return Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.all(0),
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
      width: 60,
      height: 50,
      padding: EdgeInsets.all(0),
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

  buildWheelerSpinbox() {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Card(
          elevation: 20,
          child: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  ' Number of wheels',
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
      width: 100,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Card(
          elevation: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
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
      width: 100,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Card(
          elevation: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
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

  saveCrossing() async {
    this.currentDocRef =
        FirebaseFirestore.instance.collection('Crossing').doc();
    // getFormData();
    //  print(_letterController.text);
    String registrationNumber =
        this._letterController.value.text.toUpperCase() +
            '-' +
            this._digitController.value.text;
    // String rgistrationCity;
    print('registration number = $registrationNumber');
    await this.currentDocRef.set({
      'registrationNumber': registrationNumber,
      'registrationCity': this._selectedRegCity,
      'driverName': this._driverNameController.text,
      'driverContact': this._driverContactController.text,
      'clearingAgent': this._selectedClearingAgent,
      'wheeler': this._wheels,
      'baseWeight': this._baseWeight,
      'grossWeight': this._grossWeight,
      'cargoWeight': this._grossWeight - this._baseWeight,
      'crossingGate': this._selectedTerminal,
      'crossingType': this._selectedCrossingType,
      'crossingDate': DateTime.now(),
      'logCreatedBy': 'AqleemKhattak@Gmail.com',
    }).then((value) {
      print('record added');
      Navigator.of(context).pop();
    });
  }
}
