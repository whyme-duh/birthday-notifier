import 'package:app/Auth/AuthService.dart';
import 'package:app/Database/detailDB.dart';
import 'package:app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  RegisterPage({required this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  DetailDB _detailDb = DetailDB();

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
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: size.height * 0.001,
              child: Align(
                  alignment: Alignment.center,
                  child: Image(
                      image: AssetImage('assets/icon/logo.png'),
                      width: size.width * 0.8,
                      height: size.height * 0.30)),
            ),
            Positioned(
                top: size.height * 0.2,
                left: size.height * 0.05,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                        height: size.height * 0.85,
                        width: size.width * 0.8,
                        // color:Colors.grey[100],
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                maxLength: 10,
                                validator: (val) =>
                                    val!.isEmpty ? "Enter username" : null,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    hintText: "Enter username",
                                    counterText: "",
                                    labelText: "Username"),
                                onChanged: (val) {
                                  setState(() {
                                    username = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                inputFormatters: [DateController],
                                keyboardType: TextInputType.datetime,
                                validator: (val) =>
                                    val!.isEmpty ? "Enter date of birth" : null,
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
                              SizedBox(
                                height: 30,
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
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                  validator: (val) => val!.length < 8
                                      ? "Password must not be less than 8 characters"
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
                              SizedBox(
                                height: 60,
                              ),
                              InkWell(
                                onTap: () async {
                                  var hasInternet =
                                      await InternetConnectionChecker()
                                          .hasConnection;
                                  if (hasInternet) {
                                    if (_formKey.currentState!.validate()) {
                                      // final uid = await Provider.of(context)
                                      //     .auth
                                      //     .getCurrentUID();
                                      // _detailDb.takeDetail(uid, username, Dob);

                                      setState(() {
                                        isLoading = true;
                                      });
                                      // it will use the method create in authentication file , where email and password are passed as parameters
                                      // dynamic result =
                                      //     await _auth.registersiWithEmailPassword(
                                      //         username,
                                      //         email.trim(),
                                      //         password.trim());
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child: SpinKitDualRing(
                                                  color: Colors.deepPurple),
                                            );
                                          });
                                      dynamic result = await _auth.SignUpUser(
                                          email: email.trim(),
                                          password: password.trim(),
                                          username: username,
                                          dob: Dob);
                                      if (result == null) {
                                        setState(() {
                                          Isanimation = false;
                                          isLoading = false;
                                          error = "Enter valid email";
                                        });
                                      }
                                    }
                                    await Future.delayed(Duration(seconds: 1));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "No Internet! Try Again Later. ",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  ScaffoldMessenger.of(context)
                                                      .clearSnackBars();
                                                },
                                                child:
                                                    Icon(Icons.close_rounded))
                                          ],
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.fixed,
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                },
                                child: Container(
                                  width: size.width * 0.8,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: loginBtnColor,
                                      borderRadius: BorderRadius.circular(
                                          Isanimation ? 20 : 8)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "REGISTER",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Already Have An Account? / ",
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: WhiteFontColor)),
                                      ),
                                      Text("Sign In",
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.black,
                                          ))),
                                    ],
                                  ),
                                  onTap: () {
                                    widget.toggleView();
                                  })
                            ],
                          ),
                        )),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
