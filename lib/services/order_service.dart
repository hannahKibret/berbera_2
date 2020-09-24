import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';
import 'package:flutter/material.dart';

class OrderService{

  final CollectionReference supplierCollection = Firestore.instance.collection('supplierData');
  final db = Firestore.instance;
  AuthService auth = AuthService();

  Stream<QuerySnapshot> getOrder(BuildContext context) async*{

    final uid = await auth.getCurrentUID();
    yield*  supplierCollection.document(uid).collection('order').snapshots();
  }

  Future checkDelivered(BuildContext context) async{
    final uid = await auth.getCurrentUID();
    await supplierCollection.document(uid).collection('order').where('progress',isEqualTo: 'Delivered').getDocuments().then((snapshots){
      for(DocumentSnapshot ds in snapshots.documents){
        ds.reference.delete();
      }
    });


  }

}