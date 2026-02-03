import 'package:flutter/material.dart';

import '../../utils/constant.dart';

class NewAndEventScreen extends StatefulWidget {
  const NewAndEventScreen({super.key});

  @override
  State<NewAndEventScreen> createState() => _NewAndEventScreenState();
}

class _NewAndEventScreenState extends State<NewAndEventScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: kRedColor,
        title: Text(
          "News & Event",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            )),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 5, // replace with API length
        itemBuilder: (context, index) {
          return _eventCard();
        },
      ),
    );
  }

  Widget _eventCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Event Image
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.network(
              'https://www.agraseva.com/images/event.jpg', // replace later
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey.shade300,
                child: const Icon(Icons.image, size: 60),
              ),
            ),
          ),

          /// Event Details
          const Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'HIGH PROFILE EVENT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'A High Profile Event 2021 done by www.agraseva.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'READ MORE >',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
