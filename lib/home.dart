import 'package:Kishtum/add_crossing.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gate crossing log', style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize:18,
      color:Colors.white),),
      centerTitle: true,),
      drawer: Drawer(),
      body: Center(
        child: Text('you reached home'),
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddCrossing()));
      },
      child: Icon(Icons.add,size: 35,)
      ),
    );
  }

}