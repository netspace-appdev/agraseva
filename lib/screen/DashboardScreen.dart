// ignore: file_names

import 'dart:convert';

import 'package:agraseva/responseModel/member_list_model.dart';
import 'package:agraseva/screen/AnnouncementScreen.dart';
import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:http/http.dart' as http;

import '../responseModel/dashboard_model.dart';
import '../utils/CustomCachedImage.dart';
import 'PaymentScreen.dart';
import 'SigninScreen.dart';
import 'SuccessStoryListScreen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  bool isLoading = false;
  String htmldata = "";
String payNow = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  Constant.prefs?.setBool("loggedIn", false);

    print( Constant.prefs!.getString("userStatus").toString());
    payNow = Constant.prefs!.getString("memberType").toString();
    print("payNow");
    print(payNow);
    isLoading = true;
    Future.delayed(Duration.zero, () {
      this.getDashboardData();
    });
  }
  List<QuickInfo>? quickInfo =  <QuickInfo>[];
  List<NotificationAlert>? notiAlert =  <NotificationAlert>[];
  int currentPos = 0;

  Future<http.Response?> getDashboardData() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi/GetDashboardData');

    Map<String, String> body = {
      'ProfileID': Constant.prefs!.getString("ProfileID").toString(),
    };
    await http.post(uri, body: body).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print('jsonData');
      print(jsonData);
     /* setState(() {
        isLoading = false;
      });*/
      Future.delayed(Duration.zero, () {
        this.getProfileData();
      });
    //  Navigator.of(context).pop();
      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = DashboardModel.fromJson(map);

        /*htmldata = modelData.result[0].notificationContent[0].details!;
        quickInfo = modelData.result[0].quickInfo;
        notiAlert = modelData.result[0].notificationAlert;*/

        if (modelData.result != null && modelData.result!.isNotEmpty) {

          final dashboard = modelData.result![0];

          htmldata = dashboard.notificationContent != null &&
              dashboard.notificationContent!.isNotEmpty &&
              dashboard.notificationContent![0].details != null
              ? dashboard.notificationContent![0].details!
              : "";

          quickInfo = dashboard.quickInfo ?? [];
          notiAlert = dashboard.notificationAlert ?? [];

        }
       print("notiAlert:  " + notiAlert!.length.toString());
      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }
  String imageProfile ="";
  List<Result>? memberList = <Result>[];
  late Result userModel;

  Future<http.Response?> getProfileData() async {
    final uri = Uri.parse(Constant.base_url + '/agraapi/CheckUserSession');
    Map<String, String> body = {
      'mobileno': Constant.prefs!.getString("contact").toString(),
      'token': Constant.prefs!.getString("token").toString(),
    };
    await http.post(uri, body: body).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      setState(() {
        isLoading = false;

        Navigator.of(context).pop();
        if (response.statusCode == 200) {
          var map = Map<String, dynamic>.from(jsonData);
          var modelData = MemberListModel.fromJson(map);

          memberList = modelData.result;
          userModel = memberList![0];
          print("memberListsize:  " + memberList!.length.toString());
          imageProfile =  Constant.base_url+'/uploaded/matri/profilepic/'+userModel.profilePic.toString();
          Constant.prefs?.setString("profilepic", imageProfile);
          Constant.prefs?.setString("userStatus", userModel.status!);
          print(imageProfile);

        } else {
          print(jsonData['message'] as String);

          Constant.prefs!.setBool("loggedIn", false);
          Constant.prefs!.clear();
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => SigninScreen(),
            ),
                (route) =>
            false, //if you want to disable back feature set to false
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:  isLoading
          ? Container()
          : Column(
            children: [
              Container(
                height: 130,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  color: kRedColor,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0)),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome back",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(userModel!=null? userModel.fName.toString()+' '+userModel.lName.toString():'',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(payNow+'Member'??'',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.5),
                        borderRadius: BorderRadius.all(
                            Radius.circular(40.0) //                 <--- border radius here
                        ),
                      ),
                      child: ClipOval(
                        child: CustomCachedImage(
                          imageUrl: userModel!=null? Constant.base_url+'/uploaded/matri/profilepic/'+userModel.profilePic.toString() :'',
                          width: 70,
                          height: 70,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  /*  Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.5),
                        borderRadius: BorderRadius.all(
                            Radius.circular(40.0) //                 <--- border radius here
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: Image.network(userModel!=null? Constant.base_url+'/uploaded/matri/profilepic/'+userModel.profilePic.toString() :'',

                           fit: BoxFit.cover,
                        ),
                      ),
                    ),*/
                  ],
                ),),
              Container(
                height: 0,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned(
                      top: -40,
                      child: Column(
                        children: [
                           Container(
                             height: 70,
                             width: size.width,
                             child: CarouselSlider.builder(
                               itemCount: quickInfo!.length,
                               options: CarouselOptions(
                                   height: 100,
                                   autoPlay: true,
                                   viewportFraction: 1.0,
                                   aspectRatio: 2.0,
                                   onPageChanged: (index, reason) {
                                     setState(() {
                                       currentPos = index;
                                     });
                                   }),
                               itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                                 return QuickInfoCell(quickInfo!.length!=0?quickInfo![itemIndex].information.toString():'');
                               },
                             ),
                           )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
        /*physics: NeverScrollableScrollPhysics(),*/

                  child: Container(
                   /* padding: EdgeInsets.only(top:40),*/
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001) // perspective
                            ..rotateX(0.02) // slight tilt
                            ..rotateY(-0.02),
                          alignment: FractionalOffset.center,
                          child: Container(
                          height: MediaQuery.of(context).size.height/3,

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),

                            boxShadow:  [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.5),
                                blurRadius: 0.1,
                                spreadRadius: 0.1,
                                offset: Offset(0.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                          ),

                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.all(15.0),
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: Container(
                                child: Html(data: htmldata),

                              ),
                            ),
                          )),
                        ),
                      /*   payNow=="Premier"?Container():
                        GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return PaymentScreen();
                          }));
                  },
                    child:
                    Container(
                            height: 50,
                            width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 0.1,
                            spreadRadius: 0.1,
                            offset: Offset(
                                1.0, 1.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                            child:  Center(
                              child: Text('Pay Now',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),)),*/
                        Container(
                       /* height: 250, */
                            padding: EdgeInsets.only(left: 10.0,right: 10.0),
                            margin: EdgeInsets.only(left: 10.0,right: 10.0),
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: Container(
                              child:   const Text('For you',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),

                            ),
                          ),
                        )),
                        Container(
                          height: 55.0 * notiAlert!.length,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),

                            boxShadow:  [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.5),
                                blurRadius: 0.1,
                                spreadRadius: 0.1,
                                offset: Offset(0.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                         /* decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 0.1,
                                spreadRadius: 0.1,
                                offset: Offset(
                                    1.0, 1.0), // shadow direction: bottom right
                              )
                            ],
                          ),*/
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(15.0),
                          child: ListView.builder(
                            itemCount: notiAlert!.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return NotificationAlertCell(
                                res: notiAlert![index],
                              );
                            },

                            shrinkWrap: false,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }

}
class QuickInfoCell extends StatelessWidget {
  String info;

  QuickInfoCell(this.info);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {

      },
      child: Hero(
          tag: "generate_a_unique_tag",
          child: Container(

            margin: EdgeInsets.only(left: 0,right: 0,top: 15,bottom: 2),
            padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              /*      borderRadius: BorderRadius.all(Radius.circular(20.0)),*/
              color: Colors.white,
           /*   borderRadius: BorderRadius.circular(10),*/
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 0.5,
                  spreadRadius: 0.5,
                  offset: Offset(
                      1.0, 1.0), // shadow direction: bottom right
                )
              ],
            ),
          child: Row(
            children: [
               Image.asset(
              "assets/images/quick_info_icon.png",
              height: 25,
            ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Text(info,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  /*  fontWeight: FontWeight.bold,*/
                    /*letterSpacing: 0.5,*/
                  ),
                ),
              ),
            ],
          )
          /*Center(
            child: Text(info,
              maxLines: 3,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          )*/,)),
    );
  }
}
class NotificationAlertCell extends StatelessWidget {

  const NotificationAlertCell({
    Key? key,
    required this.res,
  }) : super(key: key);

  final  NotificationAlert res;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AnnouncementScreen(res: res);
        }));
      },
      child: Hero(
          tag: "generate_a_unique_tag",
          child: Container(

            margin: EdgeInsets.only(left: 0,right: 0,top: 10,bottom: 2),
           /* padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),*/

          child: Row(
            children: [
           /*    Image.asset(
              "assets/images/new_streep_icon.png",
              height: 25,
            ),
              SizedBox(
                width: 10,
              ),*/
              Expanded(
                flex: 1,
                child: Text(res.details!,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    /*fontWeight: FontWeight.bold,*/

                  ),
                ),
              ),
            ],
          )
          /*Center(
            child: Text(info,
              maxLines: 3,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          )*/,)),
    );
  }
}

