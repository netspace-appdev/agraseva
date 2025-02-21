// ignore: file_names

import 'dart:convert';

import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import '../responseModel/contactus_model.dart';
import 'UserDetailScreen.dart';

class ContactusScreen extends StatefulWidget {
  @override
  _ContactusScreenState createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  List<Result>? memberList = <Result>[];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  Constant.prefs?.setBool("loggedIn", false);
    isLoading = true;
    Future.delayed(Duration.zero, () {
      this.getMemberList();
    });
  }

  Future<http.Response?> getMemberList() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi/GetContactUs');
    Map<String, String> body = {
      'ProfileID': Constant.prefs!.getString("ProfileID").toString(),
    };
    await http.post(uri, body: body).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = ContactusModel.fromJson(map);

        memberList = modelData.result;
        print("memberListsize:  " + memberList!.length.toString());
      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: kRedColor,
        title: Text(
          "Contact us",
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
      body: Container(
          decoration: BoxDecoration(
              color: Colors.white
          ),
          padding: const EdgeInsets.only(bottom: 0.0,top: 0,right: 0),

          child: Container(


            child: ListView.builder(
              itemCount: 1,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return FeaturedItem(
                  result: memberList![index],
                );
              },

              shrinkWrap: false,
              /*physics: NeverScrollableScrollPhysics(),*/
            ),
          )),
    );
  }

}

class FeaturedItem extends StatelessWidget {
  const FeaturedItem({
    Key? key,
    required this.result,
  }) : super(key: key);

  final Result result;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {

      },
      child: Container(
        height: 140.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 0.3), //(x,y)
              spreadRadius: 0.0,
              blurRadius: 2.0,
            ),
          ],
        ),
        margin: EdgeInsets.only(left: 3.0, right: 3.0, bottom: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                        Constant.base_url +
                            '/admin/contact/' +
                            result.image.toString(),
                        /*color: Colors.black.withOpacity(0.1),
                                      colorBlendMode: BlendMode.darken,*/
                        fit: BoxFit.cover,
                        height: 120,
                        width: MediaQuery.of(context).size.width),
                  ),
                ),
              ),
            ),
        Expanded(
          flex: 2,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [

               SizedBox(height: 5),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Align(
                   alignment: Alignment.centerLeft,
                   child: Text(
                       result.name.toString()  ,
                       maxLines: 1,
                       style: TextStyle(
                           color: kTextBlackColor,
                           fontSize: 14,
                           letterSpacing: 0.1,
                           height: 1.2,
                           fontWeight: FontWeight.bold)),
                 ),
               ),
               SizedBox(height: 5),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Align(
                   alignment: Alignment.centerLeft,
                   child: Row(
                     children: [
                       Text('Contact No: ',
                           maxLines: 1,
                           style: TextStyle(
                             color:  Colors.black,
                             fontSize: 12,
                             letterSpacing: 0.1,
                           )), Text(
                               ' ' +
                               result.contact.toString(),
                           maxLines: 1,
                           style: TextStyle(
                             color: kTextGreyColor,
                             fontSize: 12,
                             letterSpacing: 0.1,
                             height: 1.2,
                           )),
                     ],
                   ),
                 ),
               ),
               SizedBox(height: 5),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Align(
                   alignment: Alignment.centerLeft,

                   child:  Row(
                     children: [
                       Text('Alternate contact No: ',
                           maxLines: 1,
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 12,
                               letterSpacing: 0.1,
                               height: 1.2,
                           )), Text(
                           ' ' +
                               result.altContact.toString(),
                           maxLines: 1,
                           style: TextStyle(
                             color: kTextGreyColor,
                             fontSize: 12,
                             letterSpacing: 0.1,
                             height: 1.2,
                           )),

                     ],
                   ),
                 ),
               ),
               SizedBox(height: 5),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Align(
                   alignment: Alignment.centerLeft,

                   child:Text(
                       'Address: ' +
                           result.address.toString(),
                       maxLines: 2,
                       style: TextStyle(
                         color: Colors.black,
                         fontSize: 12,
                         letterSpacing: 0.1,
                         height: 1.2,
                       )),
                 ),
               ),
               SizedBox(height: 5),

             ],
           )),
          ],
        ),
      ),
    );
  }
}
