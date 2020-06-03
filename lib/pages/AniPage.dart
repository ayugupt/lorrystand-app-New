import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/booking_provider.dart';
import 'package:lorrystand/widgets/menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:location/location.dart' as loc;
import 'package:animate_do/animate_do.dart';

const kGoogleApiKey = "API_KEY";
bool typing = false;

class CreateBookingPage extends StatefulWidget {
  CreateBookingPage({Key key, this.title}) : super(key: key);

  // This widget is the CreateBooking page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CreateBookingPageState createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage>
    with TickerProviderStateMixin {
  // to get places detail (lat/lng)
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBox(),
        //backgroundColor: Colors.green,
        iconTheme: IconThemeData(
          color: Colors.green
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ), 
      ),
      body:  Center(

        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

            FadeInLeft(child: Square()),
            FadeInUp(child: Square() ),
            FadeInDown(child: Square() ),
            FadeInRight(child: Square() ),
            
        ],
        ),

    ),

    );
  }
}

class Square extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
              style: new TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white60),
                filled: true,
                // prefixIcon: Icon(
                //   Icons.account_box,
                //   size: 28.0,
                // ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 0, 
                        style: BorderStyle.none,
                    ),
                ),
                suffixIcon: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      debugPrint('222');
                    }
                ),
              ),
            ),
          ),
          // SizedBox(
          //   child: IconButton(
          //     icon: Icon(typing ? Icons.search : Icons.cancel),
          //     color: Colors.white,
          //     onPressed: () {},
          //   ),
          // ),
        ],
      ),
    );
  }
}


class TextBoxs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(top: 5.0, left: 5.0),
            child: TextField(
              //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
              style: new TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white60),
                filled: true,
                // prefixIcon: Icon(
                //   Icons.account_box,
                //   size: 28.0,
                // ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                suffixIcon: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      debugPrint('222');
                    }),
              ),
            ),
          )),
          // SizedBox(
          //   child: IconButton(
          //     icon: Icon(typing ? Icons.search : Icons.cancel),
          //     color: Colors.white,
          //     onPressed: () {},
          //   ),
          // ),
        ],
      ),
    );
  }
}


