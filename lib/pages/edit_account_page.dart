
import 'dart:io';
import 'package:berbera_2/models/profile.dart';
import 'package:berbera_2/services/auth.dart';
import 'package:berbera_2/services/supplier_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:berbera_2/widget/location_dropdown_field.dart';
import 'package:berbera_2/widget/category_dropdown_field.dart';

class EditAccountPage extends StatefulWidget{
  @override
  _EditAccountPageState createState()=>_EditAccountPageState();

}

class _EditAccountPageState extends State<EditAccountPage> {

  File _image;
  bool _formChanged = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Profile _profile = Profile();
  Store _store = Store();
  String _storeLocation = StoreLocations[0];
  String _category = Categories[0];
  bool nameVisible;
  bool storeVisible;
  bool contactVisible;
  bool locationVisible;
  bool categoryVisible;

  SupplierService createProfile = SupplierService();
  AuthService auth = AuthService();
  String _downloadURL;

  // bool buttonClicked;
  String _button1Name;
  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(()=> _image = image);

  }
//  Future downloadImage(String filename) async{
//    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
//    String downloadAddress = await firebaseStorageRef.getDownloadURL();
//    setState(() => _downloadURL = downloadAddress);
//
//  }

  Future uploadPic(BuildContext context) async{
    String filename = basename(_image.path);
    setState(()=>_downloadURL = filename);
  //  _profile.image = filename;
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;




  }


  void initState() {
    nameVisible = true;
    storeVisible = true;
    contactVisible = true;
    locationVisible = true;
    categoryVisible = true;


    //_profile.fullName='';
    // button = false;

    _button1Name = 'edit';
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    Stream stream = createProfile.getSupplier(context);
    return StreamBuilder(
      stream: stream.asBroadcastStream(),
      builder: (context, snapshot) {
//        if(snapshot.data == null){
//          return CircularProgressIndicator();
//        }

        this._profile.fullName = snapshot.data.documents[0]['fullname'];
        this._store.storeName = snapshot.data.documents[0]['storename'];
        this._profile.contact = snapshot.data.documents[0]['contact'];
        //this._store.storeLocation = snapshot.data.documents[0]['storeLocation'];
        //this._store.category = snapshot.data.documents[0]['category'];

      this._profile.image = snapshot.data.documents[0]['image'];
    //  downloadImage(this._profile.image);

        return Scaffold(
          appBar: AppBar(
            title: Text('Berbera',style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.deepOrange,
          ),
          body: Builder(
            builder: (context) =>
                Container(

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),


                    child: Form(
                      key: _formKey,
                      child: ListView(

                        children: <Widget>[


                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FormField(

                                builder: (context) {
                                  return Align(
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
                                  ( this._profile.image  != null)? CachedNetworkImage(imageUrl: this._profile.image , placeholder:(context,url)=>CircularProgressIndicator(),fit: BoxFit.fill): CachedNetworkImage(
                                    imageUrl:'https://firebasestorage.googleapis.com/v0/b/berbera-b0ff0.appspot.com/o/profile_img.jpg?alt=media&token=f608e728-a2ba-4dbb-8a55-6948e4d4b7fa',
                                    placeholder:(context,url)=>CircularProgressIndicator(),
                                    fit:BoxFit.fill,
                                  ),
                                        ),

                                      ),
                                    ),

                                  );
                                }
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 60.0),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    getImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                    'User name:',
                                    style: TextStyle(color:Colors.grey),
                                ),
                              ),
                              FlatButton(
                                  child: (nameVisible) ? Text('edit') : Text(
                                      'Done'),
                                  onPressed: () async{
                                    setState((){
                                      this.nameVisible = !nameVisible;

                                      if(this._store.storeLocation == null){
                                        this._store.storeLocation = snapshot.data.documents[0]['storeLocation'];
                                      }
                                      if(this._store.category == null){
                                        this._store.category = snapshot.data.documents[0]['category'];
                                      }
                                    });
                                    _formKey.currentState.save();


                                    Map<String,dynamic> profileData={'image':this._profile.image,'fullname':this._profile.fullName,'contact':this._profile.contact,'storename':this._store.storeName,'storeLocation':this._store.storeLocation,'category':this._store.category};
                                    createProfile.updateData(context,profileData);
                                  }
                              ),
                            ],
                          ),

                          (nameVisible) ?

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                                _profile.fullName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ) :

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              onChanged: (String val) => this._profile.fullName = val,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                // helperText: "Required",
                                //labelText: "Full name",
                              ),
                              autofocus: true,
                              //autovalidate: _formChanged,

                            ),
                          ),
                          Divider(
                            height: 32.0,
                            color:Colors.black,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                    'Store Name:',
                                     style: TextStyle(color:Colors.grey),
                                ),
                              ),
                              FlatButton(
                                  child: (storeVisible) ? Text('edit') : Text(
                                      'Done'),
                                  onPressed: () {
                                    setState(() {
                                      this.storeVisible = !storeVisible;

                                      if(this._store.storeLocation == null){
                                        this._store.storeLocation = snapshot.data.documents[0]['storeLocation'];
                                      }
                                      if(this._store.category == null){
                                        this._store.category = snapshot.data.documents[0]['category'];
                                      }
                                    });

                                    Map<String,dynamic> profileData={'image':this._profile.image,'fullname':this._profile.fullName,'contact':this._profile.contact,'storename':this._store.storeName,'storeLocation':this._store.storeLocation,'category':this._store.category};
                                    createProfile.updateData(context,profileData);
                                  }
                              ),
                            ],
                          ),

                          (storeVisible) ?

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                                this._store.storeName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ) :

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              onChanged: (String val) => this._store.storeName = val,
                              //onSaved: (String val) => this._profile.fullName = val,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                // helperText: "Required",
                                //labelText: "Full name",
                              ),
                              autofocus: true,
                              //autovalidate: _formChanged,

                            ),
                          ),
                          Divider(
                            height: 32.0,
                            color:Colors.black,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                    'Contact:',
                                  style: TextStyle(color:Colors.grey),
                                ),
                              ),
                              FlatButton(
                                  child: (contactVisible) ? Text('edit') : Text(
                                      'Done'),
                                  onPressed: () {
                                    setState(() {
                                      this.contactVisible = !contactVisible;

                                      if(this._store.storeLocation == null){
                                        this._store.storeLocation = snapshot.data.documents[0]['storeLocation'];
                                      }
                                      if(this._store.category == null){
                                        this._store.category = snapshot.data.documents[0]['category'];
                                      }
                                    });

                                    Map<String,dynamic> profileData={'image':this._profile.image,'fullname':this._profile.fullName,'contact':this._profile.contact,'storename':this._store.storeName,'storeLocation':this._store.storeLocation,'category':this._store.category};
                                    createProfile.updateData(context,profileData);
                                  }
                              ),
                            ],
                          ),

                          (contactVisible) ?

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                                this._profile.contact,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ) :

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              onChanged: (String val) => this._profile.contact = val,
                              //onSaved: (String val) => this._profile.fullName = val,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                // helperText: "Required",
                                //labelText: "Full name",
                              ),
                              autofocus: true,
                              //autovalidate: _formChanged,

                            ),
                          ),
                          Divider(
                            height: 32.0,
                            color:Colors.black,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                    'Location:',
                                  style: TextStyle(color:Colors.grey),
                                ),
                              ),
                              FlatButton(
                                  child: (locationVisible) ? Text('edit') : Text(
                                      'Done'),
                                  onPressed: () {
                                    setState(() {
                                      this.locationVisible = !locationVisible;
                                      if(this._store.storeLocation == null){
                                        this._store.storeLocation = snapshot.data.documents[0]['storeLocation'];
                                      }
                                      if(this._store.category == null){
                                        this._store.category = snapshot.data.documents[0]['category'];
                                      }
                                    });

                                    Map<String,dynamic> profileData={'image':this._profile.image,'fullname':this._profile.fullName,'contact':this._profile.contact,'storename':this._store.storeName,'storeLocation':this._store.storeLocation,'category':this._store.category};
                                    createProfile.updateData(context,profileData);
                                  }
                              ),
                            ],
                          ),

                          (locationVisible) ?

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              snapshot.data.documents[0]['storeLocation'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ) :





                        FormField(

                        builder: (context) {
                          return LocationDropDownField(
                            selectedLocation: this._storeLocation,
                            onChanged: (newLocation) {
                              setState(() {
                                this._store.storeLocation = newLocation;
                                this._storeLocation = newLocation;
                                print(newLocation);
                              });
                            },
                          );
                        }
                        ),





                          Divider(
                            height: 32.0,
                            color:Colors.black,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Category:',
                                  style: TextStyle(color:Colors.grey),
                                ),
                              ),
                              FlatButton(
                                  child: (categoryVisible) ? Text('edit') : Text(
                                      'Done'),
                                  onPressed: () {
                                    setState(() {
                                      this.categoryVisible = !categoryVisible;
                                      if(this._store.category == null){
                                        this._store.category = snapshot.data.documents[0]['category'];
                                      }
                                      if(this._store.storeLocation == null){
                                        this._store.storeLocation = snapshot.data.documents[0]['storeLocation'];
                                      }

                                    });

                                    Map<String,dynamic> profileData={'image':this._profile.image,'fullname':this._profile.fullName,'contact':this._profile.contact,'storename':this._store.storeName,'storeLocation':this._store.storeLocation,'category':this._store.category};
                                    createProfile.updateData(context,profileData);
                                  }
                              ),
                            ],
                          ),

                          (categoryVisible) ?

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              snapshot.data.documents[0]['category'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ) :
                          FormField(

                          builder: (context) {
                            return CategoryDropDownField(
                              selectedCategory: this._category,
                              onChanged: (newCategory) {
                                setState(() {
                                  this._store.category = newCategory;

                                  this._category = newCategory;
                                });
                              },
                            );

                          }),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: RaisedButton(
                              color: Colors.deepOrange,
                              child: Text("Done",
                                style:TextStyle(
                                  color:Colors.white,
                                ),
                              ),
                              onPressed:()async{
                                if(this._store.storeLocation == null){
                                  this._store.storeLocation = snapshot.data.documents[0]['storeLocation'];
                                }
                                if(this._store.category == null){
                                  this._store.category = snapshot.data.documents[0]['category'];
                                }

                                if(_image != null) {
                                  uploadPic(context);
                                  final ref = FirebaseStorage.instance.ref().child(_downloadURL);
                                  _profile.image = await ref.getDownloadURL();
                                  Map<String,dynamic> profileData={'image':this._profile.image,'fullname':this._profile.fullName,'contact':this._profile.contact,'storename':this._store.storeName,'storeLocation':this._store.storeLocation,'category':this._store.category};
                                  createProfile.updateData(context,profileData);
                                }

                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed('/order');
                              }
                            ),
                          )


                        ],

                      ),
                    ),
                  ),
                ),
          ),
        );
      }
    );
  }


  void _onFormChange() {
    if (_formChanged) return;
    setState(() {
      _formChanged = true;
    });
  }
}