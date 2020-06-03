import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';

class TruckSizeModal extends StatefulWidget {
  TruckSizeModal({
    this.truckTypeIndex,
    this.capacityIndex,
    this.onSelectedChanged,
  });

  final ValueChanged<int> onSelectedChanged;
  final int truckTypeIndex;
  final int capacityIndex;

  @override
  _TruckSizeModalState createState() => _TruckSizeModalState();
}

class _TruckSizeModalState extends State<TruckSizeModal> {
  int truckSizeId;
  var truckSizes = [];

  @override
  void initState() {
    //_tempSelectedCities = widget.selectedCities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserProvider>(context);
    print(widget.truckTypeIndex);
    print(widget.capacityIndex);
    var sizes = userProvider.truckTypes[widget.truckTypeIndex]['capacities'][widget.capacityIndex]['sizes'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Select Truck Type")),
      body: ListView.builder(
                itemCount: sizes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: RadioListTile(
                        title: Text("${sizes[index]['name']}"),
                        value: index,
                        groupValue: 'truckSizeId',
                        onChanged: (value) {
                         setState(() {
                                truckSizeId = value;
                              });
                          widget.onSelectedChanged(value);
                        }),
                  );
                })
    );
  }
}