import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';

class MaterialTypeModal extends StatefulWidget {
  MaterialTypeModal({
    this.onSelectedChanged,
  });

  final ValueChanged<int> onSelectedChanged;

  @override
  _MaterialTypeModalState createState() => _MaterialTypeModalState();
}

class _MaterialTypeModalState extends State<MaterialTypeModal> {
  int materialTypeId;

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
                itemCount: userProvider.materialTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: RadioListTile(
                        title: Text("${userProvider.materialTypes[index]['name']}"),
                        value: index,
                        groupValue: "materialTypeId",
                        onChanged: (value) {
                         setState(() {
                                materialTypeId = value;
                              });
                          widget.onSelectedChanged(materialTypeId);
                        }),
                  );
                })
    );
  }
}