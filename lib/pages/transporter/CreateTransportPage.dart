import 'package:flutter/material.dart';
import 'package:lorrystand/providers/user_provider.dart'; 
import 'package:provider/provider.dart';
import 'package:lorrystand/config/app_config.dart' as config;
import 'package:lorrystand/widgets/CityModal.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/providers/transport_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateTransportPage  extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateTransportPage();
}

class _CreateTransportPage extends State<CreateTransportPage> {  

  var form = {};

  void _selectCity(BuildContext context , userProvider){
      Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) =>
                CityModal(
                  onSelectedChanged: (cityId) {
                    setState(() {
                      form['city_index'] = cityId;
                      form['city_id'] = userProvider.cities[form['city_index']]['id'];
                    });                            
                    Navigator.of(context).pop();
                  })
            ));
  }
 
  @override
  Widget build(BuildContext context) {
     var transport = Provider.of<TransportProvider>(context);
     var userProvider = Provider.of<UserProvider>(context);

    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent[700],
          title: Text("Create Transport Company" , style: TextStyle(color: Colors.white)),
          elevation: 0.0,
          leading: new InkWell(
            borderRadius: BorderRadius.circular(30.0),
            child: new Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/Home');
            },
          ),
          centerTitle: true,
        ),
        body: new SafeArea(
          top: false,
          bottom: false,
          child:  Padding(
          padding: EdgeInsets.only(top: 25.0, left: 10.0, bottom: 25.0, right: 10.0),
          child: ListView(children: <Widget>[
             Text("Transporter Name" , style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,)),
            SizedBox(height: 10.0,),
              TextField(
              //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
              //onTap: () =>  _showOverlay,
              style: new TextStyle(color: Colors.grey[900]),
              onChanged: (input) {
                setState(() {
                  form['transport_name'] = input;
                });
              },
              decoration: InputDecoration(
                hintText: 'Transporter Name',
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
             SizedBox(
              height: 10.0,
            ),
            Text(
              "Contact Person",
              style: new TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
              style: new TextStyle(color: Colors.grey[900]),
              keyboardType: TextInputType.text,
              onChanged: (input) {
                setState(() {
                  form['contact_name'] = input;
                });
              },
              decoration: InputDecoration(
                hintText: 'Contact Name',
                hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
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
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Email",
              style: new TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
              style: new TextStyle(color: Colors.grey[900]),
              keyboardType: TextInputType.text,
              onChanged: (input) {
                setState(() {
                  form['email'] = input;
                });
              },
              decoration: InputDecoration(
                hintText: 'Email Address',
                hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
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
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Mobile",
              style: new TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
              style: new TextStyle(color: Colors.grey[900]),
              keyboardType: TextInputType.number,
              onChanged: (input) {
                setState(() {
                  form['mobile'] = input;
                });
              },
              decoration: InputDecoration(
                hintText: 'Contact Mobile',
                hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
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
            SizedBox(
              height: 10.0,
            ),
            SizedBox(height: 10.0,),
            Text("City" , style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,)),
            SizedBox(height: 10.0,),
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
            SizedBox(height: 30.0,),
            SizedBox(
              width: double.infinity,
              height: 30.0,
              child: RaisedButton(
                child: Text("Create Transport") , 
                onPressed: () => create(transport),
                color: Colors.orangeAccent,
              )
            )
          ],),
          )
        ),
    
      ),
    );
  }

   void create(TransportProvider transport) async {
      print(form);
      setState(() {
        //_isLoading = false;
        form['description'] = "hbhbhhh";
      });

      if(form['transport_name']  == null)
        showToasts("Please enter transport name.");
      else if(form['city_id']  == null)
        showToasts("Please enter city.");
      else if(form['contact_name']  == null)
        showToasts("Please enter contact name.");
      else if(form['email']  == null)
        showToasts("Please enter email.");
      else if(form['mobile']  == null)
        showToasts("Please enter mobile number.");
      else{
       var response = await transport.create(form);
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