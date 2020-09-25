import 'dart:io';
import 'package:berbera_2/pages/supplierMain.dart';
import 'package:berbera_2/services/offer_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:berbera_2/widget/offer_dropdown_field.dart';
import 'package:berbera_2/models/offer.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'offer_page.dart';
class  OfferAddingPage extends StatefulWidget {
  @override
  _OfferAddingPageState createState() => _OfferAddingPageState();
}

class _OfferAddingPageState extends State<OfferAddingPage> {

  bool _formChanged = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode focusNode;
  OfferDropDownField offerDrop = OfferDropDownField();
  String _selectedOffer = offers[0];
  Offer _offer  = Offer();
  File _image;


  OfferService _offerService = OfferService();
  String _downloadURL;

  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(()=> _image = image);

  }

  Future uploadPic(BuildContext context) async{
    String filename = basename(_image.path);
   final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);

   setState(()=>_downloadURL = filename);
    final StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    await uploadTask.onComplete;
   // _addPathToDatabase(filename);


    }
    Future<void> _addPathToDatabase(String text)async {
      final ref = FirebaseStorage.instance.ref().child(text);
      var _downloadURL = await ref.getDownloadURL();
      //_offer.image = _downloadURL;


    }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    _offer.type = offers[0];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,

        ),
        body:Container(
            //padding: const EdgeInsets.only(left:4.0,right:120.0),
             child: Form(
                key: _formKey,
                onChanged: _onFormChange,
                child: ListView(
                  children:<Widget>[

                    Padding(
                      padding: const EdgeInsets.only(left:12.0,top:10.0,right:140.0),
                      child:(_image!=null)?Image.file(_image,

                        width:12.0,
                        height: 100.0,
                      ):
                      CachedNetworkImage(
                        imageUrl:'https://firebasestorage.googleapis.com/v0/b/berbera-b0ff0.appspot.com/o/addImage.png?alt=media&token=41e9e342-60cf-40f0-8c7c-ee6dd9fb486d',
                        placeholder:(context,url)=>CircularProgressIndicator(),
                        width:12.0,
                        height: 100.0,
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,top:10.0,right:140.0),
                      child: FlatButton(
                        child:Text('add image',
                        style:TextStyle(
                          color:Colors.deepOrange,
                        ),
                        ),
                        onPressed: (){
                          getImage();
                        },
                      ),
                    ),
//                    Padding(
//                        padding: const EdgeInsets.only(left:10.0,top:10.0,right:140.0),
//                        child: Text('Item name')
//                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,top:10.0,right:140.0),
                      child: TextFormField(
                        onChanged: (val) => this._offer.name = val,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          //helperText: "Optional",
                          labelText: 'Item name',

                        ),
                        validator: (String val) {
                          if (val.isEmpty) {
                            return "Field cannot be left blank";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,top:10.0,right:120.0),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Text('offer type:'),
                         // child:Flexible(
                          child:OfferDropDownField(
                            selectedOffer:this._selectedOffer,
                            onChanged:(newOffer){
                              setState((){
                                this._offer.type = newOffer;
                                this._selectedOffer = newOffer;
                              });
                            }

                          ),


//
//                          )
//
//                        ],

                      //),
                    ),
//                    Padding(
//                        padding: const EdgeInsets.only(left:10.0,top:10.0,right:140.0),
//                        child: Text('offer description')
//                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,top:10.0,right:10.0),
                      child: TextFormField(
                        maxLines:null,
                        keyboardType: TextInputType.multiline,
                        onChanged: (val) =>this. _offer.description = val,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          // helperText: "Optional",
                          labelText: 'Offer description'

                        ),
                        validator: (String val) {
                          if (val.isEmpty) {
                            return "Field cannot be left blank";
                          }
                          print('Valueee'+val);
                          return null;
                        },
                      ),
                    ),



                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[Expanded(
                        child: Align(
                          alignment:Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right:5.0),
                            child: RaisedButton(
                              color: Colors.deepOrange,
                              child:Text('Done',
                                style:TextStyle(
                                  color:Colors.white,
                                ),
                              ),
                              onPressed:_formChanged?()async{
                                if(_formKey.currentState.validate()) {
//                                  Navigator.of(context).pop();
//                                  Navigator.of(context).pushNamed('/offer');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context)=> SupplierMain(),
                                      settings: RouteSettings(
                                          arguments: ''
                                      ),
                                    ),
                                  );


                                  if (_image != null) {
                                    uploadPic(context);
                                    final ref = FirebaseStorage.instance.ref().child(_downloadURL);
                                    _offer.image = await ref.getDownloadURL();

                                  } else {
                                    _offer.image = '';
                                  }
                                  Map<String,dynamic> offerData = {'image':_offer.image,'name':this._offer.name,'type':_offer.type, 'description':this._offer.description};
                                  _offerService.addData(offerData);
                                } else {
                                  FocusScope.of(context).requestFocus(focusNode);
                                }
                            }:null
                            ),
                          ),
                        ),
                      ),
      ],
                    ),

      ],
                    ),

                ),


          ),

    );
  }


  void _onFormChange() {
    if (_formChanged) return;
    setState(() {
      _formChanged = true;
    });
  }
}


