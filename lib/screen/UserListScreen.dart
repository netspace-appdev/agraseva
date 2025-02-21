// ignore: file_names

import 'dart:convert';

import 'package:agraseva/responseModel/member_list_model.dart';
import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'UserDetailScreen.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<Result>? memberList = <Result>[];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  Constant.prefs?.setBool("loggedIn", false);
    isLoading = true;
    FBroadcast.instance().register("filter_data", (value, callback) {
      var data = value;
      print('FBroadcast..');
      print(data);
      Future.delayed(Duration.zero, () {
        this.getMemberList(data);
      });
    });
    Map<String, String> body = {
      'mobileno': Constant.prefs!.getString("contact").toString(),
      'gender':Constant.prefs!.getString("gender").toString(),
      'gotra': Constant.prefs!.getString("gotra").toString(),
    };
    Future.delayed(Duration.zero, () {
      this.getMemberList(body);
    });


  }

  Future<http.Response?> getMemberList(Map<String, String> body) async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi/UserList');
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
      /*appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "User",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.filter_list_rounded),
                color: Colors.white,
                onPressed: () {
                  showCupertinoModalBottomSheet(
                      expand: false,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => bottomsheet());
                },
              ),
            ],
            backgroundColor: kRedColor,
          )),*/
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
                childAspectRatio: 0.56,
              ),
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
        margin: EdgeInsets.only(left: 3.0, right: 3.0, bottom: 8.0),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(Constant.base_url+'/uploaded/matri/profilepic/' +
                                result.profilePic.toString(),
                            /*color: Colors.black.withOpacity(0.1),
                                    colorBlendMode: BlendMode.darken,*/
                          /*  fit: BoxFit.cover,*/
                            height: 150,
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
                          result.fName.toString()+
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
                              )), Text( ' ' + result.education.toString(),
                              maxLines: 2,
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
                          Text('Height: ',
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
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return UserDetailScreen(profileID: result.mId,);
                  }));
                },
                child: Container(
                  height: 30,
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.orangeAccent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
