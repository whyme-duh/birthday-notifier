import 'package:app/Auth/loginpage.dart';
import 'package:app/Auth/registerpage.dart';
import 'package:flutter/cupertino.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignIn = true;

  void toggleView() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isSignIn
            ? LoginPage(toggleView: toggleView)
            : RegisterPage(toggleView: toggleView));
  }
}
