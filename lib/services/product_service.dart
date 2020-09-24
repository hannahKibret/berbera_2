import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class ProductService {

  final CollectionReference supplierCollection = Firestore.instance.collection(
      'supplierData');
  final db = Firestore.instance;
  AuthService auth = AuthService();

  Future addData(offerData) async {
    final uid = await auth.getCurrentUID();
    await supplierCollection.document(uid).collection('product').add(offerData);
  }

  //Get
  Stream<QuerySnapshot> getProduct(BuildContext context) async* {
    final uid = await auth.getCurrentUID();
    await supplierCollection.document(uid).collection('product').getDocuments();
  }

  Future deleteOffer(BuildContext context,uiid) async{
    final uid = await auth.getCurrentUID();
    supplierCollection.document(uid).collection('product').document(uiid).delete();

  }

}