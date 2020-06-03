import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';

class TruckTypeModal extends StatefulWidget {
  TruckTypeModal({
    this.onSelectedChanged,
  });

  final ValueChanged<int> onSelectedChanged;

  @override
  _TruckTypeModalState createState() => _TruckTypeModalState();
}

class _TruckTypeModalState extends State<TruckTypeModal> {
  int truckType;

  @override
  void initState() {
    //_tempSelectedCities = widget.selectedCities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Select Truck Type")),
      body: ListView.builder(
                itemCount: userProvider.truckTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: RadioListTile(
                        title: Text("${userProvider.truckTypes[index]['name']}"),
                        value: index,
                        groupValue: 'truckType',
                        onChanged: (value) {
                         setState(() {
                                truckType = value;
                              });
                          widget.onSelectedChanged(value);
                        }),
                  );
                })
    );
  }
}