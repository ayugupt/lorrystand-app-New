import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lorrystand/pages/BookingPage.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/widgets/BookingStatusWidget.dart';

class BookingWidgetCustomer extends StatefulWidget {
  final booking;

  BookingWidgetCustomer({this.booking});
  @override
  _BookingWidgetCustomerState createState() => _BookingWidgetCustomerState();
}

class _BookingWidgetCustomerState extends State<BookingWidgetCustomer> {

  @override
  void initState() {
    //_tempSelectedCities = widget.selectedCities;
    super.initState();
  }

   //FullScreenDialog _myDialog = new FullScreenDialog();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return  Container(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap : () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookingPage(id : widget.booking['id'])),
            );
          },
          child:  Container(
              child: GestureDetector(
                  onTap : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingPage(id : widget.booking['id'])),
                    );
                  },
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: widget.booking['customer'] == null
                                    ? Text("")
                                    : Container(
                                  width: size.width/3,
                                  child: Text("${widget.booking['customer']['fullname']}",
                                    style: TextStyle(fontWeight:FontWeight.bold,fontSize: size.height/44,color: Colors.black),overflow:TextOverflow.ellipsis,maxLines: 1,),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: size.height/23,
                                    backgroundColor: Colors.lightBlue,
                                    child: Image.asset("assets/truck.png",height: size.height/20,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: size.width/63,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Image.asset("assets/points.png",height: size.height/23,),
                                            SizedBox(width: size.width/33,),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                widget.booking['source_city'] == null
                                                    ? Text("")
                                                    : Text("${widget.booking['source_city']['name']}",
                                                  style: TextStyle(fontWeight:FontWeight.bold,fontSize: size.height/64,color: Colors.black),),
                                                SizedBox(height: size.height/159,),
                                                widget.booking['destination_city'] == null
                                                    ? Text("Not Found",style: TextStyle(fontWeight:FontWeight.bold,fontSize: size.height/64,color: Colors.black))
                                                    : Text("${widget.booking['destination_city']['name']}",
                                                  style: TextStyle(fontWeight:FontWeight.bold,fontSize: size.height/64,color: Colors.black),),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        FaIcon(FontAwesomeIcons.calendarAlt),
                                        SizedBox(height: size.height/79,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            SizedBox(width: size.height/189,),
                                            widget.booking['scheduled_date'] == null
                                                ? Text("Not Found",style: TextStyle(fontWeight:FontWeight.bold,fontSize: size.height/74,color: Colors.black),textAlign: TextAlign.center,)
                                                : Container(
                                              width: size.height/10,
                                              child: Text("${widget.booking['scheduled_date']}",
                                                style: TextStyle(fontWeight:FontWeight.bold,fontSize: size.height/74,color: Colors.black),textAlign: TextAlign.center,),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: size.height/87,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  widget.booking['created_at'] == null
                                      ? Text("")
                                      : Expanded(
                                    child: Center(
                                      child: Container(
                                        width:  size.height/8,
                                        child: Text("${widget.booking['created_at']}",
                                          style: TextStyle(fontWeight:FontWeight.bold,fontSize: size.height/54,color: Colors.grey),maxLines: 1,),
                                      ),
                                    ),
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => BookingPage(id : widget.booking['id'])),
                                      );
                                    },
                                    color: Colors.amber,
                                    textColor: Colors.white,
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 6.4,
                                      height: size.height / 24,
                                      child: Center(
                                        child:  widget.booking['bids'].length == 0
                                            ? Text(
                                          "Accepted",
                                          style: TextStyle(
                                              fontSize: size.width / 30,
                                              color: Color(0xFF232937),
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,)
                                            : Expanded(
                                            child: Text(
                                              "Bids-${widget.booking['bids'].length}",
                                              style: TextStyle(
                                                  fontSize: size.width / 30,
                                                  color: Color(0xFF232937),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,)
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                    ),
                  )
              )

          )
        )
    
    );
  }
}