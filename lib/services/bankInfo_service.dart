import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase/src/firestore.dart';

class BankInfoService{
  final db = Firestore.instance;

  Future<void> addData(bankData,uid) async{
    //Firestore.instance.collection('bankInfo').add(bankData).catchError((e){print(e);});
    await db.collection('supplierData').document(uid).collection('bankInfo').document('1').setData(bankData);

  }
}