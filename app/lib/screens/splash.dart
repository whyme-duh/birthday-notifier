import 'package:app/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navtowrapper();
  }

  _navtowrapper() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Wrapper()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image(image: AssetImage('assets/icon/logo.png')),
        ),
      ),
    );
  }
}
