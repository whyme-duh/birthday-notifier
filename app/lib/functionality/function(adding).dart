import 'package:app/Auth/AuthService.dart';
import 'package:app/Database/detailDB.dart';
import 'package:app/testing/tst.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uuid/uuid.dart';

import '../Widgets/provider_widget.dart';

void addDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  var size = MediaQuery.of(context).size;
  var NameController = MaskTextInputFormatter(
      mask: '################', filter: {"#": RegExp(r'[A-Z a-z]')});
  var DateController = MaskTextInputFormatter(
      mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});
  var id = Uuid();
  final String NameId = id.v1();

  AuthService _auth = AuthService();

  DetailDB _detailDb = DetailDB();

  String name = "";
  String date = "";
  // function to add the new friend birthday
  var alert = AlertDialog(
      title: Column(
        children: [
          Text(
            "Add Your Friend's Birthday",
            style: TextStyle(
                fontSize: 15, letterSpacing: 2, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Text("NOTE: PROPER DATE TO BE PROVIDED.",
              style: TextStyle(
                  fontSize: 8, letterSpacing: 2, fontWeight: FontWeight.w700))
        ],
      ),
      content: Container(
        width: size.width,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextFormField(
                textCapitalization: TextCapitalization.words,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "The field cant be empty";
                  }
                  return null;
                },
                onChanged: (val) {
                  name = val;
                },
                inputFormatters: [NameController],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Friend Name",
                  labelText: "Name",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                inputFormatters: [DateController],
                keyboardType: TextInputType.datetime,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "The field cant be empty";
                  }
                  return null;
                },
                onChanged: (val) {
                  date = val;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "YYYY-MM-DD",
                    labelText: "FRIEND'S DOB"),
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
                      child: Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.red),
                      )),
                  TextButton(
                      onPressed: () async {
                        String uid = await _auth.getUserUID();
                        AgeDifffernce(date);
                        birthdayOrNot(date);
                        RemainingDaysForBirthday(date);

                        if (_formKey.currentState!.validate() &&
                            validateDate(date)) {
                          _detailDb.takeDetail(uid, name, date);
                          Fluttertoast.showToast(msg: "DETAIL HAS BEEN ADDED");
                          Navigator.pop(context);
                        } else {
                          await Fluttertoast.showToast(
                              msg: "DETAIL YOU HAVE PROVIDED IS INCORRECT");
                          Navigator.pop(context);
                        }
                      },
                      child: Text("ADD"))
                ],
              )
            ],
          ),
        ),
      ));
  showDialog(context: context, builder: (context) => alert);
}

void deleteDialog(BuildContext context, document) {
  var alert = AlertDialog(
      title: Column(
    children: [
      Text("Are you sure you want to Delete this?",
          style: TextStyle(fontSize: 15)),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .runTransaction((Transaction transaction) async {
                  transaction.delete(document.reference);
                  Navigator.pop(context);

                  return Fluttertoast.showToast(
                      msg: "The Data has Been Deleted");
                });
              },
              child: Text("YES")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "NO",
                style: TextStyle(color: Colors.red),
              )),
        ],
      )
    ],
  ));
  showDialog(context: context, builder: (context) => alert);
}


// showModalBottoamSheet(
          // context: context,
          // builder: (context) {
          //   return Expanded(
          //     child: Padding(
          //         padding: EdgeInsets.all(20),
          //         child: Column(
          //             mainAxisSize:
          //                 MainAxisSize.max,
          //             mainAxisAlignment:
          //                 MainAxisAlignment
          //                     .spaceBetween,
          //             children: [
          //               Column(
          //                 children: [
          //                   Text(
          //                     "Add Your Friend's Birthday",
          //                     style: TextStyle(
          //                         fontSize: 20,
          //                         letterSpacing: 2,
          //                         fontWeight:
          //                             FontWeight
          //                                 .w800),
          //                   ),
          //                   SizedBox(height: 10),
          //                   Text(
          //                       "NOTE: PROPER DATE TO BE PROVIDED.",
          //                       style: TextStyle(
          //                           fontSize: 10,
          //                           letterSpacing:
          //                               2)),
          //                 ],
          //               ),
          //               SizedBox(
          //                 height: 50,
          //               ),
          //               Column(
          //                 mainAxisSize:
          //                     MainAxisSize.max,
          //                 mainAxisAlignment:
          //                     MainAxisAlignment
          //                         .spaceBetween,
          //                 children: [
          //                   Container(
          //                     child: Form(
          //                       key: _formKey,
          //                       child: Column(
          //                         mainAxisSize:
          //                             MainAxisSize
          //                                 .max,
          //                         mainAxisAlignment:
          //                             MainAxisAlignment
          //                                 .spaceBetween,
          //                         children: <
          //                             Widget>[
          //                           TextFormField(
          //                             validator:
          //                                 (val) {
          //                               if (val!
          //                                   .isEmpty) {
          //                                 return "The field cant be empty";
          //                               }
          //                             },
          //                             onChanged:
          //                                 (val) {
          //                               name = val
          //                                   .toUpperCase();
          //                             },
          //                             inputFormatters: [
          //                               NameController
          //                             ],
          //                             decoration:
          //                                 InputDecoration(
          //                               border:
          //                                   OutlineInputBorder(),
          //                               hintText:
          //                                   "Friend Name",
          //                               labelText:
          //                                   "Name",
          //                             ),
          //                           ),
          //                           SizedBox(
          //                             height: 10,
          //                           ),
          //                           TextFormField(
          //                             inputFormatters: [
          //                               DateController
          //                             ],
          //                             keyboardType:
          //                                 TextInputType
          //                                     .datetime,
          //                             validator:
          //                                 (val) {
          //                               if (val!
          //                                   .isEmpty) {
          //                                 return "The field cant be empty";
          //                               }
          //                             },
          //                             onChanged:
          //                                 (val) {
          //                               date = val;
          //                             },
          //                             decoration: InputDecoration(
          //                                 border:
          //                                     OutlineInputBorder(),
          //                                 hintText:
          //                                     "YYYY-MM-DD",
          //                                 labelText:
          //                                     "FRIEND'S DOB"),
          //                           ),
          //                           SizedBox(
          //                             height: 20,
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                   Row(
          //                     mainAxisAlignment:
          //                         MainAxisAlignment
          //                             .spaceAround,
          //                     children: [
          //                       TextButton(
          //                           onPressed: () {
          //                             Navigator.pop(
          //                                 context);
          //                           },
          //                           child: Text(
          //                               "CANCEL")),
          //                       TextButton(
          //                           onPressed:
          //                               () async {
          //                                 String uid = await _auth.getUserUID();
          //                             AgeDifffernce(
          //                                 date);
          //                             birthdayOrNot(
          //                                 date);
          //                             RemainingDaysForBirthday(
          //                                 date);

          //                             if (NameController.getMaskedText() != null &&
          //                                 DateController
          //                                         .getMaskedText() !=
          //                                     null &&
          //                                 _formKey
          //                                     .currentState!
          //                                     .validate() &&
          //                                 validateDate(
          //                                     date)) {
          //                               _detailDb
          //                                   .takeDetail(
          //                                     uid,
          //                                       name,
          //                                       date);
          //                               Fluttertoast
          //                                   .showToast(
          //                                       msg:
          //                                           "DETAIL HAS BEEN ADDED");
          //                               Navigator.pop(
          //                                   context);
          //                             } else {
          //                               await Fluttertoast
          //                                   .showToast(
          //                                       msg:
          //                                           "DETAIL YOU HAVE PROVIDED IS INCORRECT");
          //                               Navigator.pop(
          //                                   context);
          //                             }
          //                           },
          //                           child:
          //                               Text("ADD"))
          //                     ],
          //                   )
          //                 ],
          //               )
          //             ])),
          //   )};