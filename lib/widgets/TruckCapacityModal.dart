import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';

class TruckCapacityModal extends StatefulWidget {
  TruckCapacityModal({
    this.truckType,
    this.onSelectedChanged,
  });

  final ValueChanged<int> onSelectedChanged;
  final int truckType;

  @override
  _TruckCapacityModalState createState() => _TruckCapacityModalState();
}

class _TruckCapacityModalState extends State<TruckCapacityModal> {
  int truckCapacityId;
  var capacities = [];

  @override
  void initState() {
    //_tempSelectedCities = widget.selectedCities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserProvider>(context);

    capacities = userProvider.truckTypes[widget.truckType]['capacities'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Select Truck Type")),
      body: ListView.builder(
                itemCount: capacities.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: RadioListTile(
                        title: Text("${capacities[index]['name']}"),
                        value: index,
                        groupValue: 'truckCapacityId',
                        onChanged: (value) {
                         setState(() {
                                truckCapacityId = value;
                              });
                          widget.onSelectedChanged(value);
                        }),
                  );
                })
    );
  }
}