import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> singIn(email, password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Singed in';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> singOut() async {
    await _firebaseAuth.signOut();
  }
}
