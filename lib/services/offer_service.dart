import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class OfferService {

  final CollectionReference supplierCollection = Firestore.instance.collection(
      'supplierData');
  final db = Firestore.instance;
  AuthService auth = AuthService();

  Future addData(offerData) async {
    final uid = await auth.getCurrentUID();
    await supplierCollection.document(uid).collection('offer').add(offerData);
  }

  //Get
  Stream<QuerySnapshot> getoffer(BuildContext context) async* {
    final uid = await auth.getCurrentUID();
    yield* supplierCollection.document(uid).collection('offer').snapshots();
  }

  Future deleteOffer(BuildContext context,uiid) async{
    final uid = await auth.getCurrentUID();
    supplierCollection.document(uid).collection('offer').document(uiid).delete();



    //updateData(profileData).then((result){}).catchError((e){print(e);});
  }

}
