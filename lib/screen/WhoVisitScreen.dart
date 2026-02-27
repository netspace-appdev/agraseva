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

class WhoVisitScreen extends StatefulWidget {
  @override
  _WhoVisitScreenState createState() => _WhoVisitScreenState();
}

class _WhoVisitScreenState extends State<WhoVisitScreen> {
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
    final uri = Uri.parse(Constant.base_url + '/agraapi/GetWhoVisitList');
    Map<String, String> body = {
      'ProfileID': Constant.prefs!.getString("ProfileID").toString(),
    };
    print(body);
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

    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 280,
              ),
            /*  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.63,
              ),*/
              shrinkWrap: false,
              /*physics: NeverScrollableScrollPhysics(),*/
            ),
          )),
    );
  }
  Widget bottomsheet() {
    return new Scaffold(body:Container(
      height: 350,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.close_outlined, color: Colors.black38)),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Find Partner",
                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only( top: 10.0, right: 5.0,left: 5.0 ),
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(25.0)),
            ),
            child: TextFormField(
              // controller: userNameEditTextController,
                style: TextStyle(
                  /* fontFamily: "segoeregular",*/
                    fontSize: 14,
                    color: Color(0xff191847)
                ),
                decoration: InputDecoration(
                  hintText: 'enter id e.g. - 15',
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number),

          ),
          Container(

            margin: EdgeInsets.only( top: 10.0, right: 5.0,left: 5.0 ),
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(25.0)),
            ),
            child: Text(
              "From age",
              style: TextStyle(
                color: kTextBlackColor,
                fontSize: 14,
              ),
            ),

          ),
        ],
      ),
    ));
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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return UserDetailScreen(profileID: result.mId,);
        }));
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
        margin: EdgeInsets.only(left: 3.0, right: 3.0, bottom: 0.0),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                          Constant.base_url +
                              '/uploaded/matri/' +
                              result.profilePic.toString(),
                          /*color: Colors.black.withOpacity(0.1),
                                  colorBlendMode: BlendMode.darken,*/

                          height: 120,
                          width: MediaQuery.of(context).size.width),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        result.fName.toString() +
                            ' ' +
                            result.lName.toString(),
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
                        Text('Education: ',
                            maxLines: 1,
                            style: TextStyle(
                              color:  Colors.black,
                              fontSize: 12,
                              letterSpacing: 0.1,
                            )), Text(
                                ' ' +
                                result.education.toString(),
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
                        const Text('Height: ',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                letterSpacing: 0.1,
                                height: 1.2,
                            )), Text(
                            ' ' +
                                result.height2.toString(),
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
                            )), Text(
                            ' ' +
                                result.age.toString(),
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
                        '' +
                            result.maritialname.toString(),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,

                    child:  Row(
                      children: [
                        Text('Id: ',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              letterSpacing: 0.1,
                              height: 1.2,
                            )), Text(
                            'AGRS' +
                                result.mId.toString(),
                            maxLines: 1,
                            style: TextStyle(
                              color: kRedColor,
                              fontSize: 12,
                            fontWeight: FontWeight.w800
                            )) ,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return UserDetailScreen(profileID: result.mId,);
                }));
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Colors.orangeAccent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "View Profile",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          letterSpacing: 1.0),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
