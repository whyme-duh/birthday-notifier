import 'package:app/Auth/AuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

var id = Uuid();

class DetailDB{

  final String NameId = id.v1();
  final String? collectionName;

  DetailDB({required this.collectionName});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool haveData = false;

  AuthService _auth = AuthService();


  Future UpdateUserData() async{
    
  }
  Future createCollection() async{
    _firestore.collection(collectionName!);
  }

  Future takeDetail(String name, String date)async {

    // creates a database on the name of details 
    _firestore.collection("collectionName").doc(NameId).set(
      {'Name' : name,
        "Date" : date,
        "createdAt" : DateTime.now()
      }
    );
  }

  void updateDetail(String NewName , String newDate){

    _firestore.collection("collectionName").doc(NameId).update({
      "Name": NewName,
      "Date" : newDate,
    });
    
  }

  
  bool checkIfExist() {
    _firestore.collection("collectionName").doc(NameId).get()
    .then((DocumentSnapshot snapshot){
      if (snapshot.exists){
        haveData = true;
      }
      else{
        haveData = false;
      }
    });
    return true;
  }

  
}