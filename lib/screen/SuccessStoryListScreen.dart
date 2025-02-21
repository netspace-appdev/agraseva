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

class SuccessStoryListScreen extends StatefulWidget {
  @override
  _SuccessStoryListScreenState createState() => _SuccessStoryListScreenState();
}

class _SuccessStoryListScreenState extends State<SuccessStoryListScreen> {
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
    final uri = Uri.parse(Constant.base_url + '/agraapi/getSuccessStory');

    await http.post(uri).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print("getSuccessStory");
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

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: kRedColor,
        title: Text(
          "Success Story",
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


            child: GridView.builder(
              itemCount: memberList!.length,
              itemBuilder: (context, index) {
                return FeaturedItem(
                  result: memberList![index],
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.05,
              ),
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
        /*height: 280.0,*/
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
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                          Constant.base_url +
                              '/uploaded/matri/' +
                              result.profilePic.toString(),
                          /*color: Colors.black.withOpacity(0.1),
                                  colorBlendMode: BlendMode.darken,*/
                          fit: BoxFit.cover,
                          height: 120,
                          width: MediaQuery.of(context).size.width),
                    ),
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
