import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/booking_provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/providers/truck_provider.dart';
import 'package:lorrystand/providers/trip_provider.dart';
import 'package:lorrystand/providers/enquiry_provider.dart';
import 'package:lorrystand/providers/bid_provider.dart';
import 'package:lorrystand/providers/transport_provider.dart';
import 'package:lorrystand/routes.dart';
import 'package:lorrystand/pages/HomePage.dart';
import 'package:lorrystand/config/app_config.dart' as config;
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
     return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookingProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TruckProvider()),
        ChangeNotifierProvider(create: (context) => TripProvider()),
        ChangeNotifierProvider(create: (context) => EnquiryProvider()),
        ChangeNotifierProvider(create: (context) => BidProvider()),
        ChangeNotifierProvider(create: (context) => TransportProvider()),
      ],
      child: MaterialApp(
        title: 'Lorrystand',
        //theme: appTheme,
        theme: ThemeData(
              fontFamily: 'Poppins',
              primaryColor:  Colors.black,//new Color(0xff075E54),//Colors.white,
              brightness: Brightness.light,
              //primaryColor1: new Color(0xff075E54),
              //accentColor: new Color(0xff25D366),
              accentColor: config.Colors().mainColor(1),
              appBarTheme: AppBarTheme(
                color: Colors.greenAccent[600],
              ),
              focusColor: config.Colors().accentColor(1), 
              hintColor: config.Colors().secondColor(1),
              textTheme: TextTheme(
                headline5: TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1)),
                headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
                headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
                headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().mainColor(1)),
                headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondColor(1)),
                subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondColor(1)),
                headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().mainColor(1)),
                bodyText2: TextStyle(fontSize: 12.0, color: config.Colors().secondColor(1)),
                bodyText1: TextStyle(fontSize: 14.0, color: config.Colors().secondColor(1)),
                caption: TextStyle(fontSize: 12.0, color: config.Colors().accentColor(1)),
              ),
        ),
        //initialRoute: '/TransporterHome',
        onGenerateRoute: RouteGenerator.generateRoute,
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
  
}