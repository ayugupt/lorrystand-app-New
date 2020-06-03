import 'package:flutter/material.dart';

class BookingStatusWidget extends StatelessWidget {
  final dynamic booking;
  final String type;

  const BookingStatusWidget({Key key, @required this.booking , this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        SizedBox(height: 15),
        Row(children: <Widget>[
          Expanded(
            child: Text("Booking Status" , style: TextStyle(fontSize: 16.0 ,color: Colors.grey),),
          ),
          Expanded(
            child: _bookingStatus(booking['booking_status']),
          ),
        ]),
        type == 'trip' && booking['trip_status'] != 'waiting' ? SizedBox(height: 15) : SizedBox(),
        type != 'trip' || booking['trip_status'] == 'waiting' ? SizedBox() 
        : Row(children: <Widget>[
          Expanded(
            child: Text("Trip Status" , style: TextStyle(fontSize: 16.0 ,color: Colors.grey),),
          ),
          Expanded(
            child: _tripStatus(booking['trip_status']),
          ),
        ]),
      ],
    );
  }

  Widget _bookingStatus(status){
    switch (status) {
      case 'enquiry':
         return  Text(
              "Enquiry",
              style: TextStyle(color: Colors.orangeAccent , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      case 'bidding':
         return  Text(
              "Bidding",
              style: TextStyle(color: Colors.orangeAccent , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      case 'accepted':
         return  Text(
              "Bid Accepted",
              style: TextStyle(color: Colors.orangeAccent , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      case 'processing':
         return  Text(
              "Processing",
              style: TextStyle(color: Colors.orangeAccent , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      case 'confirmed':
         return  Text(
              "Confirmed",
              style: TextStyle(color: Colors.orangeAccent , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      case 'cancelled':
         return  Text(
              "Cancelled",
              style: TextStyle(color: Colors.redAccent , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      case 'completed':
         return  Text(
              "Completed",
              style: TextStyle(color: Colors.green , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      case 'transport_cancelled':
         return  Text(
              "Transport Cancelled",
              style: TextStyle(color: Colors.redAccent , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      default:
        return Container();        
    }

  }

   Widget _tripStatus(status){
    switch (status) {
      case 'waiting':
         return  Text(
              "Waiting",
              style: TextStyle(color: Colors.cyanAccent , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      case 'driver_accepted':
         return  Text(
              "Driver Accepted",
              style: TextStyle(color: Colors.cyanAccent , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      case 'driver_cancelled':
         return  Text(
              "Driver Cancelled",
              style: TextStyle(color: Colors.redAccent , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      case 'loaded':
         return  Text(
              "Loaded",
              style: TextStyle(color: Colors.cyanAccent , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      case 'unloaded':
         return  Text(
              "Unloaded",
              style: TextStyle(color: Colors.green , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      case 'riding':
         return  Text(
              "Start Ride",
              style: TextStyle(color: Colors.green , fontSize: 16.0, fontWeight: FontWeight.w800),
              textAlign: TextAlign.right,
            );        
        break;
      default:
        return Container();        
    }
  }
}