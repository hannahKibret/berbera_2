import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:berbera_2/services/product_service.dart';

void main() => runApp(EditInvo());

class EditInvo extends StatefulWidget{
  @override
  _EditInvoState createState() => _EditInvoState();
}

class _EditInvoState extends State<EditInvo> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        //title: Text(_page[_selectedPage].toString()),
        //backgroundColorStart: Colors.deepOrange,
        //backgroundColorEnd: Colors.pinkAccent,
        backgroundColor: Colors.grey[900],
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
  ProductService _proServ = ProductService();
  Future getProducts() async{
    var firestore = Firestore.instance;
    return  _proServ.getProduct(context).toList();
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
                    return ListTile(
                      onTap: (){
                        navigateToDetail(snapshot.data[index]);
                      },
                      title: Text(snapshot.data[index].data['brandName']),
                      subtitle: Text(snapshot.data[index].data['subcategory'],),
                    );});
            return Container();
          }),
    );
  }

  void navigateToDetail(DocumentSnapshot product) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context)=> DetailPage(product: product,)),
    );
  }
}
class DetailPage extends StatefulWidget{
  final DocumentSnapshot product;
  DetailPage({this.product});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final db  = Firestore.instance;

  final List<String> _currentSubSelected = <String>['Boots', 'Casual', 'Sports'];

  var _catM = ['Bag','Hoodie','Jacket','Pants','Shoes','Shirt','Suit', 'Sweater','Swim Suit','Tie','T-Shirt'];
  var _catF = ['Bag','Dress','Hoodie','Jacket','Pants','Shoes','Shirt','Suit','Sweater','Swim Suit','T-Shirt'];
  var _sub = ['Buisness', 'Casual','Sports','Fancy'];
  var _subMShoes = ['Boots','Shera','Sneakers','Suit-Shoe'];
  var _subFShoes = ['Boots','Heels','Shera','Sneakers'];
  var _sub2 = ['Casual','Sports','Fancy'];
  var _sub3 = ['Sports','Fancy'];
  var _sizes = [];
  var _brands = ['Nike','Addidas','Fila','Puma', 'Under Armour','Reebok', 'Vans', 'Jordans', 'Skechers', 'New Balance', 'Gucci','other'];

  bool isChecked =false;
  bool isChecked2 =false;
  bool isChecked3 =false;
  bool isChecked4 =false;
  bool isChecked5 =false;
  bool isChecked6 =false;
  bool isChecked7 =false;
  bool isChecked8 =false;
  bool isChecked9 =false;
  bool isChecked10 =false;
  bool isChecked11 =false;
  bool isChecked12 =false;
  bool isChecked13 =false;
  bool isChecked14 =false;
  bool isChecked15 =false;
  bool isChecked16 =false;
  bool isChecked17 =false;
  bool isChecked18 =false;
  bool isChecked19 =false;

  String _itemName;
  String _size;
  String _price;
  String _amount;
  String _currentBrandSelected;
  bool checked = false;

  String _gender;

  int index = 0;
  String _currentCategorySelected;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _image;
  @override
  Widget _buildCategory(){
    _currentCategorySelected = widget.product.data['category'];
    return Container(
      width: 150,
      child: DropdownButtonFormField(
        items: _catM.map((String dropDownStringItem){
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem),
          );
        }).toList(),
        onChanged: (String newValueSelected){
          setState(() {
            this._currentCategorySelected = newValueSelected;
          });
        },
        value: _currentCategorySelected,
        onSaved: (String value){
          _currentCategorySelected = value;
        },
      ),
    );
  }

  Widget _buildSubCategory(){
    if(_currentCategorySelected == 'Shoes'){
      index = 0;
      return Container(
        width: 150,
        child: DropdownButtonFormField(
          items: _subMShoes.map((String dropDownStringItem){
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          onChanged: (String newValueSelected){
            setState(() {
              this._currentSubSelected[index] = newValueSelected;
            });
          },
          value: _currentSubSelected[index],
          onSaved: (String value){
            _currentSubSelected[index] = value;
          },
        ),
      );
    }

    if(_currentCategorySelected == 'T-Shirt'){
      index = 1;
      return Container(
        width: 150,
        child: DropdownButtonFormField(
          items: _sub2.map((String dropDownStringItem){
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          onChanged: (String newValueSelected){
            setState(() {
              this._currentSubSelected[index] = newValueSelected;
            });
          },
          value: _currentSubSelected[index],
          onSaved: (String value){
            _currentSubSelected[index] = value;
          },
        ),
      );
    }
    if(_currentCategorySelected == 'Hoodie'){
      index = 2;
      return Container(
        width: 150,
        child: DropdownButtonFormField(
          items: _sub3.map((String dropDownStringItem){
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          onChanged: (String newValueSelected){
            setState(() {
              this._currentSubSelected[index] = newValueSelected;
            });
          },
          value: _currentSubSelected[index],
          onSaved: (String value){
            _currentSubSelected[index] = value;
          },
        ),
      );
    }
  }
  Widget _buildItemName(){
    _itemName = widget.product.data['itemName'];
    return Container(
      width: 150,
      child: TextFormField(
        decoration: InputDecoration(hintText: 'Airmax'),
        //decoration: InputDecoration(labelText: 'Airmax'),
        validator: (String value){
          if(value.isEmpty){
            return 'Brand Name is required';
          }
          return null;
        },
        onSaved:(String value){
          _itemName = value;
        },
      ),
    );
  }

  Widget _buildBrand(){
    _currentBrandSelected = widget.product.data['brandName'];
    return Container(
      width: 150,
      child: DropdownButtonFormField(
        items: _brands.map((String dropDownStringItem){
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem),
          );
        }).toList(),
        hint: Text('Category'),
        onChanged: (String newValueSelected){
          setState(() {
            this._currentBrandSelected = newValueSelected;
          });
        },
        value: _currentBrandSelected,
        onSaved: (String value){
          _currentBrandSelected = value;
        },
      ),
    );
  }

  Widget _buildSize(){
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('XL'),
              Checkbox(
                  value: checked,
                  onChanged: (bool newval){setState(() {
                    checked = newval;
                    if(checked == true){
                      _sizes.add('XL');
                    }else{
                      _sizes.remove('XL');
                    }
                  });
                  }
              ),
              Text('L'),
              Checkbox(
                  value: isChecked2,
                  onChanged: (bool newval){setState(() {
                    isChecked2 = newval;
                    if(isChecked2 == true){
                      _sizes.add('L');
                    }else{
                      _sizes.remove('L');
                    }
                  });
                  }
              ),
              Text('M'),
              Checkbox(
                  value: isChecked,
                  onChanged: (bool newval){setState(() {
                    isChecked = newval;
                    if(isChecked == true){
                      _sizes.add('M');
                    } else{
                      _sizes.remove('M');
                    }
                  });
                  }
              ),
              Text('S'),
              Checkbox(
                  value: isChecked3,
                  onChanged: (bool newval){setState(() {
                    isChecked3 = newval;
                    if(isChecked3 == true){
                      _sizes.add('S');
                    } else{
                      _sizes.remove('S');
                    }
                  });
                  }
              ),
              Text('XS'),
              Checkbox(
                  value: isChecked4,
                  onChanged: (bool newval){setState(() {
                    isChecked4 = newval;
                    if(isChecked4 == true){
                      _sizes.add('XS');
                    } else{
                      _sizes.remove('XS');
                    }
                  });
                  }
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('35'),
              Checkbox(
                  value: isChecked5,
                  onChanged: (bool newval){setState(() {
                    isChecked5 = newval;
                    if(isChecked5 == true){
                      _sizes.add('35');
                    } else{
                      _sizes.remove('35');
                    }
                  });
                  }
              ),
              Text('36'),
              Checkbox(
                  value: isChecked6,
                  onChanged: (bool newval){setState(() {
                    isChecked6 = newval;
                    if(isChecked6 == true){
                      _sizes.add('36');
                    } else{
                      _sizes.remove('36');
                    }
                  });
                  }
              ),
              Text('37'),
              Checkbox(
                  value: isChecked7,
                  onChanged: (bool newval){setState(() {
                    isChecked7 = newval;
                    if(isChecked7 == true){
                      _sizes.add('37');
                    } else{
                      _sizes.remove('37');
                    }
                  });
                  }
              ),
              Text('38'),
              Checkbox(
                  value: isChecked8,
                  onChanged: (bool newval){setState(() {
                    isChecked8 = newval;
                    if(isChecked8 == true){
                      _sizes.add('38');
                    } else{
                      _sizes.remove('38');
                    }
                  });
                  }
              ),
              Text('39'),
              Checkbox(
                  value: isChecked9,
                  onChanged: (bool newval){setState(() {
                    isChecked9 = newval;
                    if(isChecked9 == true){
                      _sizes.add('39');
                    } else{
                      _sizes.remove('39');
                    }
                  });
                  }
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('40'),
              Checkbox(
                  value: isChecked10,
                  onChanged: (bool newval){setState(() {
                    isChecked10 = newval;
                    if(isChecked10 == true){
                      _sizes.add('40');
                    } else{
                      _sizes.remove('40');
                    }
                  });
                  }
              ),
              Text('41'),
              Checkbox(
                  value: isChecked11,
                  onChanged: (bool newval){setState(() {
                    isChecked11 = newval;
                    if(isChecked11 == true){
                      _sizes.add('41');
                    } else{
                      _sizes.remove('41');
                    }
                  });
                  }
              ),
              Text('42'),
              Checkbox(
                  value: isChecked12,
                  onChanged: (bool newval){setState(() {
                    isChecked12 = newval;
                    if(isChecked12 == true){
                      _sizes.add('42');
                    } else{
                      _sizes.remove('42');
                    }
                  });
                  }
              ),
              Text('43'),
              Checkbox(
                  value: isChecked13,
                  onChanged: (bool newval){setState(() {
                    isChecked13 = newval;
                    if(isChecked13 == true){
                      _sizes.add('43');
                    } else{
                      _sizes.remove('43');
                    }
                  });
                  }
              ),
              Text('44'),
              Checkbox(
                  value: isChecked14,
                  onChanged: (bool newval){setState(() {
                    isChecked14 = newval;
                    if(isChecked14 == true){
                      _sizes.add('44');
                    } else{
                      _sizes.remove('44');
                    }
                  });
                  }
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('45'),
              Checkbox(
                  value: isChecked15,
                  onChanged: (bool newval){setState(() {
                    isChecked15 = newval;
                    if(isChecked15 == true){
                      _sizes.add('45');
                    } else{
                      _sizes.remove('45');
                    }
                  });
                  }
              ),
              Text('46'),
              Checkbox(
                  value: isChecked16,
                  onChanged: (bool newval){setState(() {
                    isChecked16 = newval;
                    if(isChecked16 == true){
                      _sizes.add('46');
                    } else{
                      _sizes.remove('46');
                    }
                  });
                  }
              ),
              Text('47'),
              Checkbox(
                  value: isChecked17,
                  onChanged: (bool newval){setState(() {
                    isChecked17 = newval;
                    if(isChecked17 == true){
                      _sizes.add('47');
                    } else{
                      _sizes.remove('47');
                    }
                  });
                  }
              ),
              Text('48'),
              Checkbox(
                  value: isChecked18,
                  onChanged: (bool newval){setState(() {
                    isChecked18 = newval;
                    if(isChecked18 == true){
                      _sizes.add('48');
                    } else{
                      _sizes.remove('48');
                    }
                  });
                  }
              ),
              Text('49'),
              Checkbox(
                  value: isChecked19,
                  onChanged: (bool newval){setState(() {
                    isChecked19 = newval;
                    if(isChecked19 == true){
                      _sizes.add('49');
                    } else{
                      _sizes.remove('49');
                    }
                  });
                  }
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildPrice(){
    _price = widget.product.data['price'];
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price in ETB'),
      keyboardType: TextInputType.number,
      validator: (String value){
        double p = double.tryParse(value);
        if(p == null || p <= 0){
          return 'Price must be greater than 0';
        }
        return null;
      },
      onSaved:(String value){
        _price = value;
      },
    );
  }

  Widget _buildAmount(){
    _amount = widget.product.data['amount'];
    return TextFormField(
      decoration: InputDecoration(labelText: 'Amount'),
      keyboardType: TextInputType.number,
      validator: (String value){
        int p = int.tryParse(value);
        if(p == null || p <= 0){
          return 'Amount must be greater than 0';
        }
        return null;
      },
      onSaved:(String value){
        _amount = value;
      },
    );
  }
  Widget _buildImage(){
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: OutlineButton(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 2.5,),
              onPressed: (){
                _selectImage(ImagePicker.pickImage(source: ImageSource.gallery));
              },
              child: _displayChild(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _gender = widget.product.data['Type'];
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Category:', style: TextStyle(fontSize: 15, color: Colors.blue),),
                    SizedBox(width: 115,),
                    Text('Sub-Category:',  style: TextStyle(fontSize: 15,color: Colors.blue),),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildCategory(),
                    SizedBox(width: 60,),
                    _buildSubCategory(),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Text('Item name:', style: TextStyle(fontSize: 15, color: Colors.blue),),
                      SizedBox(width: 114,),
                      Text('Brand name:',  style: TextStyle(fontSize: 15, color: Colors.blue),),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    _buildItemName(),
                    SizedBox(width: 60,),
                    _buildBrand(),
                  ],
                ),
                _buildPrice(),
                _buildAmount(),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('Available Size:', style: TextStyle(fontSize: 15, color: Colors.blue),),
                ),
                _buildSize(),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Row(
                    children: <Widget>[
                      Text('Add Image:', style: TextStyle(fontSize: 15, color: Colors.blue),),
                    ],
                  ),
                ),
                _buildImage(),
                SizedBox(height: 50,),
                RaisedButton(
                  child: Text('Update Item', style: TextStyle(color: Colors.blue, fontSize: 16),),
                  onPressed: () async{
                    if(!_formKey.currentState.validate()){
                      return;
                    }
                    _formKey.currentState.save();
                    _validateImageUpload();
                  },
                )
              ],
            ),),
        ),
      ),
    );

  }

  void _selectImage(Future<File> pickImage) async {
    File temp = await pickImage;
    setState(() {
      _image = temp;
    });
  }

  Widget _displayChild() {
    if (_image == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: Icon(Icons.add, color: Colors.grey,),
      );
    }
    return Image.file(_image, fit: BoxFit.fill, width: double.infinity,);
  }
  void _validateImageUpload() async{
    if(_image != null){
      String imageUrl;
      final FirebaseStorage storage = FirebaseStorage.instance;
      final String picture = '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
      StorageUploadTask task1 = storage.ref().child(picture).putFile(_image);

      task1.onComplete.then((snapshot1) async{
        imageUrl = await snapshot1.ref.getDownloadURL();
      });
      await db.collection('products').document('${widget.product}').updateData({
        'category': _currentCategorySelected,
        'subcategory': _currentSubSelected[index],
        'itemName': _itemName,
        'brandName': _currentBrandSelected,
        'size': _sizes,
        'price': _price,
        'amount': _amount,
        'image': imageUrl,
      });
    }
  }
}