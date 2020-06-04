import 'package:flutter/material.dart';

import 'package:lorrystand/pages/BookingPage.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/widgets/BookingStatusWidget.dart';
import 'package:lorrystand/widgets/bidding.dart';

class BookingWidgetTransporter extends StatefulWidget {
  final booking;

  BookingWidgetTransporter({this.booking});
  @override
  _BookingWidgetTransporterState createState() =>
      _BookingWidgetTransporterState();
}

class _BookingWidgetTransporterState extends State<BookingWidgetTransporter> {
  Color color2 = new Color(0xfffed226);

  @override
  void initState() {
    //_tempSelectedCities = widget.selectedCities;
    super.initState();
  }

  //FullScreenDialog _myDialog = new FullScreenDialog();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Bidding(widget
                      .booking) /*BookingPage(id : widget.booking['id'])*/),
            );
          },
          child: Card(
            child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text("Ship#${widget.booking['booking_no']}",
                            style: Theme.of(context).textTheme.headline2),
                        Padding(
                          child: Row(children: <Widget>[
                            Text("Customer Budget - ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10)),
                            Text(
                              "₹${widget.booking['enquiry_amount']}",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            )
                          ]),
                          padding: EdgeInsets.only(top: 10),
                        )
                      ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Text("Lorry type",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${widget.booking['truck_type']['name']}",
                              style: TextStyle(fontSize: 14),
                            )
                          ]),
                          Row(children: <Widget>[
                            Text("No of trucks",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "1",
                              style: TextStyle(fontSize: 14),
                            )
                          ])
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Text("Material type",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${widget.booking['material_type']['name']}",
                              style: TextStyle(fontSize: 14),
                            )
                          ]),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 2),
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              widget.booking['source_city'] == null
                                  ? Text("")
                                  : Text(
                                      "${widget.booking['source_city']['name']}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              widget.booking['scheduled_date'] == null
                                  ? Text("")
                                  : Text(
                                      "${widget.booking['scheduled_date']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    )
                            ],
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      Padding(
                        child: Container(
                          height: 10,
                          width: 2,
                          color: Colors.yellow,
                        ),
                        padding: EdgeInsets.only(left: 4),
                      ),
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 2),
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              widget.booking['destination_city'] == null
                                  ? Text("")
                                  : Text(
                                      "${widget.booking['destination_city']['name']}",
                                      style:
                                          Theme.of(context).textTheme.headline4)
                            ],
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("Posted on: "),
                              widget.booking['created_at'] == null
                                  ? Text("")
                                  : Text(
                                      "${widget.booking['created_at']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    )
                            ],
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Bidding(widget
                                        .booking) /*BookingPage(
                                        id: widget.booking['id'])*/
                                    ),
                              );
                            },
                            color: Colors.amber,
                            child: Text(
                              "Bid The Budget",
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )
                    ])),
            elevation: 10,
          ),
        ));
  }
}
