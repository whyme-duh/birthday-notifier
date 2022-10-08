import 'package:app/Auth/AuthService.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({required this.toggleView});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String email = '';

  String password = '';
  String error = '';
  bool _isHidden = true;
  late AnimationController _controller;
  late double _scale;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
        lowerBound: 0.0,
        upperBound: 0.1)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
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
                                  "Login",
                                  style: GoogleFonts.acme(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
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
                              InkWell(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: "Opps! Maybe Later? LOL",
                                      backgroundColor: Colors.red);
                                },
                                child: Row(
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
                              ),
                              SizedBox(height: 60),
                              GestureDetector(
                                onTapDown: _tapDown,
                                onTapUp: _tapUp,
                                child: InkWell(
                                  onTap: () async {
                                    var hasInternet =
                                        await InternetConnectionChecker()
                                            .hasConnection;
                                    if (hasInternet) {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          if (!mounted) {
                                            return;
                                          }
                                          isLoading = true;
                                          SpinKitFadingCircle(
                                            size: 10,
                                            color: Colors.black,
                                          );
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Center(
                                                child: SpinKitDualRing(
                                                    color: Colors.deepPurple),
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

                                        Navigator.pop(context);
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Container(
                                          padding: EdgeInsets.all(16),
                                          height: 90,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: Stack(children: [
                                            Positioned(
                                                top: -5,
                                                child: InkWell(
                                                    onTap: () {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .clearSnackBars();
                                                    },
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ))),
                                            Positioned(
                                              top: 10,
                                              left: 0,
                                              right: 0,
                                              child: Expanded(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Icon(
                                                        Icons.error_rounded,
                                                        size: 30,
                                                        color: Colors.red,
                                                      ),
                                                      Text(
                                                        "Error! No Internet",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            letterSpacing: 2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ));
                                    }
                                  },
                                  child: Transform.scale(
                                    scale: _scale,
                                    child: Container(
                                      width: size.width * 0.6,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                ),
                              ),
                            ])))),
          ),
          Positioned(
            top: size.height * 0.85,
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
