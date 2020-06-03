import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/booking_provider.dart';
import 'package:lorrystand/widgets/menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lorrystand/widgets/EnquiriesWidget.dart';
import 'package:lorrystand/widgets/BidsWidget.dart';
import 'package:lorrystand/widgets/BookingsWidget.dart';

class HomeTransporterPage extends StatefulWidget {
  HomeTransporterPage({Key key}) : super(key: key);
  

  @override
  _HomeTransporterPageState createState() => _HomeTransporterPageState();
}

class _HomeTransporterPageState extends State<HomeTransporterPage> with TickerProviderStateMixin {
  var tab;

  @override
  void initState() {
    super.initState();
    setState(() {
      tab="new";
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
     return Scaffold(
       backgroundColor: Colors.grey[200],
       drawer: MenuDrawer(),
       appBar: new AppBar(
         title: Padding(
           padding: const EdgeInsets.fromLTRB(52.0,30,20,20),
           child: RaisedButton(
             textColor:Colors.black,
             color:Colors.amber,
             child: Text("TRANSPORT",style: (TextStyle(color: Color(0xFF212838),fontSize: 17)),),
             onPressed: () {
             },
             shape: new RoundedRectangleBorder(
               borderRadius: new BorderRadius.circular(10.0),
             ),
           ),
         ),
         backgroundColor:Color(0xFF212838),
       elevation: 0.7,
       ),
       body: Stack(
         alignment: AlignmentDirectional.topCenter,
         children: <Widget>[
           Container(
             child: ClipPath(
               clipper: OvalBottomBorderClipper(),
               child: Container(
                 height: size.height/3,
                 color: Color(0xFF212838),
               ),
             ),
           ),
           Padding(
             padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                 FaIcon(FontAwesomeIcons.book,color: Colors.amber,size: 49),
                 SizedBox(width: 30,),
                 Container(
                   height: 50,
                   child:Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Container(
                         child: Text('DASHBOARD',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                       ),
                       Container(
                         child: Text('Getting the enquiry from the customers',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                       )

                     ],
                   ),
                 )
               ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(top: 100),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[
                 RaisedButton(
                   textColor:  tab=="new"?Colors.white:Colors.black,
                   color: tab=="new"?
                   Colors.redAccent:Colors.amber,
                   child: Text("New Enquiries"),
                   onPressed: () {
                     setState(() {
                       tab="new";
                     });
                   },
                   shape: new RoundedRectangleBorder(
                     borderRadius: new BorderRadius.circular(10.0),
                   ),
                 ),
                 RaisedButton(
                   textColor:tab=="bids"?Colors.white:Colors.black,
                   color: tab=="bids"?
                   Colors.redAccent:Colors.amber,
                   child: Text("Ongoing Bids"),
                   onPressed: () {
                     setState(() {
                       tab="bids";
                     });
                   },
                   shape: new RoundedRectangleBorder(
                     borderRadius: new BorderRadius.circular(10.0),
                   ),
                 )

               ],
             ),
           ),
           tab=="bids"?
           Padding(
             padding: const EdgeInsets.only(top:170.0),
             child: BidsWidget(),
           ):Padding(
             padding: const EdgeInsets.only(top:170.0),
             child: EnquiriesWidget(),
           ),
         ],
       ),
     );

       /*Scaffold(
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
            new Tab(text: "Bids"),
            new Tab(text: "Bookings"),
          ],
        ),
        actions: <Widget>[
          // new Icon(Icons.search),
          // new Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
          // ),
           IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.filter,
                  size: 16.0,
                ),
                onPressed: () => {},
              ),
        ],
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          EnquiriesWidget(),
          BidsWidget(),
          BookingsWidget()          
        ],
      ),
    );
  }

}*/
  }
}