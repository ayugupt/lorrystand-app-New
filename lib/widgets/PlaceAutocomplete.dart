import 'dart:async';

import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'dart:math';

const kGoogleApiKey = "AIzaSyCTaQ4nG2nQeFg4vomFvGyQLNH9ol83icE";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

//typedef PlaceCallback = void Function(dynamic location);

class PlaceAutocomplete extends PlacesAutocompleteWidget {
  PlaceAutocomplete({
   @required this.onSelectedPlace,
  }) : super(
          apiKey: kGoogleApiKey,
          sessionToken: Uuid().generateV4(),
          language: "en",
          components: [Component(Component.country, "in")],          
        );

  final Function(dynamic) onSelectedPlace;

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  List<String> _tempSelectedCities = [];
  final Function(dynamic) onSelectedPlace;
  _CustomSearchScaffoldState({
   this.onSelectedPlace,
  });


  final searchScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    //_tempSelectedCities = this.cities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) async {
        var location = {};
        if (p != null) {
          // get detail (lat/lng)
          
          PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
          location['lat'] = detail.result.geometry.location.lat;
          location['lng'] = detail.result.geometry.location.lng;
        }
        this.onSelectedPlace(location);
      },
      logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    // searchScaffoldKey.currentState.showSnackBar(
    //   SnackBar(content: Text(response.errorMessage)),
    // );
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      // searchScaffoldKey.currentState.showSnackBar(
      //   SnackBar(content: Text("Got answer")),
      // );
    }
  }
}

Future<Map<dynamic,dynamic>> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    // get detail (lat/lng)
    var location = {};
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    location['lat'] = detail.result.geometry.location.lat;
    location['lng'] = detail.result.geometry.location.lng;
    
    // scaffold.showSnackBar(
    //   SnackBar(content: Text("${p.description} - $location")),
    // );
    return location;
  }
  return null;
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}