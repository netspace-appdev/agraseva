
import 'package:agraseva/screen/SplashScreen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constant.prefs = await SharedPreferences.getInstance();
 // await Firebase.initializeApp();
  try {
    await Firebase.initializeApp(
    //  options: DefaultFirebaseOptions.currentPlatform,
    );
    print("initialize Firebase: ");

    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    // set observer
    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
  } catch(e) {
    print("Failed to initialize Firebase: $e");
  }




  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(
          analytics: FirebaseAnalytics.instance,
        ),
      ],
      theme: ThemeData(
       primarySwatch: Colors.red,
      ),
      home: SplashScreen(),
    );
  }
}

