import 'package:flutter/material.dart';

import 'package:lorrystand/widgets/AttachTruckWidget.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/truck_provider.dart';

class TrucksPage extends StatefulWidget {
  TrucksPage({Key key}) : super(key: key);

  @override
  _TrucksPageState createState() => _TrucksPageState();
}

class _TrucksPageState extends State<TrucksPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var truckProvider = Provider.of<TruckProvider>(context);

    //truckProvider.list();

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: TextBox(),
        //backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.green),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: ListView.builder(
          itemCount: truckProvider.trucks.length,
          itemBuilder: (context, i) => 
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Card(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://via.placeholder.com/150"),
                          fit: BoxFit.cover)),
                  margin: EdgeInsets.only(left: 16.0, top: 10.0),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    // margin: EdgeInsets.only(top: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${truckProvider.trucks[i]['vehicle_number']}",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                              "${truckProvider.trucks[i]['manufacturer_name']}"),
                          subtitle: Text("${truckProvider.trucks[i]['model']}"),
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  truckProvider.unattachedTrucks(truckProvider.trucks[i]['id'] , i);
                                },
                                color: Colors.redAccent[400],
                                // padding: EdgeInsets.all(10.0),
                                child: Row(
                                  // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    // Icon(Icons.add),
                                    Text(
                                      "Unattach",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ])
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.greenAccent[700],
          child: new Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AttachTruckWidget()),
            );
          }),
    );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              //decoration:InputDecoration(border: InputBorder.none, hintText: 'Search')
              style: new TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search Trucks',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white60),
                filled: true,
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
                suffixIcon: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      debugPrint('222');
                    }),
              ),
            ),
          ),
          // SizedBox(
          //   child: IconButton(
          //     icon: Icon(typing ? Icons.search : Icons.cancel),
          //     color: Colors.white,
          //     onPressed: () {},
          //   ),
          // ),
        ],
      ),
    );
  }
}

enum ConfirmAction { CANCEL, ACCEPT }

Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reset settings?'),
        content: const Text(
            'This will reset your device to its default factory settings.'),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('ACCEPT'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}