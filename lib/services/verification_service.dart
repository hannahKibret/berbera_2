import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class VerificationService {

  final CollectionReference verificationCollection = Firestore.instance.collection(
      'verificationCode');
  final CollectionReference sentCollection = Firestore.instance.collection(
      'sentCode');
  final CollectionReference request = Firestore.instance.collection(
      'request');
  final db = Firestore.instance;
  AuthService auth = AuthService();


  //Get
  Future addCode(uid,codeData) async {

    await verificationCollection.document(uid).setData(codeData);
  }
  Stream<QuerySnapshot> getCode(BuildContext context) async* {
    yield* verificationCollection.snapshots();
  }

  Future deleteVer(BuildContext context,uid) async{
   verificationCollection.document(uid).delete();
  }

  Future addSent(uid,sentData) async {

    await sentCollection.document(uid).setData(sentData);
  }

   Stream<DocumentSnapshot> getSent(BuildContext context) async* {
    final uid = await auth.getCurrentEmail();
     yield* sentCollection.document(uid).snapshots();
  }

}
