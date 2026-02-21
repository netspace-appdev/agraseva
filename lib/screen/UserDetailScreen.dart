// ignore: file_names


import 'dart:convert';

import 'package:agraseva/responseModel/member_list_model.dart';
import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ForgotPasswordScreen.dart';
import 'SigninScreen.dart';
import 'SignupScreen.dart';

import 'package:http/http.dart' as http;
class UserDetailScreen extends StatefulWidget {
  UserDetailScreen({this.profileID});

  final String? profileID;
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  List<Result>? memberList =  <Result>[];
  late Result userModel;
  bool isLoading = false;
  int selectTab = 1;
  String isUserShorted = "";
  int currentPos = 0;
  bool showMoreOptions = false;
  bool showMenu = false;
  String? memberType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    memberType = Constant.prefs?.getString("memberType");

    Future.delayed(Duration.zero, () {
      this.getMemberList();
    });

  }
  Future<http.Response?> getMemberList() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url +'/agraapi/UserProfile');
    Map<String, String> body = {
      'ProfileID': widget.profileID!,
      'MyProfileID':Constant.prefs!.getString("ProfileID").toString(),
    };

    await http
        .post(
        uri ,
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
        var modelData = MemberListModel.fromJson(map);

        memberList = modelData.result;
        userModel = memberList![0];
        print("memberListsize:  " +memberList!.length.toString());
        print("photoList size:  " +userModel.photoList!.length.toString());

        isUserShorted =userModel.isuserShortlisted.toString();
      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }
  Future<http.Response?> addToShortlist() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url +'/agraapi/GetShortlist');
    Map<String, String> body = {
      'ProfileID':Constant.prefs!.getString("ProfileID").toString(),
      'ToProfileID': widget.profileID!,
    };
    await http
        .post(
        uri ,
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
  Future<http.Response?> deleteToShortlist() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url +'/agraapi/DeleteMyShortlist');
    Map<String, String> body = {
      'ProfileID':Constant.prefs!.getString("ProfileID").toString(),
      'MyProfileID': widget.profileID!,
    };
    print('DeleteMyShortlist');
    print(body);
    await http
        .post(
        uri ,
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


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: isLoading
              ?Container()
              :AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                text: "",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.grey,),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  showMenu = !showMenu;
                });
              },
            ),
          ],
            flexibleSpace:Stack(
              children: [
                userModel!=null && userModel.coverPic.toString()==""?
                   Image.asset("assets/images/noImg.png", fit: BoxFit.cover,
                     width: double.infinity,) :
                Image.network(userModel!=null? Constant.base_url+'/uploaded/matri/coverpic/'+userModel.coverPic.toString() :'',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  /*   color: Colors.black.withOpacity(0.4),
            colorBlendMode: BlendMode.darken,*/
                  height: 300,
                ),
                if (showMenu)
                  Positioned(
                    top: 80,
                    right: 20,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 5),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*ListTile(
                              leading: Icon(Icons.block, color: Colors.red),
                              title: Text("Block"),
                              onTap: () {
                                setState(() {
                                  showMenu = false;
                                });
                                print("User blocked");
                              },
                            ),*/
                            ListTile(
                              leading: Icon(Icons.report, color: Colors.orange),
                              title: Text("Report"),
                              onTap: () {
                                setState(() {
                                  showMenu = false;
                                });
                                _showReportDialog(context);
                                print("User reported");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            backgroundColor: Colors.transparent,

          )
      ),
      body: isLoading
          ?Container()
          :Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 0.0, top: 0.0),
            child: Column(
              children: [

                Container(
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.darken),
                      image: AssetImage("assets/images/bg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Profile Pic Section
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 0.5),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Image.network(
                            userModel != null
                                ? Constant.base_url + '/uploaded/matri/profilepic/' + userModel.profilePic.toString()
                                : '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),

                      // Name and Shortlist
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userModel != null
                                  ? userModel.fName.toString() + ' ' + userModel.lName.toString()
                                  : '',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            isUserShorted == "Yes"
                                ? Container()
                                : GestureDetector(
                              onTap: () {
                                isUserShorted == "Yes"
                                    ? deleteToShortlist()
                                    : addToShortlist();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 120.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kRedColor,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star_outline_rounded, color: Colors.white, size: 15),
                                    SizedBox(width: 5),
                                    Text(
                                      "Shortlist",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectTab = 1;
                              });
                            },
                            child: selectTab == 1
                                ?  Container(
                              alignment: Alignment.center,
                              height: size.height * 0.055,
                              margin: const EdgeInsets.only(left: 10.0,top: 10.0,bottom: 10.0,),
                              width: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: kRedColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(1.0,
                                        1.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star_outline_rounded,color: Colors.white,size: 15,),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Basic info",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,),
                                  ),
                                ],
                              ),
                            )
                                :  Container(
                              alignment: Alignment.center,
                              height: size.height * 0.055,
                              margin: const EdgeInsets.only(left: 10.0,top: 10.0,bottom: 10.0,),
                              width: 120.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(1.0,
                                          1.0), // shadow direction: bottom right
                                    )
                                  ]
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star_outline_rounded,color: Colors.black,size: 15,),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Basic info",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectTab = 2;
                              });
                            },
                            child: selectTab == 2
                                ? Container(
                              alignment: Alignment.center,
                              height: size.height * 0.055,
                              margin: const EdgeInsets.all(10.0),
                              width: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: kRedColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(1.0,
                                        1.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo_camera_back,color: Colors.white,size: 15,),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Photo",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,),
                                  ),
                                ],
                              ),
                            )
                                :  Container(
                              alignment: Alignment.center,
                              height: size.height * 0.055,
                              margin: EdgeInsets.all(10.0),
                              width: 120.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(1.0,
                                          1.0), // shadow direction: bottom right
                                    )
                                  ]
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo_camera_back,color: Colors.black,size: 15,),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Photo",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectTab = 3;
                              });
                            },
                            child: selectTab == 3
                                ?  Container(
                              alignment: Alignment.center,
                              height: size.height * 0.055,
                              margin: const EdgeInsets.only(right: 10.0,top: 10.0,bottom: 10.0,),
                              width: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: kRedColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(1.0,
                                        1.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/father.png",
                                    color: Colors.white,
                                    height: 15,
                                  ),
                                  SizedBox(width: 5,),
                                  const Text(
                                    "Family",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,),
                                  ),
                                ],
                              ),
                            )
                                :  Container(
                              alignment: Alignment.center,
                              height: size.height * 0.055,
                              margin: const EdgeInsets.only(right: 10.0,top: 10.0,bottom: 10.0,),
                              width: 120.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(1.0,
                                          1.0), // shadow direction: bottom right
                                    )
                                  ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/father.png",
                                    color: Colors.black,
                                    height: 15,
                                  ),
                                  SizedBox(width: 5,),
                                  const Text(
                                    "Family",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectTab = 4;
                              });
                            },
                            child: selectTab == 4
                                ?  Container(
                              alignment: Alignment.center,
                              height: size.height * 0.055,
                              margin: const EdgeInsets.only(right: 10.0,top: 10.0,bottom: 10.0,),
                              width: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: kRedColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(1.0,
                                        1.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.wb_sunny,color: Colors.white,size: 15,),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Astro info",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,),
                                  ),
                                ],
                              ),
                            )
                                :  Container(
                              alignment: Alignment.center,
                              height: size.height * 0.055,
                              margin: const EdgeInsets.only(right: 10.0,top: 10.0,bottom: 10.0,),
                              width: 120.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(1.0,
                                          1.0), // shadow direction: bottom right
                                    )
                                  ]
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.wb_sunny,color: Colors.black,size: 15,),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Astro info",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                tabViewContainer(),


              ],
            ),

          ),
        )
      )
      ,
    );
  }
  Container tabViewContainer() {
    if (selectTab == 1) {
      return BasicInfoView();
    } else if (selectTab == 2) {
      return PhotoView();
    }else if (selectTab == 3) {
      return FamilyView();
    } else {
      return AstroInfoView();
    }
  }

  Container PhotoView() {
    return Container(
        width: double.infinity,
        height: 300,
        color: Colors.white,
       /* child: ListView.builder(
          scrollDirection: Axis.vertical,
      itemCount: userModel.photoList!.length,
          itemBuilder: (context, index) {
            Container contianer;
            contianer = Container(
              height: 250,
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(10.0),
                child: Image.network(
                    Constant.base_url +
                        '/uploaded/matri/' +
                        userModel
                            .photoList![index]
                            .profile.toString(), ),
              ),
            );
            return GestureDetector(
              onTap: () {
                setState(() {
                });
              },
              child: contianer,
            );
          },
      shrinkWrap: false,

    ),*/
        child:Column(children: [
          CarouselSlider.builder(
            itemCount: userModel.photoList!.length,
            options: CarouselOptions(
                height: 280,
                autoPlay: true,
                viewportFraction: 1.0,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPos = index;
                  });
                }),
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
              return BannerImage(userModel.photoList!.length!=0? Constant.base_url +
                  '/uploaded/matri/' +
                  userModel
                      .photoList![itemIndex]
                      .profile.toString():'');
            },
          ),
          Container(
            height: 0,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Positioned(
                  top: -10,
                  child: Column(
                    children: [
                      Row(
                        children: userModel.photoList!.map((url) {
                          int index = userModel.photoList!.indexOf(url);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPos == index
                                  ? kRedColor
                                  : Colors.black12,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],)
    );
  }

  Container BasicInfoView() {
    return Container(
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 15,),
              const Text("Email",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(
                memberType == "Free"
                    ? "Contact details available for Prime members only"
                    : (userModel != null ? userModel.email.toString() : ''),
                style: const TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text("Contact mobile number:",
                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(
                memberType == "Free"
                    ? "Contact details available for Prime members only"
                    : (userModel != null ? userModel.contact.toString() : ''),
                style: const TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            /*  Text(userModel!=null? userModel.contact.toString() :'',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),*/
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text("Address:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel!=null? userModel.address.toString()+' '+userModel.cityName.toString()+' '+userModel.stateName.toString()+' '+userModel.pincode.toString() :'',

                style: const TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text("Marital status:",
                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel!=null? userModel.maritialname.toString() :'',

                style: const TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text("Complexion:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel!=null? userModel.complexion.toString() :'',

                style: const TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text("Age:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel!=null? userModel.age.toString()+' Year' :'',

                style: const TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text("Body type:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel!=null? userModel.bodyType.toString() :'',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Weight:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel!=null? userModel.weight.toString()+' kg' :'',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Height:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel!=null? userModel.height2.toString() +' ft':'',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Body Type:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel!=null? userModel.bodyType.toString() :'',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Blood Group:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel!=null? userModel.bloodGroup.toString() :'',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Education",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text( userModel.education?.toString()??'',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Occupation",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel.businessName?.toString()??'',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Income",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel.income?.toString()??'',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
        ],),
      ),
    );
  }
  Container AstroInfoView() {
    return Container(
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 15,),
              Text("DOB:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null ? userModel.dob.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Birth Time:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null ? userModel.dot.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Birth Place:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null
                  ? userModel.placeBirth.toString()
                  : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Sem Singh/Rashi",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null ? userModel.rashi.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Nakshatra:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null ? userModel.nakshatra.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Manglik:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(  userModel != null ? userModel.manglik.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),

        ],),
      ),
    );
  }
  Container FamilyView() {
    return Container(
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 15,),
              Text("Contact Person Name",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null ? userModel.cPName.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Relationship With Contact Person:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null
                  ? userModel.relationCP.toString()
                  : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Best Time To Call:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null
                  ? userModel.timeToCall.toString()
                  : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Mobile Contact Person:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null ? userModel.mobileCP.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Email:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null ? userModel.emailCP.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Total Brother:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text( userModel != null ? userModel.brother.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Married Brother:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null ? userModel.mbrother.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Unmarried Brother:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null ? userModel.nmbrother.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Total Sister:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null ? userModel.tsister.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Father Occupation:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null
                  ? userModel.fahetrBussiness.toString()
                  : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Home Type:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text(userModel != null ? userModel.homeType.toString() : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),
          Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("Family & Candidate Job/Business Details:",

                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,),
              ),
              SizedBox(height: 3,),
              Text( userModel != null
                  ? userModel.remark.toString()
                  : '',

                style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 15.0,top: 15,right: 0),
              ),
            ],
          ),

        ],),
      ),
    );
  }
  void _showReportDialog(BuildContext context) {
    String? selectedReason;
    List<String> reportReasons = [
      "Fake profile",
      "Abusive behavior",
      "Inappropriate photos",
      "Harassment",
      "Spamming",
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Report User"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: reportReasons.map((reason) {
                  return RadioListTile<String>(
                    activeColor: Colors.red,
                    title: Text(reason),
                    value: reason,
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value;
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedReason != null) {
                  Navigator.of(context).pop(); // Close the dialog
                  // Do something with the selectedReason, like call an API
                  print("User reported for: $selectedReason");
                  // Optionally show confirmation
                  CommonFunctions.showSuccessToast("User is reported");

                } else {

                  CommonFunctions.showSuccessToast("Please select a reason.");
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Submit",style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

}

class BannerImage extends StatelessWidget {
  String imgPath;

  BannerImage(this.imgPath);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: () async {
          CommonFunctions.showImage(imgPath, context);
        },
        child:  Container(
          margin: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 5.0,
            bottom: 15.0,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: kTextGreyColor.withOpacity(0.5),
                offset: Offset(0.0, 0.0), //(x,y)
                blurRadius: 2.0,
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(imgPath),

            ),
          ),

        )) ;
  }
}
