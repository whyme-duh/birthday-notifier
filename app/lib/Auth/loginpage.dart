import 'package:app/Auth/AuthService.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({required this.toggleView});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String email = '';

  String password = '';
  String error = '';
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
              top: size.height * 0.01,
              child: Image(
                  image: AssetImage('assets/icon/logo.png'),
                  width: size.width * 0.8,
                  height: size.height * 0.30)),
          Positioned(
            top: size.height * 0.30,
            child: Center(
                child: Container(
                    height: size.height * 0.65,
                    width: size.width * 0.8,
                    child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                child: Text(
                                  "Login Now",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black)),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              TextFormField(
                                validator: (val) => val!.isEmpty
                                    ? "This field cannot be empty."
                                    : null,
                                decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Enter your email",
                                  labelText: "Email",
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  validator: (val) => val!.isEmpty
                                      ? "This field cannot be empty."
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
                                    labelText: "Password",
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Forgot Password? / ",
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: WhiteFontColor)),
                                  ),
                                  Text("Reset",
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.black,
                                      )))
                                ],
                              ),
                              SizedBox(height: 60),
                              InkWell(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      if (!mounted) {
                                        return;
                                      }
                                      isLoading = true;
                                      SpinKitChasingDots(
                                        color: Colors.black,
                                      );
                                    });
                                    dynamic result =
                                        await _auth.signInEmailPassword(
                                            email.trim(), password);
                                    if (result == null) {
                                      setState(() {
                                        Fluttertoast.showToast(
                                            backgroundColor: Colors.red,
                                            msg:
                                                "Given Credentials does not match. Try Again!");
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  width: size.width * 0.8,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: loginBtnColor),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "SIGN IN ",
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.black)),
                                    ),
                                  ),
                                ),
                              ),
                            ])))),
          ),
          Positioned(
            top: size.height * 0.8,
            child: InkWell(
              onTap: () {
                widget.toggleView();
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Text(
                          "If you are new / ",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: WhiteFontColor)),
                        ),
                        Text("Create New",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.black,
                            )))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
