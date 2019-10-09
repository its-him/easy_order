import 'package:easy_order/Screens/DisplayItems.dart';
import 'package:easy_order/Screens/drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayCuisine extends StatefulWidget {
  @override
  _DisplayCuisineState createState() => _DisplayCuisineState();
}

class _DisplayCuisineState extends State<DisplayCuisine> {
  Route route = MaterialPageRoute(builder: (context) => DisplayCuisine());

  navigateToItems(String name) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DisplayItems(
                  cuisine: name,
                )));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Cuisines',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: StreamBuilder(
        stream: Firestore.instance.collection('cuisine').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('Loading Data ...... Please wait');
          return ListView(
            children: snapshot.data.documents.map((document) {
              return Container(
                child: ListTile(
                  title: Column(
                    children: <Widget>[
                      Container(
                        child: Image.network(document['imagePath']),
                        height: 180.0,
                      )
                      // Image.network(document['imagePath']),
                    ],
                  ),
                  subtitle: Text(
                    document['name'],
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => navigateToItems(document['name'].toString()),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class custom extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;
  custom(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    // TODO: implement buil
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.lightGreenAccent,
          child: Container(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text, style: TextStyle(fontSize: 20.0)),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
