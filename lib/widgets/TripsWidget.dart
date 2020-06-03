import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/trip_provider.dart';
import 'package:lorrystand/widgets/TripWidget.dart';

class TripsWidget extends StatefulWidget {

  TripsWidget();
  @override
  _TripsWidgetState createState() => _TripsWidgetState();
}

class _TripsWidgetState extends State<TripsWidget> {

  var tripProvider;
  var userProvider;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async{
    if (_isLoading) {
      tripProvider = Provider.of<TripProvider>(context);  
      await tripProvider.list();  
    }
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return  new ListView.builder(
      itemCount: tripProvider.trips.length,
      itemBuilder: (context, i) => TripWidget(booking : tripProvider.trips[i])     
    );
  }
}