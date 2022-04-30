import 'package:app/Database/detailDB.dart';
import 'package:app/testing/tst.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uuid/uuid.dart';

import 'friendlist.dart';

void updateDialog(BuildContext context, String newName, String newDate) {
  var id = Uuid();
  final String NameId = id.v1();

  DetailDB _detailDb = DetailDB(collectionName: 'asdf');

  var snapshot = FirebaseFirestore.instance.collection("Details").snapshots();
  final _formKey = GlobalKey<FormState>();
  var NameController = MaskTextInputFormatter(
      mask: '################', filter: {"#": RegExp(r'[A-Z a-z]')});
  var DateController = MaskTextInputFormatter(
      mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});

  String name = newName;
  String date = newDate;
  // function to add the new friend birthday
  var alert = AlertDialog(
      title: Text("Update Friend's Birthday"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextFormField(
              validator: (val) {
                if (val!.isEmpty) {
                  return "The field cant be empty";
                }
              },
              onChanged: (val) {
                name = val.toUpperCase();
              },
              inputFormatters: [NameController],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: name,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              inputFormatters: [DateController],
              keyboardType: TextInputType.datetime,
              validator: (val) {
                if (val!.isEmpty) {
                  return "The field cant be empty";
                }
              },
              onChanged: (val) {
                date = val;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: date,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("CANCEL")),
                TextButton(
                    onPressed: () async {
                      //deleting the old data

                      AgeDifffernce(date);
                      birthdayOrNot(date);
                      RemainingDaysForBirthday(date);

                      if (NameController.getMaskedText() != null &&
                          DateController.getMaskedText() != null &&
                          _formKey.currentState!.validate()) {
                        _detailDb.updateDetail(name, date);
                      }
                      Fluttertoast.showToast(msg: "DEATIL HAS BEEN UPADTED");
                      Navigator.pop(context);
                    },
                    child: Text("UPDATE"))
              ],
            )
          ],
        ),
      ));
  showDialog(context: context, builder: (context) => alert);
}
