import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signWithEmail(String _email, String _password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      String uid = result.user.uid;
      return uid;
    } catch (e) {
      print('error' + e.toString());
      return null;
    }
  }

  Future signWithNewEmail(String _email, String _password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      return result.user.uid;
    } catch (e) {
      print('error' + e.toString());
      return null;
    }
  }
}
