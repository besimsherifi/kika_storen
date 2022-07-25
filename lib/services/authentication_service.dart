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
      final String message;
      print(e.code);
      print(e.message);
      switch (e.code) {
        case 'user-not-found':
          message = 'Login fehlgeschlagen, Benutzer unbekannt';
          break;
        case 'wrong-password':
          message = 'Das Passwort ist ungültig';
          break;
        case 'network-request-failed':
          message = 'Login fehlgeschlagen, Netzwerkfehler';
          break;
        case 'too-many-requests':
          message = 'Zu vielen fehlgeschlagenen Anmeldeversuchen';
          break;
        default:
          message = 'Error Login fehlgeschlagen';
      }
      return message;
    }
  }

  Future<void> singOut() async {
    await _firebaseAuth.signOut();
  }
}
