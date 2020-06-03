import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:lorrystand/providers/booking_provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/widgets/EnquiriesWidgetCustomer.dart';
import 'package:lorrystand/widgets/MaterialTypeModal.dart';
import 'package:lorrystand/widgets/PlaceAutocomplete.dart';
import 'package:lorrystand/widgets/TruckCapacityModal.dart';
import 'package:lorrystand/widgets/TruckSizeModal.dart';
import 'package:lorrystand/widgets/TruckTypeModal.dart';
import 'package:lorrystand/widgets/menu.dart';
import 'package:provider/provider.dart';

const kGoogleApiKey = "AIzaSyCTaQ4nG2nQeFg4vomFvGyQLNH9ol83icE";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

bool typing = false;

class CreateBookingPage extends StatefulWidget {
  CreateBookingPage({Key key}) : super(key: key);

  @override
  _CreateBookingPageState createState() => _CreateBookingPageState();
}
GlobalKey<ScaffoldState> scaffoldKey ;
GlobalKey<ScaffoldState> _scaffoldKey ;


class _CreateBookingPageState extends State<CreateBookingPage>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    super.initState();

    setState(() {
      form['scheduled_date'] = selectedDate;
    });

  }
  void dispose() {
    // Never called
    print("Disposing first route");
    super.dispose();
  }

  final format = DateFormat("yyyy-MM-dd HH:mm");

  DateTime selectedDate = DateTime.now();

  var form = {};

  @override
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: form['scheduled_date'],
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
    if (picked != null && picked != form['scheduled_date'])
      setState(() {
        form['scheduled_date'] = picked;
      });
  }

  Widget _selectMaterialType(BuildContext context, userProvider) {
    return MaterialTypeModal(onSelectedChanged: (id) {
      setState(() {
        form['material_type'] = id;
        form['material_type_id'] =
        userProvider.materialTypes[form['material_type']]['id'];
      });
      Navigator.of(context).pop();
    });
  }

  Widget _selectTruckType(BuildContext context, userProvider) {
    return TruckTypeModal(onSelectedChanged: (id) {
      setState(() {
        form['truck_type'] = id;
        form['truck_type_id'] = userProvider.truckTypes[id]['id'];
      });
      Navigator.of(context).pop();
    });
  }

  Widget _selectTruckCapacity(BuildContext context, userProvider) {
    // if (form['truck_type'] != null) {
    return TruckCapacityModal(
        truckType: form['truck_type_id'],
        onSelectedChanged: (trucktypeid) {
          setState(() {
            form['truck_capacity'] = trucktypeid;
            form['truck_capacity_id'] =
            userProvider.truckTypes[form['truck_type']]['capacities']
            [form['truck_capacity']]['id'];
          });
          Navigator.of(context).pop();
        });
    //}
  }

  Widget _selectTruckSize(BuildContext context, userProvider) {
    if (form['truck_capacity'] != null) {
      return TruckSizeModal(
          truckTypeIndex: form['truck_type_id'],
          capacityIndex: form['truck_capacity_id'],
          onSelectedChanged: (trucktypeid) {
            setState(() {
              form['truck_size'] = trucktypeid;
              form['truck_size_id'] =
              userProvider.truckTypes[form['truck_type']]['capacities']
              [form['truck_capacity']]['sizes']
              [form['truck_size']]['id'];
            });
            Navigator.of(context).pop();
          });
    }
  }

  void _placeSearch(BuildContext context) {
    //Navigator.of(context).push(TutorialOverlay());
    Navigator.of(context).pushNamed("/search");
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            PlaceAutocomplete(onSelectedPlace: (location) {
              var _location = location;
              print(_location);
              Navigator.of(context).pop();
            })));
  }

  void onError(PlacesAutocompleteResponse response) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _sourceLocation() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.fullscreen,
      language: "en",
      components: [Component(Component.country, "in")],
    );

    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      //final location =  detail;
      setState(() {
        form['source_address'] = p.description;
        form['source_city'] = detail.result.vicinity;
        form['source_latitude'] = detail.result.geometry.location.lat;
        form['source_longitude'] = detail.result.geometry.location.lng;
      });
    }
  }

  _resetSource() {
    // form['source_address'] = null;
    // form['source_city'] = null;
    // form['source_latitude'] = null;
    // form['source_longitude'] = null;
  }

  _resetDestination() {
    // form['destination_address'] = null;
    // form['destination_city'] = null;
    // form['destination_latitude'] = null;
    // form['destination_longitude'] = null;
  }

  Future<void> _destinationLocation() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.fullscreen,
      language: "en",
      components: [Component(Component.country, "in")],
    );

    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);
      setState(() {
        form['destination_address'] = p.description;
        form['destination_city'] = detail.result.vicinity;
        form['destination_latitude'] = detail.result.geometry.location.lat;
        form['destination_longitude'] = detail.result.geometry.location.lng;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    var userProvider = Provider.of<UserProvider>(context);
    var bookingProvider = Provider.of<BookingProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[200],
      drawer: MenuDrawer(),
      appBar: new AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 68.0),
          child: new Text("Lorrystand"),
        ),
        backgroundColor: Color(0xFF232937),
        elevation: 0.7,
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Container(
            child: ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: size.height,
                color: Color(0xFF212838),
              ),
            ),
          ),
          SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  onPressed: () {
                    null;
                  },
                  color: Colors.amber,
                  textColor: Colors.white,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 3.5,
                    child: Text(
                      "Need a Truck ?",
                      style: TextStyle(
                        fontSize: size.width / 25,
                        color: Color(0xFF232937),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: size.height / 1.3,
                  width: size.width / 1.1,
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 22.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0.0),
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => _sourceLocation(),
                                      child: Text(
                                        form['source_address'] == null
                                            ? "From"
                                            : "${form['source_address']}",
                                        overflow: TextOverflow.fade,
                                        style: form['source_address'] == null
                                            ? TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white)
                                            : new TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.0,
                                    child: GestureDetector(
                                        onTap: _resetSource(),
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xFF212838),
                                        )),
                                  )
                                ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => _destinationLocation(),
                                      child: Text(
                                        form['destination_address'] == null
                                            ? "To"
                                            : "${form['destination_address']}",
                                        overflow: TextOverflow.fade,
                                        style:
                                        form['destination_address'] == null
                                            ? TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white)
                                            : new TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                    child: GestureDetector(
                                        onTap: _resetDestination(),
                                        child: Icon(Icons.arrow_drop_down,
                                            color: Color(0xFF212838))),
                                  )
                                ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: Container(
                          color: Colors.white.withOpacity(0.1),
                          child: TextField(
                            //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
                            style: new TextStyle(color: Colors.white),
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onChanged: (input) {
                              setState(() {
                                form['enquiry_weight'] = input;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Weight in Tons',
                              hintStyle: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return _selectTruckType(
                                      context, userProvider);
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 16.0),
                            height: 58.0,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    form['truck_type'] == null
                                        ? "Vehicle Type"
                                        : "${userProvider
                                        .truckTypes[form['truck_type']]['name']}",
                                    overflow: TextOverflow.fade,
                                    style: form['truck_type_id'] == null
                                        ? TextStyle(
                                        fontSize: 14.0, color: Colors.white)
                                        : new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white),
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: 25.0,
                                  child: GestureDetector(
                                      onTap: _resetSource(),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xFF212838),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return _selectTruckCapacity(
                                      context, userProvider);
                                });
                          },
                          child: Container(
                            height: 58.0,
                            padding: EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    form['truck_capacity'] == null
                                        ? "Select Truck Capacity"
                                        : "${userProvider
                                        .truckTypes[form['truck_type']]['capacities'][form['truck_capacity']]['name']}",
                                    overflow: TextOverflow.fade,
                                    style: form['truck_capacity_id'] == null
                                        ? TextStyle(
                                        fontSize: 14.0, color: Colors.white)
                                        : new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white),
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: 25.0,
                                  child: GestureDetector(
                                      onTap: _resetSource(),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xFF212838),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return _selectTruckSize(
                                      context, userProvider);
                                });
                          },
                          child: Container(
                            height: 58.0,
                            padding: EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    form['truck_size'] == null
                                        ? "Select Truck Size"
                                        : "${userProvider
                                        .truckTypes[form['truck_type']]['capacities'][form['truck_capacity']]['sizes'][form['truck_size']]['name']}",
                                    overflow: TextOverflow.fade,
                                    style: form['truck_size_id'] == null
                                        ? TextStyle(
                                        fontSize: 14.0, color: Colors.white)
                                        : new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white),
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: 25.0,
                                  child: GestureDetector(
                                      onTap: _resetSource(),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        color: Color(0xFF212838),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return _selectMaterialType(
                                      context, userProvider);
                                });
                          }, child: Container(
                          height: 58.0,
                          padding: EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  form['material_type'] == null
                                      ? "Body Type"
                                      : "${userProvider
                                      .materialTypes[form['material_type']]['name']}",
                                  overflow: TextOverflow.fade,
                                  style: form['material_type_id'] == null
                                      ? TextStyle(
                                      fontSize: 14.0, color: Colors.white)
                                      : new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white),
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: 25.0,
                                child: GestureDetector(
                                    onTap: _resetSource(),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xFF212838),
                                    )),
                              )
                            ],
                          ),
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: Container(
                          color: Colors.white.withOpacity(0.1),
                          child: TextField(
                            //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
                            style: new TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            onChanged: (input) {
                              setState(() {
                                form['enquiry_amount'] = input;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Budget',
                              hintStyle: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: Container(
                          color: Colors.white.withOpacity(0.1),
                          child: DateTimeField(
                            format: format,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Schedule Date',
                              hintStyle: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            onShowPicker: (context, currentValue) async {
                              final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                if (date != null && date != form['scheduled_date'])
                                  setState(() {
                                    form['scheduled_date'] = date;
                                  });
                                return DateTimeField.combine(date, time);
                              } else {
                                return currentValue;
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: Container(
                          color: Colors.white.withOpacity(0.1),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            autofocus: false,
                            onChanged: (input) {
                              setState(() {
                                form['contact_name'] = input;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Contact Person',
                              hintStyle: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: Container(
                          color: Color(0xff434c54).withOpacity(0.6),
                          child: TextField(
                            //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
                            style: new TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            onChanged: (input) {
                              setState(() {
                                form['contact_number'] = input;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Contact Number',
                              hintStyle: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          onPressed: () =>
                              create(bookingProvider, userProvider),
                          color: Colors.amber,
                          textColor: Colors.white,
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.9,
                            height: size.height / 18,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Create Booking",
                                  style: TextStyle(
                                      fontSize: size.width / 20,
                                      color: Color(0xFF232937),
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                                Icon(
                                  Icons.collections_bookmark,
                                  color: Color(0xFF232937),
                                  size: size.width / 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      /*TabBarView(
        controller: _tabController,
        children: <Widget>[
          EnquiriesWidget(),
          BookingsWidget(),
        ],
      ),*/
    );
  }

  void create(bookingProvider, userProvider) async {
    print(form);
    setState(() {
      //_isLoading = false;
    });

    if (form['source_address'] == null)
      showToasts("Please enter source adddress.");
    else if (form['destination_address'] == null)
      showToasts("Please enter destination adddress.");
    else if (form['truck_size_id'] == null)
      showToasts("Please enter Truck Size.");
    else if (form['material_type_id'] == null)
      showToasts("Please enter material Type.");
    else if (form['enquiry_weight'] == null)
      showToasts("Please enter enquiry weight.");
    else if (form['enquiry_amount'] == null)
      showToasts("Please enter enquiry amount.");
    else {
      var response = await bookingProvider.create(form);
      print(response);
      if (response['status'] == true)
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>EnquiriesWidgetCustomer()));
    }

  }

  void showToasts(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
