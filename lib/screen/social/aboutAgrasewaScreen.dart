import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutAgraSewaScreen extends StatefulWidget {
  const AboutAgraSewaScreen({super.key});

  @override
  State<AboutAgraSewaScreen> createState() => _AboutAgraSewaScreenState();
}

class _AboutAgraSewaScreenState extends State<AboutAgraSewaScreen> {
  final String dataValue = """
<h2>About Agraseva</h2>

<p>
<strong>Agraseva</strong> is a dedicated matrimonial platform for the Agarwal community, designed to help eligible bachelors and bachelorettes find their ideal life partners. Our mission is to strengthen community bonds by offering a seamless, reliable, and trusted matchmaking experience.
</p>

<p>
We provide a space where individuals can advertise their profiles and connect with potential matches. In addition, we assist families in arranging meetings and building strong, meaningful, and lasting relationships.
</p>

<p>
Our goal is to offer a secure and trustworthy matchmaking experience, ensuring that brides and grooms have the best opportunities and resources to find compatible partners. Agraseva.com aligns with the evolving needs of modern matchmaking while preserving cultural values, serving Indian bachelors both within India and abroad.
</p>

<hr/>


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
          "About Agrasewa",
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
        child:  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ABOUT CONTENT
            Html(data: dataValue),

            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: ContactInfoCard(
                    icon: Icons.call,
                    title: "Contact Us",
                    content: Column(
                      children: [
                        Text("9755739106",
                            style: TextStyle(color: Colors.black,fontSize: 12)),
                        SizedBox(height: 3),
                        Text("7987127780",
                            style: TextStyle(color: Colors.black,fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ContactInfoCard(
                    icon: Icons.email,
                    title: "Email",
                    content: Text(
                      "agraseval1@gmail.com",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black,fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            /// 🔹 ADDRESS (FULL WIDTH)
            const ContactInfoCard(
              icon: Icons.location_on,
              title: "Address",
              content: Center(
                child: Text(
                  "204/13 vyas nagar community hall Near Rishi Nagar, Ujjain,"
                      "Madhya Pradesh"
                      "456010",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                   // height: 1.4,
                  ),
                ),
              ),
            ),
          /// CONTACT SECTION
          ],
        ),
      ),
    ),

    ),
    );
  }

}
class ContactInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget content;

  const ContactInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(icon, size: 30, color: Colors.red),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          content,
        ],
      ),
    );
  }
}
