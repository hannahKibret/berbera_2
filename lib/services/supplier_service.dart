import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class SupplierService{

  final CollectionReference supplierCollection = Firestore.instance.collection('supplierData');
  final db = Firestore.instance;
  AuthService auth = AuthService();

  Future addData(profileData,uid) async{
    await db.collection('supplierData').document(uid).collection('profile').document('1').setData(profileData);

  }

  //Get
  Stream<QuerySnapshot> getSupplier(BuildContext context) async*{

    final uid = await auth.getCurrentUID();
    yield*  supplierCollection.document(uid).collection('profile').snapshots();
  }

  Stream<QuerySnapshot> getOrder(BuildContext context) async*{

    final uid = await auth.getCurrentUID();
    yield*  supplierCollection.document(uid).collection('order').snapshots();
  }



  //Update
  Future updateData(BuildContext context,profileData) async{
    final uid = await auth.getCurrentUID();
  supplierCollection.document(uid).collection('profile').document('1').updateData(profileData);



    //updateData(profileData).then((result){}).catchError((e){print(e);});
  }
}