import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';

class CityModal extends StatefulWidget {
  CityModal({
    this.onSelectedChanged,
  });

  final ValueChanged<int> onSelectedChanged;

  @override
  _CityModalState createState() => _CityModalState();
}

class _CityModalState extends State<CityModal> {
  int cityId;

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
      appBar: AppBar(title: Text("Select City")),
      body: ListView.builder(
                itemCount: userProvider.cities.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: RadioListTile(
                        title: Text("${userProvider.cities[index]['name']}"),
                        value: index,
                        groupValue: 'city_id',
                        onChanged: (value) {
                         setState(() {
                                cityId = value;
                              });
                          widget.onSelectedChanged(value);
                        }),
                  );
                })
    );
  }
}