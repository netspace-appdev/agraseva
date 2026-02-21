import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final String dataValue = """
  <h2>Privacy Policy – Agraseva Matrimonial App</h2>
  <p><strong>Effective Date:</strong> 14-04-2025</p>

  <h3>1. About Our App:</h3>
  <p>Agraseva is a matrimonial platform developed for the Agrawal community. It facilitates eligible boys and girls to find suitable matches within the community. The app is exclusively for Indian citizens of the Agrawal caste who meet the age requirements.</p>

  <h3>2. Eligibility:</h3>
  <ul>
    <li>Must belong to the Agrawal community</li>
    <li>Males: Minimum 21 years old</li>
    <li>Females: Minimum 18 years old</li>
    <li>Must be an Indian citizen</li>
  </ul>
  <p>We reserve the right to terminate access if any submitted information is found to be false or misleading.</p>

  <h3>3. How We Verify a Profile:</h3>
  <p>Every profile submitted on the Agraseva platform is carefully reviewed and moderated by our dedicated admin team.</p>
  <p>We take multiple steps to ensure the authenticity of each profile, including:</p>
  <ul>
    <li>Manual verification of profile data</li>
  <li>Direct phone communication with the profile owner</li>
  <li>Monitoring for any suspicious activity or incomplete/misleading details</li>
  <li>Collection of identification documents from the user for verification</li>
  <li>Verification of the user’s identity with a known member of the Agrawal community in the same city</li>
  </ul>
  <p>Profiles that are flagged as suspicious or found to be fraudulent will not be approved and may be permanently blocked from the platform. Our verification process is designed to maintain trust and ensure genuine matchmaking for our community.</p>

  <h3>4. Information We Collect:</h3>
  <ul>
    <li>Personal details: name, gender, date of birth, caste, marital status</li>
    <li>Profile details: education, occupation, family background, photos</li>
    <li>Contact details: phone number, email address</li>
  </ul>

  <h3>5. How We Use Your Information:</h3>
  <ul>
    <li>Create and manage your profile</li>
    <li>Match users with suitable partners</li>
    <li>Facilitate communication between members</li>
    <li>Improve features and user experience</li>
    <li>Provide customer support</li>
    <li>Prevent misuse or fraudulent activity</li>
  </ul>

  <h3>6. Data Sharing:</h3>
  <ul>
    <li>We do not sell or rent user data</li>
    <li>Information may be shared with other users during matchmaking</li>
    <li>May be shared with service providers for hosting, analytics, or support (e.g., Firebase)</li>
    <li>May be shared with law enforcement when legally required</li>
  </ul>

  <h3>7. Public Visibility:</h3>
  <p>Your profile may be visible to other registered users. Do not share personal or sensitive data that you want to keep private.</p>

  <h3>8. Data Security:</h3>
  <p>We use reasonable security practices to protect your data. However, no method is 100% secure. Use the app responsibly.</p>

  <h3>9. User Rights:</h3>
  <ul>
    <li>Access and update your profile</li>
    <li>Request account and data deletion</li>
    <li>Contact support for privacy-related queries</li>
  </ul>

  <h3>10. Cookies & Tracking:</h3>
  <p>The app may use analytics tools that track usage via cookies or device identifiers for improving user experience.</p>

  <h3>11. Children’s Privacy:</h3>
  <p>This app is not intended for children under 18. We do not knowingly collect data from minors.</p>

  <h3>12. Changes to This Policy:</h3>
  <p>We may update the policy periodically. Any changes will be updated within the app. Continued use of the app implies acceptance of the updated policy.</p>

  <h3>13. Contact Us:</h3>
  <ul>
    <li><strong>Email:</strong> agraseva1@gmail.com, gmittal689@gmail.com</li>
    <li><strong>Call:</strong> 9755739106, 7987127780</li>
    <li><strong>Website:</strong> www.agraseva.com</li>
    <li><strong>Address:</strong> 204/13 vyas nagar community hall Near Rishi Nagar , Ujjain, Madhya Pradesh, 456010</li>
  </ul>

  <h3>14. For Account Deletion:</h3>
  <p>If you want to delete your account or remove your personal data, please contact us at:</p>
  <ul>
    <li><strong>Email:</strong> agraseva1@gmail.com, gmittal689@gmail.com</li>
    <li><strong>Call:</strong> 9755739106, 7987127780</li>
    <li><strong>Website:</strong> www.agraseva.com</li>
    <li><strong>Address:</strong> 204/13 vyas nagar community hall Near Rishi Nagar, Ujjain, Madhya Pradesh, 456010</li>
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
          "Privacy Policy",
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
