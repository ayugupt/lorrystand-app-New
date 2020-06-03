import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lorrystand/providers/booking_provider.dart';
import 'package:provider/provider.dart';

import 'BookingWidgetCustomer.dart';

class BookingsWidgetCustomer extends StatefulWidget {
  final bookings;

  BookingsWidgetCustomer({this.bookings});

  @override
  _BookingsWidgetCustomerState createState() => _BookingsWidgetCustomerState();
}

class _BookingsWidgetCustomerState extends State<BookingsWidgetCustomer> {
  var bookingProvider;
  var userProvider;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isLoading) {
      bookingProvider = Provider.of<BookingProvider>(context);
      bookingProvider.list();
    }
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: new AppBar(
          backgroundColor: Color(0xFF232937),
          elevation: 0,
        ),
        body: Stack(
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
                          padding: const EdgeInsets.only(top: 13.0),
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
              child: Container(
                  height: size.height / 1.3,
                  child: new ListView.builder(
                      itemCount: bookingProvider.bookings.length,
                      itemBuilder: (context, i) => BookingWidgetCustomer(
                          booking: bookingProvider.bookings[i]))),
            ),
          ],
        ));
  }
}
