import 'package:flutter/material.dart';

import './EditPage.dart';
import './LowInvo.dart';

class Inventory extends StatefulWidget{
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final List<String> entries = <String>[
    'Status',
    'Low Inventory',
    'Edit Inventory',
    'Add To Inventory'
  ];

  String _tab_detail = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(5.0, 20.0, 10.0, 0),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return _tab(index);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        indent: 5,
      ),
    );
  }

  Material _tab(
    int index,
  ) {
    return Material(
        color: Colors.white,
        elevation: 14.0,
        borderRadius: BorderRadius.circular(24),
        shadowColor: Color(0x802196F3),
        child: GestureDetector(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${entries[index]}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_tab_detail,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    )),
              )
            ],
          ),
          onTap: () {
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPage(),
                  settings: RouteSettings(arguments: entries[index]),
                ),
              );
            }
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LowInvo(),
                  settings: RouteSettings(arguments: entries[index]),
                ),
              );
            }
            /*if(index == 0){
                  child: Column(
                      children: <Widget>[
                          Text('orders',),
                          Visibility(
                            child: Text('Home',),
                            visible: true,
                          ),
                          Text('orders',),
                     ],
                   ),
                }*/
          },
        ));
  }

}