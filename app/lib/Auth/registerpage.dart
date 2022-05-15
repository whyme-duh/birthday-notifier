import 'package:app/Auth/AuthService.dart';
import 'package:app/Database/detailDB.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  RegisterPage({required this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  DetailDB _detailDb = DetailDB(collectionName: "asdf");

  var DateController = MaskTextInputFormatter(
      mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});

  bool Isanimation = false;
  bool isLoading = false;
  String username = '';
  String Dob = '';
  String email = '';
  String password = '';
  String error = '';
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.05,
              left: size.width * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.black)),
                  Text(
                    "Register Your Account",
                    style: GoogleFonts.baiJamjuree(
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            Positioned(
                top: size.height * 0.2,
                left: size.height * 0.05,
                child: Center(
                  child: Container(
                      height: size.height * 0.5,
                      width: size.width * 0.8,
                      // color:Colors.grey[100],
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? "Enter email" : null,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  hintText: "Enter username",
                                  labelText: "Username"),
                              onChanged: (val) {
                                setState(() {
                                  username = val;
                                });
                              },
                            ),
                            TextFormField(
                              inputFormatters: [DateController],
                              keyboardType: TextInputType.datetime,
                              validator: (val) =>
                                  val!.isEmpty ? "Enter email" : null,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  hintText: "YYYY-MM-DD",
                                  labelText: "Date Of Birth"),
                              onChanged: (val) {
                                setState(() {
                                  Dob = val;
                                });
                              },
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? "Enter email" : null,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  hintText: "Enter Email",
                                  labelText: "Email"),
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                            ),
                            TextFormField(
                                validator: (val) => val!.length < 6
                                    ? "Password does not match"
                                    : null,
                                obscureText: _isHidden,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isHidden = !_isHidden;
                                      });
                                    },
                                    icon: _isHidden
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "Enter Password",
                                  labelText: "PASSWORD",
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                }),
                            InkWell(
                              onTap: () async {
                                if (DateController.getMaskedText() != null &&
                                    _formKey.currentState!.validate()) {
                                  _detailDb.takeDetail(username, Dob);

                                  setState(() {
                                    isLoading = true;
                                  });
                                  // it will use the method create in authentication file , where email and password are passed as parameters
                                  dynamic result =
                                      await _auth.registerWithEmailPassword(
                                          email.trim(), password.trim());
                                  if (result == null) {
                                    setState(() {
                                      Isanimation = false;
                                      isLoading = false;
                                      error = "Enter valid email";
                                    });
                                  }
                                }
                                await Future.delayed(Duration(seconds: 1));
                              },
                              child: Container(
                                width: size.width * 0.8,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: BtnColor,
                                    borderRadius: BorderRadius.circular(
                                        Isanimation ? 20 : 8)),
                                alignment: Alignment.center,
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: FontColor,
                                      letterSpacing: 0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
