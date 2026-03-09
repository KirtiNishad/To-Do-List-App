import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {

  Future<UserCredential> registerUser(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("User Registered Successfully");

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  Future<UserCredential> loginUser(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("Login Successful");

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}