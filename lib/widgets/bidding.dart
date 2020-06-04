import 'package:flutter/material.dart';
import 'package:lorrystand/config/app_config.dart' as config;

class Bidding extends StatefulWidget {
  final booking;
  Bidding(this.booking);
  _BiddingState createState() => _BiddingState();
}

class _BiddingState extends State<Bidding> {
  Color color1 = new Color(0xff212732);
  Color color2 = new Color(0xfffed226);

  Color osloGrey = new Color(0xff858c96);
  Color chateauGreen = new Color(0xff00a64f);

  String _profileImageUrl;
  String _name;
  String _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color1,
        iconTheme: IconThemeData(color: color2),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: config.App(context).appWidth(100),
            height: config.App(context).appHeight(40),
            child: ClipPath(
              child: Container(
                color: color1,
              ),
              clipper: Design(),
            ),
          ),
          ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: config.App(context).appWidth(5),
                    top: config.App(context).appHeight(0)),
                child: Row(
                  children: <Widget>[
                    _profileImageUrl != null
                        ? Container(
                            width: config.App(context).appHeight(12),
                            height: config.App(context).appHeight(12),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(_profileImageUrl),
                                    fit: BoxFit.cover)),
                          )
                        : Container(
                            width: config.App(context).appHeight(12),
                            height: config.App(context).appHeight(12),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                                size: config.App(context).appHeight(11),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: config.App(context).appHeight(15),
                      child: Column(
                        children: <Widget>[
                          Text(
                            _name == null ? "Name" : _name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22),
                          ),
                          Text(
                            _dateTime == null
                                ? "22 Jan 2019, 07:00 AM"
                                : _dateTime,
                            style: TextStyle(color: osloGrey),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: config.App(context).appHeight(2),
              ),
              Center(
                child: Container(
                  width: config.App(context).appWidth(90),
                  child: Card(
                    elevation: 10,
                    child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                  children: <Widget>[
                                    Text("Ship#${widget.booking['booking_no']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                    Padding(
                                      child: Row(children: <Widget>[
                                        Text("Customer Budget - ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          "₹${widget.booking['enquiry_amount']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        )
                                      ]),
                                      padding: EdgeInsets.only(
                                          top:
                                              config.App(context).appHeight(1)),
                                    )
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      Text(
                                          widget.booking['source_city'] == null
                                              ? ""
                                              : "${widget.booking['source_city']['name']}",
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
                                        widget.booking['scheduled_date'] == null
                                            ? ""
                                            : "${widget.booking['scheduled_date']}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      )
                                    ],
                                  )
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          widget.booking['destination_city'] ==
                                                  null
                                              ? ""
                                              : "${widget.booking['destination_city']['name']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                  child: Container(
                                child: TextField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[200])),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[200])),
                                      hintText: "Message to the customer\n\n",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[500])),
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                ),
                                width: config.App(context).appWidth(60),
                              )),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                  child: Container(
                                child: TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[200])),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[200])),
                                    hintText: "Your Price",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[500]),
                                  ),
                                ),
                                width: config.App(context).appWidth(50),
                              )),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: RaisedButton(
                                  child: Text(
                                    "Bid",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {},
                                  color: chateauGreen,
                                ),
                              )
                            ])),
                  ),
                ),
              ),
              SizedBox(
                height: config.App(context).appHeight(50),
              )
            ],
          )
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class Design extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.95);
    /*path.conicTo(
        size.width * 0.05, size.height, size.width, size.height * 0.6, 1);*/
    path.cubicTo(size.width * 0.15, size.height, size.width * 0.5,
        size.height * 0.7, size.width, size.height * 0.65);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(oldDelegate) {
    return false;
  }
}
