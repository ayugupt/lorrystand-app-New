import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/booking_provider.dart';
import 'package:lorrystand/widgets/menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/providers/transport_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransportPage extends StatefulWidget {
  TransportPage({Key key}) : super(key: key);  
  @override
  _TransportPageState createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage> with TickerProviderStateMixin {
  final image = "";

  @override
  Widget build(BuildContext context) {

     var transport = Provider.of<TransportProvider>(context);
     var trucks = transport.fetch();

      return Scaffold(

      backgroundColor: Colors.grey.shade300,
        // appBar: AppBar(
        //   title: Text("Transport"),
        //   elevation: 0,
        // ),
        body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Container(color:  Theme.of(context).primaryColor,)//PNetworkImage(image, fit: BoxFit.cover,),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 130.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 96.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${transport.transport['name']}", style: Theme.of(context).textTheme.headline6,),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text("Product Designer"),
                                    subtitle: Text("Kathmandu"),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Expanded(child: Column(
                                  children: <Widget>[
                                    Text("285"),
                                    Text("Likes")
                                  ],
                                ),),
                                Expanded(child: Column(
                                  children: <Widget>[
                                    Text("3025"),
                                    Text("Comments")
                                  ],
                                ),),
                                Expanded(child: Column(
                                  children: <Widget>[
                                    Text("650"),
                                    Text("Favourites")
                                  ],
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider("https://via.placeholder.com/150"),// NetworkImage("https://via.placeholder.com/150"),
                            fit: BoxFit.cover
                          )
                        ),
                        margin: EdgeInsets.only(left: 16.0),
                        ),
                    ],
                  ),

                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(title: Text("Transport information"),),
                        Divider(),
                        ListTile(
                          title: Text("Email"),
                          subtitle: Text("${transport.transport['email']}"),
                          leading: Icon(Icons.email),
                        ),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text("${transport.transport['mobile']}"),
                          leading: Icon(Icons.phone),
                        ),
                        ListTile(
                          title: Text("Joined Date"),
                          subtitle: Text("${transport.transport['created_at']}"),
                          leading: Icon(Icons.calendar_view_day),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),           
          AppBar(
          title: Text("Transport"),
          elevation: 0,
        ),
          ],
        ),
      ),
        // ListView(
        //   children: <Widget>[
        //     Card(
        //       child: ListTile(
        //         leading: CircleAvatar(
        //           radius: 30.0,
        //           backgroundImage:
        //               NetworkImage("https://via.placeholder.com/150"),
        //           backgroundColor: Colors.transparent,
        //         ),
        //         title: Text("dsfdsfsdfsd")
        //       ),
        //     )           
        //   ],
        // )
      );
  }
}