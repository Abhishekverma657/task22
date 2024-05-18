import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User signed up successfully!');
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User logged in successfully!');
    } catch (e) {
      print('Error logging in: $e');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    print('User logged out successfully!');
  }
}
