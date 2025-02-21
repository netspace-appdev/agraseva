import 'package:agraseva/responseModel/DrawerModel.dart';
import 'package:agraseva/screen/ContactusScreen.dart';
import 'package:agraseva/screen/PaymentScreen.dart';
import 'package:agraseva/screen/SigninScreen.dart';
import 'package:agraseva/screen/SuccessStoryListScreen.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen/AboutusScreen.dart';
import '../screen/GalleryScreen.dart';
import '../screen/HomeScreen.dart';
import '../screen/TermsConditionScreen.dart';
import '../utils/common_functions.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<DrawerModel> drawerItemList = [
    new DrawerModel(
        title: 'Home',
        position: '0',
        icon: "assets/images/home_two.png",
        selected: false),
    new DrawerModel(
        title: 'Search',
        position: '1',
        icon: "assets/images/search.png",
        selected: false),
    new DrawerModel(
        title: 'My Shortlist',
        position: '2',
        icon: "assets/images/my_shortlist.png",
        selected: false),
    new DrawerModel(
        title: 'Who visit',
        position: '3',
        icon: "assets/images/who_visit_two.png",
        selected: false),
    new DrawerModel(
        title: 'Success Story',
        position: '4',
        icon: "assets/images/success_story.png",
        selected: false),
    new DrawerModel(
        title: 'Gallery',
        position: '5',
        icon: "assets/images/gallery.png",
        selected: false),
    new DrawerModel(
        title: 'Payment',
        position: '6',
        icon: "assets/images/payment.png",
        selected: false),
  ];
  bool isFaq = false;
  bool isContactUs = false;
  bool isAboutUs = false;
  bool isLogout = false;

  Map<int, bool> itemsSelectedValue = Map();
  String profilePic = Constant.prefs!.getString("profilepic").toString();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: 20.0, top: 10.0, right: 10.0, bottom: 0.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.cancel,
                      color: Colors.black26,
                      size: 25,
                    )),
              )),
          Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/ractangle_bg_red.png"),
                  /* fit: BoxFit.cover,*/
                ),
                /*  shape: BoxShape.rectangle,
                color: kRedColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)),*/
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 0,
                  ),
                  Row(
                    children: [
                       Padding(
                        padding: EdgeInsets.only(
                            left: 20.0, top: 20.0, right: 10.0, bottom: 10.0),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(profilePic),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(Constant.prefs!.getString("name").toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(Constant.prefs!.getString("contact").toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
          Container(
            height: 310,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: drawerItemList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Container contianer;
                if (drawerItemList[index].selected!) {
                  contianer = Container(

                    child:Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: size.width/2,
                        height: 40,
                        margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10, top: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,

                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              darkRedColor,
                              kRed2Color,
                              kRed2Color,
                              kRedColor,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, bottom:  0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                            drawerItemList[index].icon!,
                                            color: Colors.white,
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            drawerItemList[index].title!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      )),
                                  /* const Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.black,
                                      size: 15,
                                    ),)*/
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  contianer = Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        drawerItemList[index].icon!,
                                        color: kRedColor,
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        drawerItemList[index].title!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )),
                              /*const Expanded(
                                flex: 1,
                                child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                                size: 15,
                              ),)*/
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      for (var i = 0; i < drawerItemList.length; i++) {
                        if (i == index) {
                          drawerItemList[i].selected = true;
                        } else {
                          drawerItemList[i].selected = false;
                        }
                      }
                      print("OnClick :  ${drawerItemList[index].selected}");
                      if (index == 0) {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomeScreen(FROM: "HOME",)));
                      } else if (index == 1) {
                        if(Constant.prefs!.getString("userStatus").toString()!='0'){
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomeScreen(FROM: "SEARCH",)));
                        }else{
                          CommonFunctions.showSuccessToast("Admin Approval Required");
                        }
                        /*Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomeScreen(FROM: "SEARCH",)));*/

                      } else if (index == 2) {
                        if(Constant.prefs!.getString("userStatus").toString()!='0'){
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomeScreen(FROM: "SHORTLIST",)));
                        }else{
                          CommonFunctions.showSuccessToast("Admin Approval Required");
                        }
                      } else if (index == 3) {

                        if(Constant.prefs!.getString("userStatus").toString()!='0'){
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomeScreen(FROM: "WHOVISIT",)));
                        }else{
                          CommonFunctions.showSuccessToast("Admin Approval Required");
                        }
                      } else if (index == 4) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SuccessStoryListScreen();
                        }));
                      }else if (index == 5) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return GalleryScreen();
                        }));
                      }else if (index == 6) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PaymentScreen();
                        }));
                      }
                    });
                  },
                  child: contianer,
                );
              },
            ),
          ),
          /*
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            color: Colors.grey,
            height: size.height * 0.0005,
          ),*/
          ListTile(
            title: const Text(
              "Account",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),

          GestureDetector(
            onTap: () {
              setState(() {
                isFaq = true;
                isContactUs = false;
                isAboutUs = false;
                isLogout = false;
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                        TermsConditionScreen()));
              });

            },
            child: isFaq?Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: size.width/2,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10, top: 10),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,

                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      darkRedColor,
                      kRed2Color,
                      kRed2Color,
                      kRedColor,
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/faq.png",
                      color: Colors.white,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Terms & Conditons",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ):
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/faq.png",
                    color: kRedColor,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Terms & Conditons",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isFaq = false;
                isAboutUs = true;
                isContactUs = false;
                isLogout = false;
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                        AboutusScreen()));
              });

            },
            child: isAboutUs?Align(
              alignment: Alignment.topLeft,
              child: Container(
               width: size.width/2,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10, top: 10),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      darkRedColor,
                      kRed2Color,
                      kRed2Color,
                      kRedColor,
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "About Us",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ):
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: kRedColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "About Us",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isFaq = false;
                isContactUs = true;
                isAboutUs = false;
                isLogout = false;
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ContactusScreen()));
              });

            },
            child: isContactUs?Align(
              alignment: Alignment.topLeft,
              child: Container(
               width: size.width/2,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10, top: 10),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      darkRedColor,
                      kRed2Color,
                      kRed2Color,
                      kRedColor,
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.headset_mic_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Contact Us",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ):
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.headset_mic_outlined,
                    color: kRedColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Contact Us",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),


          GestureDetector(
            onTap: () {
              isLogout = !isLogout;
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
            },
            child: isLogout?Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/ractangle_bg_two.png"),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    color: kRedColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Logout",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ):
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    color: kRedColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Logout",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            "assets/images/drawer_footer.png",
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    @required this.title,
    @required this.position,
    @required this.icon,
    @required this.index,
    @required this.isCurrentIndexSelected,
    @required this.itemsSelectedValue,
  }) : super(key: key);

  final String? title;
  final String? position;
  final IconData? icon;
  final int? index;
  final bool? isCurrentIndexSelected;
  final Map<int, bool>? itemsSelectedValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("${!isCurrentIndexSelected!}");
        itemsSelectedValue![index!] = !isCurrentIndexSelected!;

        print("OnClick : $index + ${itemsSelectedValue![index]}");
      },
      child: (isCurrentIndexSelected!)
          ? Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          icon,
                          color: const Color(0xFFff9cad),
                          size: 30,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          title!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          icon,
                          color: Colors.grey,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          title!,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
