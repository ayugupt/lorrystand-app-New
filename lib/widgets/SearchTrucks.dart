import 'package:flutter/material.dart';

class TrucksPage extends StatefulWidget {
  TrucksPage({Key key}) : super(key: key);

  @override
  _TrucksPageState createState() => _TrucksPageState();
}

class _TrucksPageState extends State<TrucksPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: TextBox(),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.green),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(left:20.0, right:20.0),
          child: ListView(
        children: [
          SizedBox(height: 20,),
          Card(
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
                child:  Container(
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
                            "cxzxczxc dfsdfsf",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text("vdfdsf dsfsdf"),
                          ),
                  ],
                ),
              ),
              ),
             
            ],
            ),
          ),
        
        ],
      )),
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
