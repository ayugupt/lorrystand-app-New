import 'package:flutter/material.dart';

import 'package:lorrystand/pages/TripPage.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/widgets/BookingStatusWidget.dart';

import 'package:lorrystand/config/app_config.dart' as config;

class TripWidget extends StatefulWidget {
  final booking;
  String status;

  TripWidget({this.booking, @required this.status});
  @override
  _TripWidgetState createState() => _TripWidgetState();
}

class _TripWidgetState extends State<TripWidget> {
  Color chateauGreen = new Color(0xff00a64f);
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
        padding: EdgeInsets.only(
            left: config.App(context).appWidth(5),
            right: config.App(context).appWidth(5),
            top: config.App(context).appWidth(2)),
        child: GestureDetector(
            onTap: () {
              /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TripPage(id : widget.booking['id'])),
            );*/
            },
            child: Card(
              child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text("SHIP #${widget.booking["booking_no"]}",
                              style: Theme.of(context).textTheme.headline2),
                          Padding(
                            child: Row(children: <Widget>[
                              Text("Accepted Budget - ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                "${widget.booking["enquiry_amount"]}",
                                style: Theme.of(context).textTheme.headline2,
                              )
                            ]),
                            padding: EdgeInsets.only(
                                top: config.App(context).appHeight(1)),
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
                                "${widget.booking["truck_type"]["name"]}",
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
                                "num",
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
                                "${widget.booking["material_type"]["name"]}",
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
                                  width: config.App(context).appWidth(2),
                                ),
                                Text("${widget.booking["source_city"]["name"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
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
                                Text(
                                  "25 Aug - 08:00 AM",
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
                                  width: config.App(context).appWidth(2),
                                ),
                                Text(
                                    "${widget.booking["destination_city"]["name"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
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
                                Text(
                                  "28 Aug - 12:00 AM",
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
                                Text(
                                  "20-07-2019",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            widget.status == "confirmed"
                                ? RaisedButton(
                                    onPressed: () {},
                                    color: chateauGreen,
                                    child: Text(
                                      "Assign Truck",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : widget.status == "assigned"
                                    ? RaisedButton(
                                        onPressed: () {},
                                        color: color2,
                                        child: Text(
                                          "Track Truck",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      )
                                    : widget.status == "paymentStatus"
                                        ? RaisedButton(
                                            onPressed: () {},
                                            color: chateauGreen,
                                            child: Text(
                                              "Received",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          )
                                        : Row(
                                            children: <Widget>[
                                              Container(
                                                child: RaisedButton(
                                                  onPressed: () {},
                                                  color: chateauGreen,
                                                  child: Text(
                                                    "Sign",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                width: 60, /*height: 40,*/
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                child: RaisedButton(
                                                  onPressed: () {},
                                                  color: chateauGreen,
                                                  child: Text(
                                                    "View Receipt",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                width: 115,
                                              )
                                            ],
                                          )
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        )
                      ])),
              elevation: 10,
            )));

    /*return Container(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TripPage(id: widget.booking['id'])),
              );
            },
            child: Card(
              child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            widget.booking['source_city'] == null
                                ? Text("")
                                : Text(
                                    "${widget.booking['source_city']['name']}",
                                    style:
                                        Theme.of(context).textTheme.headline2),
                            Text(" - ",
                                style: Theme.of(context).textTheme.headline2),
                            widget.booking['destination_city'] == null
                                ? Text("")
                                : Text(
                                    "${widget.booking['destination_city']['name']}",
                                    style:
                                        Theme.of(context).textTheme.headline2)
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
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.grey),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                        ]),
                        SizedBox(height: 10),
                        Row(children: <Widget>[
                          Expanded(
                            child: Text(
                              "Enquiry Amount",
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.grey),
                            ),
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
                            child: Text(
                              "Enquiry Weight",
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.grey),
                            ),
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
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.grey),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "${widget.booking['truck_type']['name']}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
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
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.grey),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "${widget.booking['truck_capacity']['name']}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
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
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.grey),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "${widget.booking['truck_size']['name']}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
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
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.grey),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  widget.booking['material_type'] == null
                                      ? Text("")
                                      : Text(
                                          "${widget.booking['material_type']['name']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                          textAlign: TextAlign.right,
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                        BookingStatusWidget(
                          booking: widget.booking,
                          type: 'trip',
                        ),
                        SizedBox(height: 20),
                      ])),
            )));*/
  }
}
