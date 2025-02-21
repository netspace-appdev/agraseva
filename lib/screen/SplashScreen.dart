import 'dart:async';
import 'package:agraseva/screen/HomeScreen.dart';
import 'package:agraseva/screen/SigninScreen.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final splashDelay = 5;

  @override
  void initState() {
    super.initState();

   _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Constant.prefs?.getBool("loggedIn") == true
        ?  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()))

    : Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SigninScreen()));

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              darkRedColor,
              kRed2Color,
              kRedColor,
              kRedColor,
            ],
          ),
        ),
        child: InkWell(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/splash.png',
                            fit: BoxFit.cover,
                           height: size.height,
                            width: size.width,
                          ),
                          ],
                      )),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}