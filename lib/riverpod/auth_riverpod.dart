import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rivxpxd_fireflux/services/auth_service.dart';

// specify the class AuthService
final authenticationProvider = Provider<AuthService>((ref) => AuthService());

// specify the authStateChanges in riverpod
// reading one riverpod from a another riverpod
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChanges;
});

// get some details of the loggedIn user
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});
