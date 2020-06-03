import 'package:flutter/material.dart';
import 'package:lorrystand/widgets/BookingWidgetCustomer.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/providers/bid_provider.dart';
import 'package:lorrystand/widgets/BookingWidget.dart';

import 'BookingWidgetTransporter.dart';

class BidsWidget extends StatefulWidget {
  final bookings;

  BidsWidget({this.bookings});
  @override
  _BidsWidgetState createState() => _BidsWidgetState();
}

class _BidsWidgetState extends State<BidsWidget> {

 var bidProvider;
 bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isLoading) {
      bidProvider = Provider.of<BidProvider>(context);     
      bidProvider.list();
    }
    _isLoading = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return  bidProvider.bids.length == 0 ? nobidsFound() : new ListView.builder(
      itemCount: bidProvider.bids.length,
      itemBuilder: (context, i) => BookingWidget(booking : bidProvider.bids[i])
    );
  }
}

Widget nobidsFound(){
  return Center(
    child: Container(
      child :  Column(
      children: <Widget>[
        Text("No Bids Found")
      ]
    ),
    )
  );
}