// ignore: file_names

import 'dart:convert';

import 'package:agraseva/responseModel/member_list_model.dart';
import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'UserDetailScreen.dart';

class ShortListScreen extends StatefulWidget {
  @override
  _ShortListScreenState createState() => _ShortListScreenState();
}

class _ShortListScreenState extends State<ShortListScreen> {
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

  Future<http.Response?> deleteToShortlist(String toId) async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi/DeleteMyShortlist');
    Map<String, String> body = {
      'ProfileID': toId,
      'MyProfileID': Constant.prefs!.getString("ProfileID").toString(),
    };
    print('DeleteMyShortlist');
    print(body);
    await http
        .post(
        uri,
        body: body)
        .then((http.Response response) {
      final jsonData = json.decode(response.body);

      print(jsonData);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
        getMemberList();
      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }

  Future<http.Response?> getMemberList() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi/GetMyShortlist');
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
        var modelData = MemberListModel.fromJson(map);

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

    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(bottom: 0.0, top: 0, right: 0),
          child: Container(
            child: ListView.builder(
              itemCount: memberList!.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return /* FeaturedItem(
                  result: memberList![index],
                )*/ InkWell(
                  onTap: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return UserDetailScreen(
                            profileID: memberList![index].mId,
                          );
                        }));
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
                                        '/uploaded/matri/profilepic/' +
                                        memberList![index].profilePic
                                            .toString(),
                                    /*color: Colors.black.withOpacity(0.1),
                                      colorBlendMode: BlendMode.darken,*/
                                    height: 120,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        memberList![index].fName.toString() +
                                            ' ' +
                                            memberList![index].lName.toString(),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text('Education: ',
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              letterSpacing: 0.1,
                                            )),
                                        Text(
                                            memberList![index].education
                                                .toString() != "null"
                                                ? ' ' +
                                                memberList![index].education
                                                    .toString()
                                                : "",
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text('Height: ',
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              letterSpacing: 0.1,
                                              height: 1.2,
                                            )),
                                        Text(
                                            memberList![index].height2
                                                .toString() != "null"
                                                ? ' ' +
                                                memberList![index].height2
                                                    .toString()
                                                : "",
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: kTextGreyColor,
                                              fontSize: 12,
                                              letterSpacing: 0.1,
                                              height: 1.2,
                                            )),
                                        Text('   Age: ',
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              letterSpacing: 0.1,
                                              height: 1.2,
                                            )),
                                        Text(' ' +
                                            memberList![index].age.toString(),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        memberList![index].maritialname
                                            .toString() != "null"
                                            ? 'Marital Status: ' +
                                            memberList![index].maritialname
                                                .toString()
                                            : "Marital Status: ",
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          letterSpacing: 0.1,
                                          height: 1.2,
                                        )),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text('Id: ',
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              letterSpacing: 0.1,
                                              height: 1.2,
                                            )),
                                        Text('AGRS' +
                                            memberList![index].mId.toString(),
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: kRedColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                GestureDetector(
                                    onTap: () {
                                      print(memberList![index].mId);
                                      deleteToShortlist(memberList![index].mId.toString());
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(bottom: 3.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                    )),
                                SizedBox(height: 5),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              },
              shrinkWrap: false,
              /*physics: NeverScrollableScrollPhysics(),*/
            ),
          )),
    );
  }
}


