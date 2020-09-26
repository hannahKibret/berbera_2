import 'dart:io';

import 'package:berbera_2/models/profile.dart';
import 'package:berbera_2/pages/sign_up_page2.dart';
import 'package:berbera_2/services/auth.dart';
import 'package:berbera_2/services/supplier_service.dart';
import 'package:berbera_2/services/verification_service.dart';
import 'package:berbera_2/widget/location_dropdown_field.dart';
import 'package:berbera_2/widget/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grouped_checkbox/grouped_checkbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _formChanged = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode focusNode;
  Profile _profile = Profile();
  Store _store = Store();
  String _storeLocation = StoreLocations[0];
  String _category = Categories[0];
  File _image;
  SupplierService _createPro = SupplierService();
  AuthService auth = AuthService();
  VerificationService _vService = VerificationService();
  String _code;
  String _downloadURL;
  List<String> allItemList = [
    "Fashion",
    "Electronics",
    "Kids and Toys",
    "Phone and accessories ",
    "Computer and accessories"
  ];

  List<String> selectedItemList;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() => _image = image);
  }

  Future uploadPic(BuildContext context) async {
    String filename = basename(_image.path);
    //  _profile.image = filename;
    setState(() => _downloadURL = filename);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  }


  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    _store.storeLocation = StoreLocations[0];
    _store.category = Categories[0];
  }

  // _SignupState({this.selectedLocation});
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of(context).auth;
    Stream stream = _vService.getSent(context);
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xffe9902e),
      ),
      home: Scaffold(
        body: Builder(
          builder: (context) => Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: _formKey,
                onChanged: _onFormChange,
                child: ListView(

                  shrinkWrap: true,
                  scrollDirection:Axis.vertical,
                  children: <Widget>[
/*
                  Container(
                    height:60.0,
                    alignment: Alignment.topCenter,
              child:Align(
                alignment:Alignment.topCenter,
              child:Steps(
              direction: Axis.horizontal,
                size: 11.0,
                path: {'color': Colors.black, 'width': 2.0},
                steps: [
                  {
                    'color': Colors.white,
                    'background': Color(0xffe9902e),
                    'label': '1',

                  },
                  {
                    'color': Colors.white,
                    'background': Colors.black,
                    'label': '2',

                  },
                  {
                    'color': Colors.white,
                    'background': Colors.black,
                    'label': '3',

                  }
                ],
              ),
              ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child:Text(
                      'USER SIGN UP',
                      style:TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,

                      )
                    )
                  ),*/
                    SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.black,
                            child: ClipOval(
                              child: SizedBox(
                                width: 100.0,
                                height: 100.0,
                                child: (_image != null) ? Image.file(
                                    _image, fit: BoxFit.fill) :
                                CachedNetworkImage(
                                  imageUrl: 'https://firebasestorage.googleapis.com/v0/b/berbera-b0ff0.appspot.com/o/profile_img.jpg?alt=media&token=f608e728-a2ba-4dbb-8a55-6948e4d4b7fa',
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  fit: BoxFit.fill,
                                ),
                              ),

                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: IconButton(
                              alignment: Alignment.center,
                              icon: Icon(
                                Icons.camera_enhance,
                                size: 30.0,
                              ),
                              onPressed: () {
                                getImage();
                              },
                            )),
                      ],
                    ),
                    Divider(
                      height: 32.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _controller,
                        onSaved: (String val) => this._profile.fullName = _controller.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.00),
                          ),

                          // helperText: "Required",
                          hintText: "Full name",
                        ),
                        //autovalidate: _formChanged,
                        validator: (String val) {
                          if (val.isEmpty) return "Field cannot be left blank";
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        // autofocus: true,
                        controller: _controller2,
                        keyboardType: TextInputType.phone,
                        onSaved: (String val) => this._profile.contact = val,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.00),
                          ),
                          // helperText: "Optional",
                          hintText: "Phone Number",
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        //  autofocus:true,
                        controller: _controller3,
                        onSaved: (String val) => this._store.storeName = val,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.00),
                          ),
                          // helperText: "Optional",
                          hintText: "Store Name",
                        ),
                        validator: (String val) {
                          if (val.isEmpty) {
                            return "Field cannot be left blank";
                          }
                          return null;
                        },
                      ),
                    ),
                    FormField(

                      builder: (context) {
                        return Row(

                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child:LocationDropDownField(
                                selectedLocation:this._storeLocation,
                                onChanged:(newLocation){setState((){
                                  this._store.storeLocation = newLocation;
                                  this._storeLocation = newLocation;
                                  print(newLocation);});},
                              ),
                            ),



                          ],

                        );
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _controller4,
                        //  autofocus: true,
                        keyboardType: TextInputType.datetime,
                        onSaved: (String val) => this._store.workingHours = val,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.00),
                          ),
                          // helperText: "Optional",
                          hintText: "Working hours",
                        ),
                        validator: (String val) {
                          if (val.isEmpty) {
                            return "Field cannot be left blank";
                          }
                          return null;
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("Categories", style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),),
                            Padding(padding: EdgeInsets.all(10),
                              child: GroupedCheckbox(
                                  itemList: allItemList,
                                  // checkedItemList: checkedItemList,
                                  onChanged: (itemList) {
                                    setState(() {
                                      selectedItemList = itemList;
                                      print('SELECTED ITEM LIST $itemList');
                                    });
                                  },
                                  orientation: CheckboxOrientation.WRAP,
                                  checkColor: Colors.white,
                                  activeColor: Colors.orangeAccent
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    /*   StreamBuilder<DocumentSnapshot>(
                        stream: stream.asBroadcastStream(),
                        builder: (context, snapshot) {
                          return  Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              controller: _controller5,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.00),
                                ),
                                // helperText: "Required",
                                hintText: "Verification code",
                              ),
                              //autovalidate: _formChanged,
                              validator: (String val) {
                                try {
                                  if (val != snapshot.data['code']) {
                                    return "Incorrect verification code";
                                  }
                                  //return null;
                                }catch(e){

                                }
                                return null;
                              },
                            ),
                          );
                        }
                    ), */,
                    Divider(
                      height: 32.0,
                    ),
                    Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[ Expanded(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Container(
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(
                                      color: Color(0xffe9902e),
                                      child: Text("Next", style: TextStyle(
                                          color: Colors.white, fontSize: 18),),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignupPage2(),
                                            settings: RouteSettings(
                                                arguments: ''
                                            ),
                                          ),
                                        );
                                      }
                                    /*_formChanged
                                        ? () async {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        // final uid = await Provider.of(context).auth
                                        //_profile.store = _store;
                                        // navigateToSignupPage2(context);
                                        //Navigator.of(context).pushReplacementNamed('/signupage2');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignupPage2(),
                                            settings: RouteSettings(
                                                arguments: ''
                                            ),
                                          ),
                                        );
                                        if (_image != null) {
                                          uploadPic(context);
                                          final ref = FirebaseStorage.instance.ref()
                                              .child(_downloadURL);
                                          _profile.image = await ref.getDownloadURL();
                                        } else {
                                          _profile.image = '';
                                        }
                                        final uid = await auth.getCurrentUID();
                                        print('UIDDDD:${_profile.fullName}');
                                        Map<String, dynamic> profileDate = {
                                          'image': this._profile.image,
                                          'fullname': this._profile.fullName,
                                          'contact': this._profile.contact,
                                          'storename': this._store.storeName,
                                          'storeLocation': this._store.storeLocation,
                                          'category': this._store.category,
                                          'workingHours': _store.workingHours
                                        };
                                        await _createPro.addData(profileDate, uid)
                                            .then((result) {})
                                            .catchError((e) {
                                          print(e);
                                        });
                                      } else {
                                        FocusScope.of(context).requestFocus(
                                            focusNode);
                                      }
                                    }
                                        : null, */
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ]
                    ),

                  ],
                ),
              ),
            ),
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

  Future navigateToSignupPage2(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage2()));
  }


}