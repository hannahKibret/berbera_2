import 'package:berbera_2/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user!= null? User(uid:user.uid):null;
  }



  Stream<String> get onAuthStateChanged =>
    _auth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,

    );

  Future signInAnon() async{
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print('Error'+e.toString());
      return null;
    }

  }

  Future<String> getCurrentUID() async{

    return (await _auth.currentUser()).uid;
  }

  Future<String> getCurrentEmail() async{

    return (await _auth.currentUser()).email;
  }

  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email:email,password:password);
      FirebaseUser user = result.user;


      _userFromFirebaseUser(user);
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email:email,password:password);
      FirebaseUser user = result.user;


      _userFromFirebaseUser(user);
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}