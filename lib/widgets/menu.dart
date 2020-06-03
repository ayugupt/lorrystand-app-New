import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lorrystand/pages/transporter/CreateTransportPage.dart';
import 'package:lorrystand/pages/driver/CreateTruckPage.dart';

import 'BookingsWidget.dart';
import 'BookingsWidgetCustomer.dart';
import 'EnquiriesWidget.dart';
import 'EnquiriesWidgetCustomer.dart';

class MenuDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuDrawer();
  }
}

class _MenuDrawer extends State<MenuDrawer> {
  String profile = "";
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserProvider>(context);

    return Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 0.0),
          children: <Widget>[
            new UserAccountsDrawerHeader(                   
                    currentAccountPicture:  profile != "" ?
                      new Container(
                        width: 90.0,
                        height: 90.0,
                        margin: EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            image: DecorationImage(
                              image: NetworkImage("dfsfsdfs"),
                              fit: BoxFit.cover,
                            ),
                        ),
                      ) : Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: new CircleAvatar(
                          backgroundColor: Colors.white,
                          child: new Text('R')
                        ),                        
                    ),
                    decoration: BoxDecoration(
                            color: Colors.grey[900],
                        ),
                    accountName:Text("${userProvider.fullName}" , style: new TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600,)),
                    accountEmail: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${userProvider.email}" , style: new TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w600,)),
                        Text("${userProvider.mobile}", style: new TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w600,))
                      ]
                    ),
            ),
            ListTile(
              leading: new Icon(FontAwesomeIcons.home),
              title: new Text('Home'),
              onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/home");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ProfilePage()),
                  // );
                }
            ),
            ListTile(
              leading: new Icon(Icons.history),
              title: new Text('Trips'),
              onTap: ()  {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/Trips");
              }
            ),  
            userProvider.user['truck'] == null && userProvider.userRole == 'driver' ? 
            ListTile(
              leading: new Icon(FontAwesomeIcons.plus),
              title: new Text('Create Truck'),
              onTap: () {
                  Navigator.of(context).pop();
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateTruckPage()),
                  );
                }
            ) : SizedBox(),
            //VAG
            userProvider.userRole == 'customer' ?
            ListTile(
                leading: new Icon(FontAwesomeIcons.firstOrderAlt),
                title: new Text('Enquiries'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>EnquiriesWidgetCustomer(),
                    ),
                  );
                }
            ) : SizedBox(),
            userProvider.userRole == 'customer' ?
            ListTile(
                leading: new Icon(FontAwesomeIcons.book),
                title: new Text('Bookings'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>BookingsWidgetCustomer(),
                    ),
                  );
                }
            ) : SizedBox(),
            //VAG
            userProvider.userRole == 'transporter' ? 
            ListTile(
              leading: new Icon(FontAwesomeIcons.plus),
              title: new Text('Create Transport'),
              onTap: () {
                  Navigator.of(context).pop();
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateTransportPage()),
                  );
                }
            ) : SizedBox(),
            userProvider.userRole == 'transporter' ? 
            ListTile(
              leading: new Icon(FontAwesomeIcons.industry),
              title: new Text('Transport'),
              onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/Transport");
                }
            ) : SizedBox(),
            userProvider.userRole == 'transporter' ? 
            ListTile(
              leading: new Icon(FontAwesomeIcons.truckMoving),
              title: new Text('Trucks'),
              onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/Trucks");
                }
            ) : SizedBox(),
            userProvider.userRole == 'driver' ?
            ListTile(
              leading: new Icon(FontAwesomeIcons.truckPickup ),
              title: new Text('Truck'),
              onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/Driver/Truck" , arguments : userProvider.user['truck']['id']);
                }
            ) : SizedBox(),
            
            ListTile(
              leading: new Icon(Icons.person),
              title: new Text('Profile'),
              onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/Profile");
                },
            ),
            ListTile(
              leading: new Icon(Icons.power_settings_new),
              title: new Text('Logout'),
              onTap: ()  async {
                 Navigator.of(context).pop();
                 await userProvider.logout();
                 Navigator.of(context).pushNamed("/Login");
              }
            ),
          
            Divider(),
          ],
        ),
    );
  }
  _onListTileTap(BuildContext context) {
    Navigator.of(context).pop();
    showDialog<Null>(
      context: context,
      child: new AlertDialog(
        title: const Text('Not Implemented'),
        actions: <Widget>[
          new FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}