import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/truck_provider.dart';
import 'package:lorrystand/widgets/menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:image_picker/image_picker.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:lorrystand/services/headers.dart';

class TruckPage extends StatefulWidget {
  final int id;

  TruckPage({Key key , this.id}) : super(key: key);

  @override
  _TruckPageState createState() => _TruckPageState();
}

class _TruckPageState extends State<TruckPage> with TickerProviderStateMixin {
 
  File _imageFile;
  bool _isUploading = false;
  String baseUrl = 'http://maxxfresh.tihalt.in/api/upload/profile-image';

  void getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = image;
    });
    if(_imageFile != null){
      _startUploading();
    }
    // Closes the bottom sheet
    Navigator.pop(context);
  }

  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Camera'),
                  onPressed: () {
                    getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _startUploading() async {
    // final Map<String, dynamic> response = await _uploadImage(_imageFile);
    // print(response);
    // var data = await model.getProfile();
  }

  void _resetState() {
    setState(() {
      _isUploading = false;
      _imageFile = null;
    });
  }


  @override
  Widget build(BuildContext context){
    var truckProvider = Provider.of<TruckProvider>(context);
    truckProvider.fetch(widget.id);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            // SizedBox(
            //   height: 250,
            //   width: double.infinity,
            //   child: Container(color: Colors.lightGreen,)//PNetworkImage(image, fit: BoxFit.cover,),
            // ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, kToolbarHeight + 40, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                       // margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 96.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${truckProvider.truck['vehicle_number']}", style: Theme.of(context).textTheme.headline6,),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text("${truckProvider.truck['manufacturer_name']}"),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            // Row(
                            //   children: <Widget>[
                            //     Expanded(child: Column(
                            //       children: <Widget>[
                            //         Text("285"),
                            //         Text("Likes")
                            //       ],
                            //     ),),
                            //     Expanded(child: Column(
                            //       children: <Widget>[
                            //         Text("3025"),
                            //         Text("Comments")
                            //       ],
                            //     ),),
                            //     Expanded(child: Column(
                            //       children: <Widget>[
                            //         Text("650"),
                            //         Text("Favourites")
                            //       ],
                            //     ),),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage("https://via.placeholder.com/150"),
                            fit: BoxFit.cover
                          )
                        ),
                        margin: EdgeInsets.only(left: 16.0 , top: 10.0),
                        ),
                    ],
                  ),
                  SizedBox(height: 20.0),                  
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(title: Text("User information"),),
                        Divider(),
                        ListTile(
                          title: Text("Email"),
                          subtitle: Text("${truckProvider.truck['vehicle_number']}"),
                          //leading: Icon(Icons.email),
                        ),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text("${truckProvider.truck['model']}"),
                          //leading: Icon(Icons.phone),
                        ),
                      ],
                    ),
                  )
                  
                ],
              ),
            ),
            AppBar(
              //backgroundColor: Colors.green,
              title: Text('Truck Details'),
              elevation: 0,
            )
          ],
        ),
      ),
    );
  }
}