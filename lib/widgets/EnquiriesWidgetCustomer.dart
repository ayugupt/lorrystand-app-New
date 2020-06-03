import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lorrystand/providers/booking_provider.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/providers/enquiry_provider.dart';
import 'package:lorrystand/widgets/BookingWidget.dart';

import 'BookingWidgetCustomer.dart';

class EnquiriesWidgetCustomer extends StatefulWidget {
  final enquiry;

  EnquiriesWidgetCustomer({this.enquiry});
  @override
  _EnquiriesWidgetCustomerState createState() => _EnquiriesWidgetCustomerState();
}

class _EnquiriesWidgetCustomerState extends State<EnquiriesWidgetCustomer> {

  var bookingProvider1,bookingProvider2;
  bool _isLoading = true;
  var tab;


  @override
  void initState() {
    setState(() {
      tab="waiting";
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isLoading) {
      bookingProvider1 = Provider.of<EnquiryProvider>(context);
      bookingProvider1.list();
      bookingProvider2 = Provider.of<BookingProvider>(context);
      bookingProvider2.list();
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    }
    _isLoading = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: new AppBar(
          backgroundColor:Color(0xFF232937),
          elevation: 0,
        ),
        body:Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Container(
              child: ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: size.height / 2.2,
                  color: Color(0xFF232937),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.mapMarkedAlt,
                    color: Colors.amber,
                    size: size.width / 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Enquiry",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width / 17,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:13.0),
                          child: Text(
                            "List of Enquiries you have placed",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width / 28,
                                fontWeight: FontWeight.w300),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    textColor:  tab=="waiting"?Colors.white:Colors.black,
                    color: tab=="waiting"?
                    Colors.redAccent:Colors.amber,
                    child: Text("Waiting"),
                    onPressed: () {
                      setState(() {
                        tab="waiting";
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
                    child: Text("Bids"),
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
            tab=="waiting"?
            Padding(
              padding: const EdgeInsets.only(top:140),
              child: Container(
                  height: size.height/1.3,
                  child: new ListView.builder(
                      itemCount: bookingProvider1.enquires.length,
                      itemBuilder: (context, i) => BookingWidgetCustomer(booking : bookingProvider1.enquires[i])
                  ),
              ),
            ):            Padding(
    padding: const EdgeInsets.only(top: 140),
    child: Container(
    height: size.height / 1.3,
    child: new ListView.builder(
    itemCount: bookingProvider2.bookings.length,
    itemBuilder: (context, i) => BookingWidgetCustomer(
    booking: bookingProvider2.bookings[i]))),
    ),
          ],
        )
    );

  }
}