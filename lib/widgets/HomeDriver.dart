import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/booking_provider.dart';
import 'package:lorrystand/widgets/menu.dart';
import 'package:lorrystand/widgets/BookingsWidget.dart';

class HomeDriverPage extends StatefulWidget {
  HomeDriverPage({Key key}) : super(key: key);
  

  @override
  _HomeDriverPageState createState() => _HomeDriverPageState();
}

class _HomeDriverPageState extends State<HomeDriverPage> with TickerProviderStateMixin {

  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
     return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: MenuDrawer(),
      appBar: new AppBar(
        title: new Text("Lorrystand"),
        elevation: 0.7,       
        // actions: <Widget>[
        //   new Icon(Icons.search),
        //   new Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 5.0),
        //   ),
        //   new Icon(Icons.more_vert)
        // ],
      ),
      body: new BookingsWidget(),
    );
  } 
  
}
