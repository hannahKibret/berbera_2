import 'dart:io';

import 'package:berbera_2/services/product_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

void main() => runApp(FemaleClothing());

class FemaleClothing extends StatefulWidget {
  @override
  _FemaleClothingState createState() => _FemaleClothingState();
}

class _FemaleClothingState extends State<FemaleClothing> {
  ProductService _proServ = ProductService();
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
  bool checked = false;

  File _image;
  String _itemName;
  String imageUrl;
  final String _Female = 'Female';
  String _size;
  String _price;
  String _color;
  String _amount;

  String F = 'Female';

  int index = 0;
  String group = 'M';
  String _currentCategorySelected = 'Shoes';
  String _currentBrandSelected = 'Nike';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildCategory(){
    return Container(
      width: 150,
      child: DropdownButtonFormField(
        items: _catF.map((String dropDownStringItem){
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem),
          );
        }).toList(),
        hint: Text('Category'),
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
          items: _subFShoes.map((String dropDownStringItem){
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
    return Container(
      width: 150,
      child: TextFormField(
        decoration: InputDecoration(hintText: 'Airmax'),
        //decoration: InputDecoration(labelText: 'Airmax'),
        validator: (String value){
          if(value.isEmpty){
            return 'Item Name is required';
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
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5,),
              onPressed: (){

              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                child: Icon(Icons.add, color: Colors.grey,),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Category:', style: TextStyle(fontSize: 15, color: Colors.pinkAccent),),
                  SizedBox(width: 115,),
                  Text('Sub-Category:',  style: TextStyle(fontSize: 15,color: Colors.pinkAccent),),
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
                    Text('Item name:', style: TextStyle(fontSize: 15, color: Colors.pinkAccent),),
                    SizedBox(width: 114,),
                    Text('Brand name:',  style: TextStyle(fontSize: 15, color: Colors.pinkAccent),),
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
                child: Text('Available Size:', style: TextStyle(fontSize: 15, color: Colors.pinkAccent),),
              ),
              _buildSize(),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Row(
                  children: <Widget>[
                    Text('Add Image:', style: TextStyle(fontSize: 15, color: Colors.pinkAccent),),
                  ],
                ),
              ),
              _buildImage(),
              SizedBox(height: 50,),
              RaisedButton(
                child: Text('Add Item', style: TextStyle(color: Colors.blue, fontSize: 16),),
                onPressed: () async{
                  if(!_formKey.currentState.validate()){
                    return;
                  }
                  _formKey.currentState.save();
                  _validateImageUpload();
//                  await db.collection('products').add(
//                      {
//                        'Type': _Female,
//                        'category': _currentCategorySelected,
//                        'subcategory': _currentSubSelected[index],
//                        'itemName': _itemName,
//                        'brandName': _currentBrandSelected,
//                        'size': _sizes,
//                        'price': _price,
//                        'amount': _amount,
//                      }
                 // );
                },
              )
            ],
          ),),
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
      final FirebaseStorage storage = FirebaseStorage.instance;
      final String picture = '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
      StorageUploadTask task1 = storage.ref().child(picture).putFile(_image);

      task1.onComplete.then((snapshot1) async{
        imageUrl = await snapshot1.ref.getDownloadURL();
        Map<String,dynamic> productDate={'Type':this._Female,'category':this._currentCategorySelected,'subcategory':this._currentSubSelected[index],'itemName':this._itemName,'brandName':this._currentBrandSelected,'size':this._sizes,'price':this._price,'amount':this._amount,'image':''};
        await _proServ.addData(productDate).then((result){}).catchError((e){print(e);});
      });

    }
  }
}


