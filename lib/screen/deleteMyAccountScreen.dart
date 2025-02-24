// ignore: file_names

import 'dart:convert';

import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:http/http.dart' as http;

import '../responseModel/static_page_model.dart';
import '../widgets/MySeparator.dart';
import 'SigninScreen.dart';
import 'UserDetailScreen.dart';

class DeleteMyAccountScreen extends StatefulWidget {
  @override
  _DeleteMyAccountScreenState createState() => _DeleteMyAccountScreenState();
}

class _DeleteMyAccountScreenState extends State<DeleteMyAccountScreen> {
  List<Result>? memberList = <Result>[];

  bool isLoading = false;
  String dataValue = "";
  bool isChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  Constant.prefs?.setBool("loggedIn", false);
    // isLoading = true;
    // Future.delayed(Duration.zero, () {
    //   this.getMemberList();
    // });
  }

  Future<http.Response?> getMemberList() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi/Getstatic_page');
    Map<String, String> body = {
      'PageName': 'terms',
    };
    await http.post(uri, body: body).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print("TermsCondition");
      print(jsonData);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = StaticPageModel.fromJson(map);

        memberList = modelData.result;
        dataValue = memberList![0].content.toString();
        print("dataValue:  " + dataValue);
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
          "Delete My Account",
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
          decoration: BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(bottom: 0.0, top: 0, right: 0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Container(
                child: deleteAccountContainer(),
              ),
            ),
          )),
    );
  }

  Container deleteAccountContainer() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
              spreadRadius: 3.0,
              offset: Offset(1.0, 1.0), // shadow direction: bottom right
            )
          ],
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(
          bottom: 15.0,
          left: 15.0,
          right: 15.0,
        ),
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          children: [

            SizedBox(
              height: 15,
            ),
            //MySeparator(color: kRedColor),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We're sorry to see you go",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Just a quick reminder, deleting your account means you'll lose touch with your people.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "You'll also lose your membership.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.red,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "I acknowledge and understand the consequences of deleting my account.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: isChecked? () {
                      if(isChecked){
                        setState(() {
                          deleteAccountApi();


                        });
                      }
                    }:null,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
                      padding: EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color:isChecked? kRedColor:Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        boxShadow: [BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 0.0), //(x,y)
                          blurRadius: 1.0,
                        )],
                      ),

                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.white,
                            /*fontWeight: FontWeight.bold,*/
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
      ]

        ));
  }

  Future<http.Response?> deleteAccountApi() async {
    print("========deleteAccountApi===>");
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi/DeleteUser');
    Map<String, String> body = {
      'm_id': Constant.prefs!.getString("ProfileID").toString(),

    };
    print("requ===>${body}");
    print("URL===>${Constant.base_url + '/agraapi/DeleteUser'}");
    await http.post(uri, body: body).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      print("response===>${response.statusCode}");
      print("response===>${response.body}");

      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>SigninScreen()),
              (Route<dynamic> route) => false, // This condition always returns false, removing all routes.
        );
      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }
}
