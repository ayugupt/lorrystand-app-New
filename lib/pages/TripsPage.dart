import 'package:flutter/material.dart';

import 'package:lorrystand/widgets/menu.dart';
import 'package:lorrystand/widgets/TripsWidget.dart';

class TripsPage extends StatefulWidget {

  TripsPage({Key key}) : super(key: key);

  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: MenuDrawer(),
      appBar: new AppBar(
        title: new Text("Trips"),
        elevation: 0.7,  
      ),
      body: new TripsWidget(),
    );
  }


}