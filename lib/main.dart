
import 'package:agraseva/screen/SplashScreen.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constant.prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
       primarySwatch: Colors.red,
      ),
      home: SplashScreen(),
    );
  }
}

