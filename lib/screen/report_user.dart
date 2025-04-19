import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

class ReportUserScreen extends StatelessWidget {
  final String dataValue = """
  <h2>Report a User</h2>
  <p>If you come across any inappropriate behavior, suspicious profiles, or content that violates our community guidelines, you can report the user directly through their profile.</p>

  <h3>How to Report:</h3>
  <ol>
    <li>Go to the profile of the user you want to report.</li>
    <li>Tap the <strong>three vertical dots</strong> located in the top-right corner of their profile.</li>
    <li>Select the <strong>"Report User"</strong> option from the menu.</li>
    <li>Choose a reason and submit your report.</li>
  </ol>

  <p>Once your report is submitted, our moderation team will carefully review the information. If the user is found violating our terms, we may take necessary action, including account suspension or removal.</p>

  <p>Your safety and experience on Agraseva is our top priority. Thank you for helping us keep the platform respectful and secure for everyone.</p>
  """;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          "Report a User",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Html(data: dataValue),
        ),
      ),
    );
  }
}
