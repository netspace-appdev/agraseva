import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

class DeleteAccountScreen extends StatelessWidget {
  final String dataValue = """
  <h2>Delete Your Agraseva Account</h2>
  <p>If you wish to delete your Agraseva account, please follow the steps below:</p>
  <ol>
    <li>Navigate to your profile section within the app.</li>
    <li>Scroll down to find the <strong>"Delete My Account"</strong> button.</li>
    <li>Click the button to initiate the account deletion process.</li>
  </ol>
  <p>Once your account is deleted, all associated personal information will be permanently removed from our database and cannot be recovered.</p>
  <p>If you face any issues, feel free to contact our support team</p>
  
  <h3>Contact Us:</h3>
  <ul>
    <li><strong>Email:</strong> agraseva1@gmail.com, gmittal689@gmail.com</li>
    <li><strong>Call:</strong> 9755739106, 7987127780</li>
    <li><strong>Website:</strong> www.agraseva.com</li>
    <li><strong>Address:</strong> B-22/11, Ved Nagar, Ujjain, Madhya Pradesh, 456010</li>
  </ul>


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
          "Delete Account",
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
