import 'package:app/Auth/AuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

var id = Uuid();

class DetailDB {
  final String NameId = id.v1();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool haveData = false;

  AuthService _auth = AuthService();

  Future UpdateUserData() async {}

  Future takeDetail(String uid, String name, String date) async {
    // creates a database on the name of details
    _firestore
        .collection("UserData")
        .doc(uid)
        .collection("FriendList")
        .add({'Name': name, "Date": date, "createdAt": DateTime.now()});
  }

  void updateDetail(String uid, String token, String newName, String newDate) {
    _firestore
        .collection("UserData")
        .doc(uid)
        .collection("FriendList")
        .doc(token)
        .update({
      "Name": newName,
      "Date": newDate,
    });
  }
}
