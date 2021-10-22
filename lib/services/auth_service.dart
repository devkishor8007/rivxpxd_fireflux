import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// check user is login or not
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> loginWithEmail(
      {required String email, required String password}) async {
    try {
      final res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return res.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> createWithEmail(
      {required String email, required String password}) async {
    try {
      final res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return res.user;
    } catch (e) {
      if (e == 'email-already-in-user') {
        debugPrint("Email already use");
      } else {
        debugPrint("Error: $e");
      }
    }
  }

  logout() {
    return _auth.signOut();
  }
}
