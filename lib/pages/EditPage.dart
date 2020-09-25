import 'package:berbera_2/pages/AddInvo.dart';
import 'package:berbera_2/pages/EditInvo.dart';
import 'package:flutter/material.dart';

void main() => runApp(EditPage());

class EditPage extends StatefulWidget{
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final List<String> entries = <String>['Add Item', 'Edit Item'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        //title: Text(_page[_selectedPage].toString()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
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
              if(index == 0){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=> AddInvo(),
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
                    builder: (context)=> EditInvo(),
                    settings: RouteSettings(
                        arguments: entries[index]
                    ),
                  ),
                );
              }
            },
          );

        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}