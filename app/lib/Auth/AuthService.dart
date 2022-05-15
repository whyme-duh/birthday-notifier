import 'package:app/Database/detailDB.dart';
import 'package:app/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

var id = Uuid();

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSign = GoogleSignIn();
  final String NameId = id.v1();

  UserProfile? _userFromFirebaseUser(User user) {
    return user != null ? UserProfile(uid: user.uid) : null;
  }

  Stream<UserProfile?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  Future<UserCredential> signInWithGoogle() async {
    // trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken,
    );

    // once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future signInEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print(user!.displayName);
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  Future registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? newUser = result.user;

      await DetailDB(collectionName: newUser!.displayName);

      return _userFromFirebaseUser(newUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOutFromGmail() async {
    await _googleSign.signOut();
    await _auth.signOut();
  }
}
