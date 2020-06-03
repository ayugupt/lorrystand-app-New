import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/providers/booking_provider.dart';
import 'package:lorrystand/widgets/BookingWidget.dart';

class BookingsWidget extends StatefulWidget {
  final bookings;

  BookingsWidget({this.bookings});
  @override
  _BookingsWidgetState createState() => _BookingsWidgetState();
}

class _BookingsWidgetState extends State<BookingsWidget> {

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

    return  new ListView.builder(
      itemCount: bookingProvider.bookings.length,
      itemBuilder: (context, i) => BookingWidget(booking : bookingProvider.bookings[i])     
    );
  }
}