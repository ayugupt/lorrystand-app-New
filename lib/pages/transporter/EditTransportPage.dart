import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/booking_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';   
import 'package:flutter_form_builder/flutter_form_builder.dart';

class EditPage extends StatefulWidget {
  EditPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

 // final String title;

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> with TickerProviderStateMixin {

  var data;    
  bool autoValidate = true;    
  bool readOnly = false;    
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>(); 
  

   @override    
 Widget build(BuildContext context) {    
   return Scaffold(    
     appBar: AppBar(    
       title: Text("Flutter Form Validation"),    
     ),    
     body: Padding(    
       padding: EdgeInsets.all(10),    
       child: SingleChildScrollView(    
         child: Column(    
           children: <Widget>[    
             FormBuilder(    
               key: _fbKey,    
               initialValue: {    
                 'date': DateTime.now(),    
                 'accept_terms': false,    
               },    
               autovalidate: true,    
               child: Column(    
                 children: <Widget>[    
                   FormBuilderTextField(    
                     attribute: 'text',    
                     validators: [FormBuilderValidators.required()],    
                     decoration: InputDecoration(labelText: "Full Name"),    
                   ),    
                   FormBuilderDateTimePicker(    
                     attribute: "date",    
                     inputType: InputType.date,    
                     validators: [FormBuilderValidators.required()],    
                     format: DateFormat("dd-MM-yyyy"),    
                     decoration: InputDecoration(labelText: "Date of Birth"),    
                   ),    
                   FormBuilderDropdown(    
                     attribute: "gender",    
                     decoration: InputDecoration(labelText: "Gender"),    
                     // initialValue: 'Male',    
                     hint: Text('Select Gender'),    
                     validators: [FormBuilderValidators.required()],    
                     items: ['Male', 'Female', 'Other']    
                         .map((gender) => DropdownMenuItem(    
                             value: gender, child: Text("$gender")))    
                         .toList(),    
                   ),    
                   FormBuilderTextField(    
                     attribute: "age",    
                     decoration: InputDecoration(labelText: "Age"),    
                     keyboardType: TextInputType.number,    
                     validators: [    
                       FormBuilderValidators.numeric(),    
                       FormBuilderValidators.max(70),    
                     ],    
                   ),    
                   FormBuilderSlider(    
                     attribute: "slider",    
                     validators: [FormBuilderValidators.min(6)],    
                     min: 0.0,    
                     max: 10.0,    
                     initialValue: 1.0,    
                     divisions: 20,    
                     decoration: InputDecoration(    
                         labelText: "Number of Family Members"),    
                   ),    
                   FormBuilderSegmentedControl(    
                     decoration: InputDecoration(labelText: "Rating"),    
                     attribute: "movie_rating",    
                     options: List.generate(5, (i) => i + 1)    
                         .map(    
                             (number) => FormBuilderFieldOption(value: number))    
                         .toList(),    
                   ),    
                   FormBuilderStepper(    
                     decoration: InputDecoration(labelText: "Stepper"),    
                     attribute: "stepper",    
                     initialValue: 10,    
                     step: 1,    
                   ),    
                   FormBuilderCheckboxList(    
                     decoration:    
                         InputDecoration(labelText: "Languages you know"),    
                     attribute: "languages",    
                     initialValue: ["English"],    
                     options: [    
                       FormBuilderFieldOption(value: "English"),    
                       FormBuilderFieldOption(value: "Hindi"),    
                       FormBuilderFieldOption(value: "Other")    
                     ],    
                   ),    
                   FormBuilderSignaturePad(    
                     decoration: InputDecoration(labelText: "Signature"),    
                     attribute: "signature",    
                     height: 100,    
                   ),    
                   FormBuilderRate(    
                     decoration: InputDecoration(labelText: "Rate this site"),    
                     attribute: "rate",    
                     iconSize: 32.0,    
                     initialValue: 1,    
                     max: 5,    
                   ),    
                   FormBuilderCheckbox(    
                     attribute: 'accept_terms',    
                     label: Text(    
                         "I have read and agree to the terms and conditions"),    
                     validators: [    
                       FormBuilderValidators.requiredTrue(    
                         errorText:    
                             "You must accept terms and conditions to continue",    
                       ),    
                     ],    
                   ),    
                 ],    
               ),    
             ),
             buildInputWidget("fsadfsdfsdf",
                  "Enter your destination", () {}),
              SizedBox(
                height: 36.0,
              ),    
             Row(    
               children: <Widget>[    
                 MaterialButton(    
                   child: Text("Submit"),    
                   onPressed: () {    
                     _fbKey.currentState.save();    
                     if (_fbKey.currentState.validate()) {    
                       print(_fbKey.currentState.value);    
                     }    
                   },    
                 ),    
                 MaterialButton(    
                   child: Text("Reset"),    
                   onPressed: () {    
                     _fbKey.currentState.reset();    
                   },    
                 ),    
               ],    
             )    
           ],    
         ),    
       ),    
     ),    
   );    
 } 

  Widget buildInputWidget(String text, String hint, Function() onTap) {
    return Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[ 
            Text("sadasdas"),
           Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      decoration: BoxDecoration(
        color: Color(0xffeeeeee).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child:  TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter a search term'
              ),
            )
    )
          ]
      );
  }     
}
