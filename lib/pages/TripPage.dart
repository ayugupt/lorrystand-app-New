import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/providers/trip_provider.dart';
import 'package:lorrystand/widgets/AssignTruckWidget.dart';
import 'package:lorrystand/widgets/HelperWidget.dart';
import 'package:lorrystand/widgets/BookingStatusWidget.dart';

class TripPage extends StatefulWidget {
  final int id;

  TripPage({Key key, this.id}) : super(key: key);

  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  var userProvider;
  var tripProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tripProvider = Provider.of<TripProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    tripProvider.fetch(widget.id);
  }

  @override
  void dispose() {
    tripProvider.resetBooking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: Text("Trip Detail"),
        ),
        body: tripProvider.trip?.isEmpty ?? true
            ? buildCircularProgressIndicator()
            : Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ListView(
                  children: [
                    SizedBox(height: 15.0),
                    baseDetails(tripProvider, tripProvider.trip),
                    SizedBox(height: 15.0),
                    address(tripProvider.trip),
                    SizedBox(height: 15.0),
                    userProvider.userRole != 'transporter'
                      ? SizedBox()
                      : bid(context, tripProvider),
                    userProvider.userRole == 'customer'
                        ? _bids(tripProvider)
                        : SizedBox(),
                    SizedBox(height: 15.0),
                    userProvider.userRole != 'transporter' && tripProvider.trip['booking_status'] == 'accepted'
                        && tripProvider.trip['accepted_bid'] != null
                        ? SizedBox()
                        : _truck(context, tripProvider),
                    SizedBox(height: 40.0),
                  ],
                )));
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

  Widget bid(BuildContext context, TripProvider tripProvider) {
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
                  title: tripProvider.bid != null
                      ? Text("₹${tripProvider.bid['name']}")
                      : Text("Enter your bidding amount"),                  
                ),
                SizedBox(height: 20.0)
              ],
            ),
          );
  }

  Widget _truck(BuildContext context, TripProvider tripProvider) {
    return tripProvider.trip['transport_id'] == userProvider.transport['id']
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
                  title: tripProvider.truck == null
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
                                          title: Text("${tripProvider.truck['vehicle_number']}",
                                                  style: Theme.of(context).textTheme.headline6,
                                                ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children : <Widget>[
                                              //SizedBox(height:2.0),
                                              Text("${tripProvider.truck['name']}" , style: TextStyle(fontSize: 16.0),),
                                              //SizedBox(height:2.0),
                                              Text("${tripProvider.truck['model']}" , style: TextStyle(fontSize: 16.0),),
                                            ]
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                 ),
                SizedBox(height: 20.0)
              ],
            ),
          );
  }

  Widget _bids(TripProvider tripProvider) {
    return tripProvider.bids.length == 0
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
                  itemCount: tripProvider.bids.length,
                  itemBuilder: (context, i) =>
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    i != 0 ? Divider() : SizedBox(),
                    ListTile(
                      title:
                          Text("${tripProvider.bids[i]['transport_name']}"),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${tripProvider.bids[i]['name']}"),
                            Text(
                                '${tripProvider.bids[i]['accept_status'].toUpperCase()}'),
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

  Widget baseDetails(tripProvider, booking) {
    return Card(
      child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    booking['source_city'] == null
                        ? Text("")
                        : Text("${booking['source_city']['name']}",
                            style: Theme.of(context).textTheme.headline2),
                    Text(" - ", style: Theme.of(context).textTheme.headline2),
                    booking['destination_city'] == null
                        ? Text("")
                        : Text("${booking['destination_city']['name']}",
                            style: Theme.of(context).textTheme.headline2)
                  ],
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      "#${booking['booking_no']}",
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  tripProvider.bids.length == 0
                  ? SizedBox() 
                  : Expanded(
                    child: Text(
                      "${tripProvider.bids.length} Bids",
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ]),
                SizedBox(height: 10),
                tripProvider.trip['booking_status'] == 'confirmed'
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
                      "₹${booking['amount']}",
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
                BookingStatusWidget(booking: tripProvider.trip, type: 'trip'),
                SizedBox(height: 20),              
              ])),      
    );
  }

  Widget _otp(BuildContext context, TripProvider tripProvider){
    return tripProvider.trip['trip_details'] == null
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
              Text("${tripProvider.trip['trip_details']['otp']}" , style: TextStyle(color: Colors.redAccent, fontSize: 18.0 , fontWeight: FontWeight.w800),)
            ]
          ),
        )
      ),
      SizedBox(height: 15.0)
      ]
        );    
  } 
}