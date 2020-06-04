import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/providers/enquiry_provider.dart';
import 'package:lorrystand/widgets/BookingWidget.dart';

import 'BookingWidgetTransporter.dart';

class EnquiriesWidget extends StatefulWidget {
  final enquiry;

  EnquiriesWidget({this.enquiry});
  @override
  _EnquiriesWidgetState createState() => _EnquiriesWidgetState();
}

class _EnquiriesWidgetState extends State<EnquiriesWidget> {
  var bookingProvider;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isLoading) {
      bookingProvider = Provider.of<EnquiryProvider>(context);
      bookingProvider.list();
      print(
          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    }
    _isLoading = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: bookingProvider.enquires.length,
        itemBuilder: (context, i) =>
            BookingWidgetTransporter(booking: bookingProvider.enquires[i]));
  }
}
