import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

void main() => runApp(LowInvo());

class LowInvo extends StatefulWidget{
  @override
  _LowInvoState createState() => _LowInvoState();
}

class _LowInvoState extends State<LowInvo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        //title: Text(_page[_selectedPage].toString()),
        backgroundColor: Colors.deepOrange,
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
      body: ListPage(),
    );
  }
}
class ListPage extends StatefulWidget{
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getProducts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("products").where('amount', isLessThan: '2').getDocuments();

    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: Text('Loading'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  if(snapshot.data['amount'] == '0'){
                    return ListTile(
                      title: Text(snapshot.data[index].data['itemName'] + snapshot.data[index].data['brandName']),
                      subtitle: Text('Sold out'),
                    );
                  } else{
                    return ListTile(
                        title: Text(snapshot.data[index].data['itemName'] + snapshot.data[index].data['brandName']),
                        subtitle: Text('Low amount'),
                    );
                  }//return Container();
                });

            return Container();
          }),
    );
  }
}