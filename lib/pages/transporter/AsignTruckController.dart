import 'package:flutter/material.dart';


class AsignTruckPage extends StatefulWidget {
  AsignTruckPage({Key key}) : super(key: key);


  @override
  _AsignTruckPageState createState() => _AsignTruckPageState();
}

class _AsignTruckPageState extends State<AsignTruckPage>
    with TickerProviderStateMixin {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBox(),
        //backgroundColor: Colors.green,
        iconTheme: IconThemeData(
          color: Colors.green
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ), 
      ),
      body: Center(
        child: Text("Your app content"),
      ),
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
                hintText: 'Search',
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
                    }
                ),
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
