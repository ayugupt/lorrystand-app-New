import 'package:flutter/material.dart';
import 'package:lorrystand/widgets/BookingsWidget.dart';
import 'package:lorrystand/widgets/menu.dart';
import 'package:lorrystand/widgets/EnquiriesWidget.dart';


class HomeCustomerPage extends StatefulWidget {
  HomeCustomerPage({Key key}) : super(key: key);
  

  @override
  _HomeCustomerPageState createState() => _HomeCustomerPageState();
}

class _HomeCustomerPageState extends State<HomeCustomerPage> with TickerProviderStateMixin {

   TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this , initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {

     return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: MenuDrawer(),
      appBar: new AppBar(
        title: new Text("Lorrystand"),
        elevation: 0.7,
        bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            new Tab(text: "Enquires"),
            new Tab(text: "Bookings"),
          ],
        ),
        // actions: <Widget>[
        //   new Icon(Icons.search),
        //   new Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 5.0),
        //   ),
        //   new Icon(Icons.more_vert)
        // ],
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          EnquiriesWidget(),
          BookingsWidget(),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.greenAccent[700],
        child: new Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => 
            Navigator.of(context).pushReplacementNamed('/CreateBooking'),
      ),
    );
  }
  
}

Widget getBookingEnquires(BuildContext context){
  return Container(child: Text('cadscdscds'),);
}