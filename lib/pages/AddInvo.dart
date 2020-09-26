import 'package:berbera_2/pages/FemaleClothing.dart';
import 'package:berbera_2/pages/MaleClothing.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddInvo extends StatefulWidget{
  @override
  _AddInvoState createState() => _AddInvoState();
}

class _AddInvoState extends State<AddInvo> {
  Color PrimaryColor = Colors.blue;
  /*final List<String> _currentSubSelected = <String>['Boots', 'Casual', 'Sports'];

  var _catM = ['Bag','Hoodie','Jacket','Pants','Shoes','Shirt','Suit', 'Sweater','Swim Suit','Tie','T-Shirt'];
  var _catF = ['Bag','Dress','Hoodie','Jacket','Pants','Shoes','Shirt','Suit','Sweater','Swim Suit','T-Shirt'];
  var _sub = ['Buisness', 'Casual','Sports','Fancy'];
  var _subMShoes = ['Boots','Shera','Sneakers','Suit-Shoe'];
  var _subFShoes = ['Boots','Heels','Shera','Sneakers'];
  var _sub2 = ['Casual','Sports','Fancy'];
  var _sub3 = ['Sports','Fancy'];

  int index = 0;
  String group = 'M';
  String _currentCategorySelected = 'Shoes';

  final db  = Firestore.instance;

  //String _category;
  //String _subCategory;
  String _brandName;
  String _size;
  String _price;
  String _color;
  String _amount;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  */

  //Widget _build
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text('Choose Something'),
            centerTitle: true,
            backgroundColor: Colors.indigo[900],
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 6.0,
              onTap: (index){
                setState(() {
                  switch(index){
                    case 0:
                      PrimaryColor = Colors.blue;
                      break;
                    case 1:
                      PrimaryColor = Colors.pinkAccent;
                      break;
                  }
                });
              },
              tabs: <Widget>[
                Tab(text: 'Men\'s Clothing', icon: Icon(MdiIcons.humanMale)),
                Tab(text: 'Women\'s Clothing', icon: Icon(MdiIcons.humanFemale)),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              MaleClothing(),
              FemaleClothing(),
            ].toList(),
          ),
        ),
      ),
    );

  }
}

