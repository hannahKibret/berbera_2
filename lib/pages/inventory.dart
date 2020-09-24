import 'package:flutter/material.dart';
import './EditPage.dart';
import './LowInvo.dart';

void main() => runApp(Inventory());

class Inventory extends StatefulWidget{
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final List<String> entries = <String>['Status', 'Low Inventory', 'Edit Inventory', 'Sales'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(5.0, 20.0, 10.0, 0),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            height: 60,
            color: Colors.grey[300],
            child: Text('${entries[index]}', style: TextStyle(fontSize: 18.0),), padding: const EdgeInsets.all(10.0),
          ),
          onTap: (){
            if(index == 2){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (
                      context)=> EditPage(),
                  settings: RouteSettings(
                      arguments: entries[index]
                  ),
                ),
              );
            }
            if(index == 1){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (
                      context)=> LowInvo(),
                  settings: RouteSettings(
                      arguments: entries[index]
                  ),
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
        );

      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );


  }
}