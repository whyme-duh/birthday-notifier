import 'package:app/Auth/loginpage.dart';
import 'package:app/Database/detailDB.dart';
import 'package:app/Models/user.dart';
import 'package:app/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSign = GoogleSignIn();
  final String NameId = id.v1();

  Future<String> SignUpUser(
      {required String email,
      required String password,
      required String username,
      required String dob}) async {
    String result = "Error has been occured";
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          password.isNotEmpty ||
          dob.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        _firestore.collection("Users").doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'dob': dob
        });
        result = "sucess";
      }
    } catch (err) {
      result = err.toString();
      return result;
    }
    return result;
  }

  UserProfile? _userFromFirebaseUser(User user) {
    return user != null
        ? UserProfile(
            uid: user.uid,
          )
        : null;
  }

  Future<String> getUserUID() async {
    return (await _auth.currentUser!).uid;
  }

  Future getCurrentUser() async {
    return (await _auth.currentUser);
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

  // Future registerWithEmailPassword(
  //     String name, String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     User? newUser = result.user;
  //     newUser?.updateDisplayName(name);

  //     return _userFromFirebaseUser(newUser);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void main() {
    final AuthService _auth = AuthService();
    print(_auth.getUserUID());
  }

  Future<void> signOutFromGmail() async {
    await _googleSign.signOut();
    await _auth.signOut();
  }
}
