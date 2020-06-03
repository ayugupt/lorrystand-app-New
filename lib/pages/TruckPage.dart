import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/booking_provider.dart';
import 'package:lorrystand/widgets/menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TruckPage extends StatefulWidget {
  TruckPage({Key key}) : super(key: key);

  // This widget is the Truck page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  _TruckPageState createState() => _TruckPageState();
}

class _TruckPageState extends State<TruckPage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
            title: Text("Homes"),
        ),
        body: ListView(
          children: <Widget>[
            Card(child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage:
                    NetworkImage("https://via.placeholder.com/150"),
                backgroundColor: Colors.transparent,
              ),
               title: Text("dsfdsfsdfsd")
            ),)
           
          ],
        )
      );
  }


}