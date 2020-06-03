import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/providers/booking_provider.dart';
import 'package:lorrystand/widgets/AssignTruckWidget.dart';
import 'package:lorrystand/widgets/HelperWidget.dart';
import 'package:lorrystand/widgets/BookingStatusWidget.dart';

class BookingPage extends StatefulWidget {
  final int id;

  BookingPage({Key key, this.id}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  var userProvider;
  var bookingProvider;
  bool _cancelBtnLoad = false;
  bool _tripStatusBtnLoad = false;
  bool _bidBtnLoad = false;
  bool _bidAcceptBtn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bookingProvider = Provider.of<BookingProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    bookingProvider.fetch(widget.id);
  }

  @override
  void dispose() {
    bookingProvider.resetBooking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Color(0xFF232937),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              child: ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: size.height / 2.2,
                  color: Color(0xFF232937),
                ),
              ),
            ),
            bookingProvider.booking?.isEmpty ?? true
                ? buildCircularProgressIndicator()
                : Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ListView(
                  children: [
                    SizedBox(height: 15.0),
                    baseDetails(bookingProvider, bookingProvider.booking),
                    SizedBox(height: 15.0),
                    userProvider.userRole != 'customer' && bookingProvider.booking['booking_status'] == 'confirmed'
                        ? SizedBox()
                        : _otp(context, bookingProvider),
                    address(bookingProvider.booking),
                    SizedBox(height: 15.0),
                    userProvider.userRole != 'transporter'
                        ? SizedBox()
                        : bid(context, bookingProvider),
                    SizedBox(height: 15.0),
                    userProvider.userRole != 'transporter' && bookingProvider.booking['booking_status'] == 'accepted'
                        && bookingProvider.booking['accepted_bid'] != null
                        ? SizedBox()
                        : _truck(context, bookingProvider),
                    SizedBox(height: 40.0),
                  ],
                ))
          ],
        ));
  }

  Widget address(booking) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("Address"),
          ),
          Divider(),
          ListTile(
            title: Text("From"),
            subtitle: Text("${booking['source_address']}"),
            leading: Icon(
              FontAwesomeIcons.mapMarkerAlt,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 10.0),
          ListTile(
            title: Text("To"),
            subtitle: Text("${booking['destination_address']}"),
            leading: Icon(
              FontAwesomeIcons.mapMarkerAlt,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 20.0)
        ],
      ),
    );
  }

  Widget bid(BuildContext context, BookingProvider bookingProvider) {
    return userProvider.userRole != 'transporter'
        ? SizedBox()
        : Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("You Bid"),
                ),
                Divider(),
                ListTile(
                  title: bookingProvider.bid != null
                      ? Text("₹${bookingProvider.bid['name']}")
                      : Text("Enter your bidding amount"),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                            width: 80, // specific value
                            child: bookingProvider.bid != null
                                ? RaisedButton(
                                    onPressed: () async {
                                      var amount = await _bidDialog(
                                          context, bookingProvider.bid['name']);
                                          print(amount);
                                      if (amount != null)
                                        bookingProvider.updateBid(
                                            bookingProvider.booking['id'],
                                            amount);
                                    },
                                    color: Colors.green,
                                    // padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Update",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : RaisedButton(
                                    onPressed: () async {
                                      var amount = await _bidDialog(context, 0);
                                      if (amount != null){

                                      print(amount);
                                         bookingProvider.createBid(
                                            bookingProvider.booking['id'],
                                            amount);
                                      }
                                       
                                    },
                                    color: Colors.green,
                                    // padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Bid",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ))
                      ]),
                ),
                SizedBox(height: 20.0)
              ],
            ),
          );
  }

  Widget _truck(BuildContext context, BookingProvider bookingProvider) {
    return bookingProvider.booking['transport_id'] == userProvider.transport['id']
        ? SizedBox()
        : Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("Truck Details"),
                ),
                Divider(),
                ListTile(
                  title: bookingProvider.truck == null
                      ? Text("Not assign truck")
                      : Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://via.placeholder.com/150"),
                                          fit: BoxFit.cover)),
                                  margin:
                                      EdgeInsets.only(left: 16.0, top: 10.0),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16.0),
                                    // margin: EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                       ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          title: Text("${bookingProvider.truck['vehicle_number']}",
                                                  style: Theme.of(context).textTheme.headline6,
                                                ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children : <Widget>[
                                              //SizedBox(height:2.0),
                                              Text("${bookingProvider.truck['name']}" , style: TextStyle(fontSize: 16.0),),
                                              //SizedBox(height:2.0),
                                              Text("${bookingProvider.truck['model']}" , style: TextStyle(fontSize: 16.0),),
                                            ]
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                  subtitle:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: <
                          Widget>[
                    SizedBox(
                        width: 90, // specific value
                        child: bookingProvider.truck != null
                            ? RaisedButton(
                                onPressed: () async {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) =>
                                              AssignTruckWidget(
                                                  bookingId: bookingProvider
                                                      .booking['id'])));
                                },
                                color: Colors.blueAccent[700],
                                // padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Change",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) =>
                                              AssignTruckWidget(
                                                  bookingId: bookingProvider
                                                      .booking['id'])));
                                },
                                color: Colors.green,
                                // padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Assign",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                  ]),
                ),
                SizedBox(height: 20.0)
              ],
            ),
          );
  }

  Widget _bids(BookingProvider bookingProvider) {
    return bookingProvider.bids.length == 0
        ? SizedBox()
        : Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              //shrinkWrap: false,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text("Transporter Bids"),
                ),
                Divider(),
                new ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: bookingProvider.bids.length,
                  itemBuilder: (context, i) =>
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    i != 0 ? Divider() : SizedBox(),
                    ListTile(
                      title:
                          Text("${bookingProvider.bids[i]['transport_name']}"),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${bookingProvider.bids[i]['name']}"),
                            Text(
                                '${bookingProvider.bids[i]['accept_status'].toUpperCase()}'),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                      width: 80, // specific value
                                      child: bookingProvider.bids[i]
                                                  ['accept_status'] ==
                                              'proposal'
                                          ? RaisedButton(
                                              onPressed: () =>
                                                  bookingProvider.acceptBid(
                                                      bookingProvider
                                                          .booking['id'],
                                                      bookingProvider.bids[i]
                                                          ['id']),
                                              color: Colors.green,
                                              // padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "Accept",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          : bookingProvider.bids[i]
                                                      ['accept_status'] ==
                                                  'accepted'
                                              ? RaisedButton(
                                                  onPressed: () =>
                                                      bookingProvider.cancelBid(
                                                          bookingProvider
                                                              .booking['id'],
                                                          bookingProvider
                                                              .bids[i]['id']),
                                                  color: Colors.red,
                                                  // padding: EdgeInsets.all(10.0),
                                                  child: Text(
                                                    "Reject",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              : SizedBox())
                                ])
                          ]),
                      //selected: true,
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                            NetworkImage("https://via.placeholder.com/150"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(height: 10.0)
                  ]),
                )
              ],
            ),
          );
  }

  Widget baseDetails(bookingProvider, booking) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: size.height / 23,
              backgroundColor: Colors.lightBlue,
              child: Image.asset(
                "assets/truck.png",
                height: size.height / 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: booking['customer'] == null
                        ? Text("")
                        : Container(
                      width: size.width / 2,
                      child: Text(
                        "${booking['customer']['fullname']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.height / 34,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  booking['created_at'] == null
                      ? Text("")
                      : Container(
                    width: size.height / 8,
                    child: Text(
                      "${booking['created_at']}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.height / 54,
                          color: Colors.grey),
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        userProvider.userRole == 'customer'
            ? _bids(bookingProvider)
            : SizedBox(),
        SizedBox(height: size.height/45,),
        Card(
          child: Container(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        children: <Widget>[
                          Text("SHIP#${booking['booking_no']}",
                              style: Theme.of(context).textTheme.headline2),
                          booking['enquiry_amount'] == null
                              ? Text("")
                              : Text(
                            "₹${booking['enquiry_amount']}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,fontSize: size.width/19),
                          ),
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
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
                              width: 12,
                            ),
                            booking['source_city'] == null
                                ? Text("")
                                : Text("${booking['source_city']['name']}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            FaIcon(FontAwesomeIcons.calendarAlt),
                            SizedBox(
                              width: 5,
                            ),
                            booking['scheduled_date'] == null
                                ? Text("")
                                : Text(
                              "${booking['scheduled_date']}",
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
                              width: 12,
                            ),
                            booking['destination_city'] == null
                                ? Text("")
                                : Text("${booking['destination_city']['name']}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
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
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[
                                bookingProvider.bids.length == 0
                                    ? SizedBox()
                                    : Expanded(
                                  child: Text(
                                    "${bookingProvider.bids.length} Bids",
                                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ]),
                              SizedBox(height: 10),
                              bookingProvider.booking['booking_status'] == 'confirmed'
                                  ? Row(children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "Enquiry Amount",
                                    style: TextStyle(fontSize: 16.0 ,color: Colors.grey),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "₹${booking['enquiry_amount']}",
                                    style: Theme.of(context).textTheme.headline6,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ])
                                  : Row(children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "Amount",
                                    style: TextStyle(fontSize: 16.0 ,color: Colors.grey),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "₹${booking['enquiry_amount']}",
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
                                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${booking['enquiry_weight']}",
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
                                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "${booking['truck_type']['name']}",
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
                                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                                          textAlign: TextAlign.right,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "${booking['truck_capacity']['name']}",
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
                                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "${booking['truck_size']['name']}",
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
                                          "Material Type",
                                          //style: Theme.of(context).textTheme.headline6,
                                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                                          textAlign: TextAlign.right,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        booking['material_type'] == null
                                            ? Text("")
                                            : Text(
                                          "${booking['material_type']['name']}",
                                          style: Theme.of(context).textTheme.headline6,
                                          textAlign: TextAlign.right,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              BookingStatusWidget(booking: bookingProvider.booking, type: 'trip'),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  userProvider.userRole == 'customer'
                                      ? _customerBookingStatusButton(bookingProvider.booking['booking_status'])
                                      : SizedBox(),
                                  userProvider.userRole == 'transporter'
                                      ? _transporterBookingStatusButton(bookingProvider.booking['booking_status'])
                                      : SizedBox(),
                                  userProvider.userRole == 'driver' && bookingProvider.booking['booking_status'] == 'processing'
                                      ? _driverBookingStatusButton(bookingProvider.booking['booking_status'])
                                      : SizedBox(),
                                  userProvider.userRole == 'driver' && bookingProvider.booking['booking_status'] == 'confirmed'
                                      ? _driverTripStatusButton(bookingProvider.booking['trip_status'])
                                      : SizedBox(),


                                ],
                              ),
                            ]))
                  ])),
          elevation: 10,
        ),
      ],
    );
  }
  Widget _otp(BuildContext context, BookingProvider bookingProvider){
    return bookingProvider.booking['trip_details'] == null
           ? SizedBox()
        : Column(
          children : <Widget> [
        Card(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : <Widget>[
              Text("OTP" , style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),),
              Text("${bookingProvider.booking['trip_details']['otp']}" , style: TextStyle(color: Colors.redAccent, fontSize: 18.0 , fontWeight: FontWeight.w800),)
            ]
          ),
        )
      ),
      SizedBox(height: 15.0)
      ]
        );    
  }

  Widget _customerBookingStatusButton(status){
    switch(status){
      case "enquiry" :
        return _cancelButton();
      case "bidding" :
        return _cancelButton();
      case "accepted" :
        return _cancelButton();
      case "processing" :
        return _cancelButton();
      case "confirmed" :
        return SizedBox();
      default:
        return SizedBox();

    }    
  }

  Widget _transporterBookingStatusButton(status){
    switch(status){
      case "enquiry" :
        return _cancelButton();
      case "bidding" :
        return _cancelButton();
      case "accepted" :
        return _cancelButton();
      case "processing" :
        return _cancelButton();
      case "confirmed" :
        return SizedBox();
      default:
        return SizedBox();

    }    
  }

  Widget _driverBookingStatusButton(status){
    switch(status){
      case "enquiry" :
        return _cancelButton();
      case "bidding" :
        return _cancelButton();
      case "accepted" :
        return _cancelButton();
      case "processing" :
        return _cancelButton();
      case "confirmed" :
        return FlatButton(
                onPressed: () async {
                  var otp = await _veifyOTP(context);
                  if (otp != null)
                    bookingProvider.verifyOtp(
                        bookingProvider.booking['id'],
                        otp);
                },
                color: Colors.green,
                // padding: EdgeInsets.all(10.0),
                child: Text(
                  "Verify Otp",
                  style: TextStyle(color: Colors.white),
                ),
              );
      default:
        return SizedBox();
    }    
  }

  Widget _driverTripStatusButton(status){
    switch(status){
      case "driver_accepted" :
        return tripStatus('Loaded' , 'loaded');
      case "loaded" :
        return tripStatus('Start Ride' , 'riding');
      case "riding" :
        return tripStatus('Unload' , 'unloaded');
      case "unloaded" :
        return SizedBox();
      default:
        return SizedBox();
    }    
  }

  Widget tripStatus(text , status){
    return FlatButton(
            onPressed: ()  async {  
              if(!_tripStatusBtnLoad)  {
                ConfirmAction status = await _confirmDialog(context, 'Cancel Booking' , 'Are you want to cancel booking?');
              
                if(status == ConfirmAction.ACCEPT){
                  setState(() {
                    _tripStatusBtnLoad = true;
                  });
                  //await bookingProvider.driverUpdateStatus(bookingProvider.booking['id'] , status );
                await new Future.delayed(const Duration(seconds : 5));
                }
                setState(() {
                  _tripStatusBtnLoad = false;
                });
              }
            },
            color: Colors.redAccent,
            child: Row(
              children: <Widget>[
                // Icon(Icons.a?dd),
                _tripStatusBtnLoad == false
                  ? Text("$text" , style: TextStyle(color: Colors.white),)
                  : Row(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                        width: 10.0,
                        child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),                      
                      ),
                      SizedBox(width: 5.0,),
                      Text("$text" ,style: TextStyle(color: Colors.white),)
                    ]
                    
                        
                  )
              ],
            ),
          );
  }

  Widget _cancelButton(){
    return FlatButton(
            onPressed: ()  async {  
              if(!_cancelBtnLoad)  {
                ConfirmAction status = await _confirmDialog(context, 'Cancel Booking' , 'Are you want to cancel booking?');
              
                if(status == ConfirmAction.ACCEPT){
                  setState(() {
                    _cancelBtnLoad = true;
                  });
                  //await bookingProvider.cancel(bookingProvider.booking['id']);
                await new Future.delayed(const Duration(seconds : 5));
                }
                setState(() {
                  _cancelBtnLoad = false;
                });
              }
            },
            color: Colors.redAccent,
            child: Row(
              children: <Widget>[
                // Icon(Icons.a?dd),
                _cancelBtnLoad == false
                  ? Text("Cancel Booking" , style: TextStyle(color: Colors.white),)
                  : Row(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                        width: 10.0,
                        child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),                      
                      ),
                      SizedBox(width: 5.0,),
                      Text("Cancel Booking" ,style: TextStyle(color: Colors.white),)
                    ]
                    
                        
                  )
              ],
            ),
          );
  }
  
}

Future<String> _bidDialog(BuildContext context, amount) async {
  String bidAmount = amount.toString();
  return showDialog<String>(
    context: context,
    barrierDismissible:
        false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Bid Amount'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  //labelText: 'Bid Amount', hintText: '0'
                  ),
              onChanged: (input) {
                bidAmount = input;
              },
            ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              'Update',
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () {
              Navigator.of(context).pop(bidAmount);
            },
          ),
        ],
      );
    },
  );
}

Future<String> _veifyOTP(BuildContext context) async {
  String otp = "";
  return showDialog<String>(
    context: context,
    barrierDismissible:
        false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Verify Otp'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  //labelText: 'Bid Amount', hintText: '0'
                  ),
              onChanged: (value) {
                otp = value;
              },
            ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              'Verify',
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () {
              Navigator.of(context).pop(otp);
            },
          ),
        ],
      );
    },
  );
}

enum ConfirmAction { CANCEL, ACCEPT }

Future<ConfirmAction> _confirmDialog(BuildContext context , title , message) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("$title"),
        content: Text("$message"),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('ACCEPT'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}
