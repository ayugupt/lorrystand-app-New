import 'package:flutter/material.dart';

import 'package:lorrystand/config/app_config.dart' as config;
import 'package:lorrystand/languages/i18n.dart';
import 'package:lorrystand/widgets/BlockButtonWidget.dart';
import 'package:lorrystand/widgets/TruckTypeModal.dart';
import 'package:lorrystand/widgets/TruckCapacityModal.dart';
import 'package:lorrystand/widgets/MaterialTypeModal.dart';
import 'package:lorrystand/widgets/CityModal.dart';
import 'package:lorrystand/widgets/TruckSizeModal.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/providers/truck_provider.dart';
import 'package:fluttertoast/fluttertoast.dart'; 

class CreateTruckPage extends StatefulWidget {
  @override
  _CreateTruckWidgetState createState() => _CreateTruckWidgetState();
}

class _CreateTruckWidgetState extends State<CreateTruckPage> {
   var form = {};
   @override
  void initState() {
    super.initState();
    // if (userRepo.currentUser?.apiToken != null) {
    //   Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    // }
  }

 void _selectTruckType(BuildContext context , userProvider) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            TruckTypeModal(onSelectedChanged: (id) {
              setState(() {
                form['truck_type'] = id;
                 form['truck_type_id'] = userProvider.truckTypes[id]['id'];
              });
              Navigator.of(context).pop();
            })));
  }

  void _selectTruckCapacity(BuildContext context, userProvider) {
    if(form['truck_type'] != null){
       Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => TruckCapacityModal(
            truckType: form['truck_type_id'],
            onSelectedChanged: (trucktypeid) {
              setState(() {
                form['truck_capacity'] = trucktypeid;
                form['truck_capacity_id'] = userProvider.truckTypes[form['truck_type']]['capacities'][form['truck_capacity']]['id'];
              });
              Navigator.of(context).pop();
            })));

    }   
  }

  void _selectTruckSize(BuildContext context , userProvider) {
    if(form['truck_capacity'] != null){
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) => TruckSizeModal(
              truckTypeIndex: form['truck_type_id'],
              capacityIndex: form['truck_capacity_id'],
              onSelectedChanged: (trucktypeid) {
                setState(() {
                  form['truck_size'] = trucktypeid;
                  form['truck_size_id'] = userProvider.truckTypes[form['truck_type']]['capacities'][form['truck_capacity']]['sizes'][form['truck_size']]['id'];
                });
                Navigator.of(context).pop();
              })));
     }
  }

 
  void _selectCity(BuildContext context , userProvider){
      Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) =>
                CityModal(
                              onSelectedChanged: (cityId) {
                                setState(() {
                                  form['city_index'] = cityId;
                                  form['city_id'] = userProvider.cities[cityId]['id'];
                                });                            
                                Navigator.of(context).pop();
                              })
            ));
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var truckProvider = Provider.of<TruckProvider>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: Text("Create Truck")),
        body: Padding(
          padding: EdgeInsets.only(top: 25.0, left: 10.0, bottom: 25.0, right: 10.0),
          child: ListView(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("Manufacturer Name" , style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,)),
            SizedBox(height: 10.0,),
              TextField(
              //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
              //onTap: () =>  _showOverlay,
              style: new TextStyle(color: Colors.grey[900]),
              onChanged: (input) {
                setState(() {
                  form['manufacturer_name'] = input;
                });
              },
              decoration: InputDecoration(
                hintText: 'Manufacturer Name',
                hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                filled: true,
                fillColor: Color(0xffeeeeee).withOpacity(0.5),
                //enabled: false, 
                // prefixIcon: Icon(
                //   Icons.account_box,
                //   size: 28.0,
                // ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 0, 
                        style: BorderStyle.none,
                    ),
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Text("Truck Model" , style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,)),
            SizedBox(height: 10.0,),
            TextField(
              //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
              style: new TextStyle(color: Colors.grey[900]),
              onChanged: (input) {
                setState(() {
                  form['model'] = input;
                });
              },
              decoration: InputDecoration(
                hintText: 'Truck Model',
                hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                filled: true,
                fillColor: Color(0xffeeeeee).withOpacity(0.5),
                //enabled: false, 
                // prefixIcon: Icon(
                //   Icons.account_box,
                //   size: 28.0,
                // ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 0, 
                        style: BorderStyle.none,
                    ),
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Text("Vehicle Number" , style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,)),
            SizedBox(height: 10.0,),
            TextField(
              //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
              style: new TextStyle(color: Colors.grey[900]),
              onChanged: (input) {
                setState(() {
                  form['vehicle_number'] = input;
                });
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Vehicle Number',
                hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                filled: true,
                fillColor: Color(0xffeeeeee).withOpacity(0.5),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 0, 
                        style: BorderStyle.none,
                    ),
                ),               
              ),
            ),
            SizedBox(height: 10.0,),
              Text("Truck Type",
                style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,)),
            SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              onTap: () => _selectTruckType(context, userProvider),
              child:  Container(
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Color(0xffeeeeee).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                        form['truck_type'] == null ? "Select your Source Address" : "${userProvider.truckTypes[form['truck_type']]['name']}",
                        overflow: TextOverflow.fade,
                        style: form['truck_type_id'] == null ?  TextStyle(fontSize: 14.0, color: Colors.grey)
                        : new TextStyle(fontSize: 14.0, color: Colors.grey[900]),
                        maxLines: 1,
                      ),
                ),
            ),
             SizedBox(height: 10.0,),
              Text("Truck Capacity",
               style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,)),
            SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              onTap: () => _selectTruckCapacity(context, userProvider),
              child:  Container(
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Color(0xffeeeeee).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                        form['truck_capacity'] == null ? "Select Truck Capacity" : "${userProvider.truckTypes[form['truck_type']]['capacities'][form['truck_capacity']]['name']}",
                        overflow: TextOverflow.fade,
                        style: form['truck_capacity'] == null ?  TextStyle(fontSize: 14.0, color: Colors.grey)
                        : new TextStyle(fontSize: 14.0, color: Colors.grey[900]),
                        maxLines: 1,
                      ),
                ),
            ),            
             SizedBox(height: 10.0,),
              Text("Truck Size",
               style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,)),
            SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              onTap: () => _selectTruckSize(context, userProvider),
              child:  Container(
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Color(0xffeeeeee).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                        form['truck_size'] == null ? "Select Truck Size" : "${userProvider.truckTypes[form['truck_type']]['capacities'][form['truck_capacity']]['sizes'][form['truck_size']]['name']}",
                        overflow: TextOverflow.fade,
                        style: form['truck_size'] == null ?  TextStyle(fontSize: 14.0, color: Colors.grey)
                        :new TextStyle(fontSize: 14.0, color: Colors.grey[900]),
                        maxLines: 1,
                      ),
                ),
            ),
             SizedBox(height: 10.0,),
              Text("Select City",
               style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,)),
            SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              onTap: () => _selectCity(context , userProvider),
              child:  Container(
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Color(0xffeeeeee).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                        form['city_index'] == null ? "Select City" : "${userProvider.cities[form['city_index']]['name']}",
                        overflow: TextOverflow.fade,
                        style: form['city_index'] == null ? TextStyle(fontSize: 14.0, color: Colors.grey)
                        : new TextStyle(fontSize: 14.0, color: Colors.grey[900]),
                        maxLines: 1,
                      ),
                ),
            ),
            SizedBox(height: 20.0,),
            BlockButtonWidget(
                        text: Text(
                          'Create Truck',
                          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                        ),
                        color: Colors.green,
                        onPressed: ()  {
                          create(truckProvider, userProvider);
                          //print(this.user);
                          //var response = userProvider.loggedInUser(user);
                          //print(response);
                        },
                      ),
                      SizedBox(height: 25),
            ],
        ),
        )


    
      )
    );
  }

  void create(TruckProvider truckProvider , userProvider) async {

      setState(() {
        //_isLoading = false;
        form['is_national_permit']  = 0;
      });

            print(form);

      if(form['manufacturer_name']  == null)
        showToasts("Please enter Manufacturer name.");
      else if(form['model']  == null)
        showToasts("Please enter truck model.");
      else if(form['truck_size_id']  == null)
        showToasts("Please enter Truck Size.");     
      else if(form['city_id']  == null)
        showToasts("Please enter city.");
      else if(form['vehicle_number']  == null)
        showToasts("Please enter vehicle number.");
      else{
        // var data = form;

        // setState(() {
        //   data['truck_size_id'] = userProvider.truckTypes[form['truck_type_id']]['capacities'][form['truck_capacity_id']]['sizes'][form['truck_size_id']]['id'];
        //   print( data['truck_size_id']);
        //   data['truck_capacity_id'] = userProvider.truckTypes[form['truck_type_id']]['capacities'][form['truck_capacity_id']]['id'];
        //   print( data['truck_capacity_id']);
        //   data['truck_type_id'] = userProvider.truckTypes[form['truck_type_id']]['id'];
        //    print( data['truck_type_id']);
        //   data['material_type_id'] = userProvider.materialTypes[form['material_type_id']]['id'];
        //    print( data['material_type_id']);
        // });

       var response = await truckProvider.create(form);
       print(response);
       if(response['status'] == true)
         Navigator.of(context).pushReplacementNamed('/Home');
      }
      
      // if (loginFormKey.currentState.validate()) {
      

      //   if(response != null){
      //     Navigator.of(context).pushReplacementNamed('/Home');
      //   }
      
      // }
  }

  void showToasts(message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  
}