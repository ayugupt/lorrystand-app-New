import 'package:flutter/material.dart';

import 'package:lorrystand/pages/TripPage.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/widgets/BookingStatusWidget.dart';

class TripWidget extends StatefulWidget {
  final booking;

  TripWidget({this.booking});
  @override
  _TripWidgetState createState() => _TripWidgetState();
}

class _TripWidgetState extends State<TripWidget> {

  @override
  void initState() {
    //_tempSelectedCities = widget.selectedCities;
    super.initState();
  }

   //FullScreenDialog _myDialog = new FullScreenDialog();

  @override
  Widget build(BuildContext context) {

    return  Container(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap : () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TripPage(id : widget.booking['id'])),
            );
          },
          child:  Card(
          child: Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        widget.booking['source_city'] == null 
                        ? Text("")
                        : Text("${widget.booking['source_city']['name']}",
                            style: Theme.of(context).textTheme.headline2),
                        Text(" - ",
                            style: Theme.of(context).textTheme.headline2),
                        widget.booking['destination_city'] == null 
                        ? Text("")
                        : Text("${widget.booking['destination_city']['name']}",
                            style: Theme.of(context).textTheme.headline2)
                      ],
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: Text(
                          "#${widget.booking['booking_no']}",
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      widget.booking['bids'].length == 0
                      ? SizedBox() 
                      : Expanded(
                        child: Text(
                          "${widget.booking['bids'].length} Bids",
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ]),
                    SizedBox(height: 10),
                    Row(children: <Widget>[
                      Expanded(
                        child: Text("Enquiry Amount" , style: TextStyle(fontSize: 16.0 ,color: Colors.grey),),
                      ),
                      Expanded(
                        child: Text(
                          "₹${widget.booking['enquiry_amount']}",
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ]),
                    SizedBox(height: 15.0),
                    Row(children: <Widget>[
                      Expanded(
                        child: Text("Enquiry Weight" , style: TextStyle(fontSize: 16.0 ,color: Colors.grey),),
                      ),
                      Expanded(
                        child: Text(
                          "${widget.booking['enquiry_weight']}",
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ]),
                    SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Truck Type",
                                //style: Theme.of(context).textTheme.headline6,
                                style: TextStyle(fontSize: 16.0 , color: Colors.grey),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                "${widget.booking['truck_type']['name']}",
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Truck Capacity",
                                //style: Theme.of(context).textTheme.headline6,
                                style: TextStyle(fontSize: 16.0 , color: Colors.grey),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                "${widget.booking['truck_capacity']['name']}",
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Truck Size",
                                //style: Theme.of(context).textTheme.headline6,
                                style: TextStyle(fontSize: 16.0 ,color: Colors.grey),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                "${widget.booking['truck_size']['name']}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6,
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Material Type",
                                //style: Theme.of(context).textTheme.headline6,
                                style: TextStyle(fontSize: 16.0 ,color: Colors.grey),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(height: 10.0,),
                              widget.booking['material_type'] == null 
                              ? Text("")
                              : Text(
                                "${widget.booking['material_type']['name']}",                               
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    BookingStatusWidget(booking: widget.booking, type: 'trip',),
                    SizedBox(height: 20),
                  ])),
          
          )
        )
    
    );
  }
}