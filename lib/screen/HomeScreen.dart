// ignore: file_names

import 'package:agraseva/screen/FilterScreen.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:agraseva/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import '../utils/common_functions.dart';
import 'DashboardScreen.dart';
import 'MyProfileScreen.dart';
import 'ShortListScreen.dart';
import 'UserListScreen.dart';
import 'WhoVisitScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.FROM});

  final String? FROM;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  bool isMemberVisible = false;
  final List<Widget> screens = [
    DashboardScreen(),
    MyProfileScreen(),
    UserListScreen(),
    WhoVisitScreen(),
    ShortListScreen()
  ];
  String textHolder = 'AGRASEVA';

  changeText(String title) {
    setState(() {
      textHolder = title;
    });
  }

  Widget currentScreen = DashboardScreen();
  final PageStorageBucket bucket = PageStorageBucket();
  PageStorageKey mykey = new PageStorageKey("testkey");
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("FROM");
    print(widget.FROM);
    if (widget.FROM == "HOME") {
      currentScreen = DashboardScreen();
      currentTab = 0;
      currentScreen = screens[0];
      changeText('AGRASEVA');
      isMemberVisible = false;
    } else if (widget.FROM == "SEARCH") {
      currentScreen = UserListScreen();
      currentTab = 2;
      currentScreen = screens[2];
      changeText('Member List');
      isMemberVisible = true;
    } else if (widget.FROM == "WHOVISIT") {
      currentScreen = WhoVisitScreen();
      currentTab = 3;
      currentScreen = screens[3];
      changeText('Who Visit');
      isMemberVisible = false;
    } else if (widget.FROM == "SHORTLIST") {
      currentScreen = ShortListScreen();
      currentTab = 4;
      currentScreen = screens[4];
      changeText('Shortlist');
      isMemberVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // fluter 1.x
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: new MyDrawer(),
      appBar: AppBar(
        toolbarHeight: 60.0,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "$textHolder",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
       // leadingWidth: 200,
        leading: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.menu,
                size: 30,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ],
        ),
        actions: [
          Visibility(
            visible: isMemberVisible,
            child: IconButton(
              icon: Icon(Icons.filter_list_rounded),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FilterScreen();
                }));
              },
            ),
          ),
        ],
        backgroundColor: kRedColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: currentTab == 0 ? Radius.circular(0) : Radius.circular(20),
        )),
      ),
      body: PageStorage(child: currentScreen, bucket: bucket),
      // body : Container(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 0),
        child: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
              setState(() {
                if (Constant.prefs!.getString("userStatus").toString() != '0') {
                  currentTab = 2;
                  currentScreen = screens[2];
                  changeText('Member List');
                  isMemberVisible = true;
                } else {
                  CommonFunctions.showSuccessToast("Admin Approval Required");
                }
              });
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kRedColor,
                ),
                child: Icon(Icons.search, color: Colors.white, size: 30),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new Container(
        //height: 65.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          color: kTextBlackColor,
          /*boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],*/
        ),
        padding: new EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          left: 15.0,
          right: 15.0,
        ),
        margin: new EdgeInsets.only(
          top: 0.0,
          bottom: 15.0,
          left: 15.0,
          right: 15.0,
        ),
        child: new Theme(
          data: Theme.of(context).copyWith(
              canvasColor: kTextBlackColor,
              primaryColor: kRedColor,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(bodySmall: new TextStyle(color: kRedColor))),
          child: new BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentTab,
              onTap: (i) {
                setState(() {
                  if (i == 0) {
                    changeText('AGRASEVA');
                    currentTab = i;
                    currentScreen = screens[i];
                    isMemberVisible = false;
                  } else if (i == 1) {
                    changeText('Profile');
                    currentTab = i;
                    currentScreen = screens[i];
                    isMemberVisible = false;
                  } else if (i == 3) {
                    if(Constant.prefs!.getString("userStatus").toString()!='0') {
                      changeText('Who Visit');
                      currentTab = i;
                      currentScreen = screens[i];
                      isMemberVisible = false;
                    }else{
                      CommonFunctions.showSuccessToast("Admin Approval Required");
                    }
                  } else if (i == 4) {
                    if(Constant.prefs!.getString("userStatus").toString()!='0') {
                      changeText('Shortlist');
                      currentTab = i;
                      currentScreen = screens[i];
                      isMemberVisible = false;
                    }else{
                      CommonFunctions.showSuccessToast("Admin Approval Required");
                    }

                  }

                  print("tabposition $i");
                });
              },
              elevation: 0.0,
              unselectedItemColor: Colors.white,
              selectedItemColor: kRedColor,
              items: [
                BottomNavigationBarItem(
                    icon: currentTab == 0
                        ? Image.asset(
                            "assets/images/home.png",
                            height: 20.0,
                            width: 20,
                            color: kRedColor,
                          )
                        : Image.asset(
                            "assets/images/home.png",
                            height: 20.0,
                            width: 20,
                            color: Colors.white,
                          ),
                    label: 'Home'
                    /* title: new Text('Home',
                      style: TextStyle(
                        fontSize: 12.0,
                      )),*/
                    ),
                BottomNavigationBarItem(
                    icon: currentTab == 1
                        ? Image.asset(
                            "assets/images/profile.png",
                            height: 20.0,
                            width: 20,
                            color: kRedColor,
                          )
                        : Image.asset(
                            "assets/images/profile.png",
                            height: 20.0,
                            width: 20,
                            color: Colors.white,
                          ),
                    label: 'Profile'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.bookmark_border,
                      color: Colors.transparent,
                    ),
                    label: 'Search'),
                BottomNavigationBarItem(
                    icon: currentTab == 3
                        ? Image.asset(
                            "assets/images/who_visit.png",
                            height: 20.0,
                            width: 20,
                            color: kRedColor,
                          )
                        : Image.asset(
                            "assets/images/who_visit.png",
                            height: 20.0,
                            width: 20,
                            color: Colors.white,
                          ),
                    label: 'Who Visit'),
                BottomNavigationBarItem(
                    icon: currentTab == 4
                        ? Image.asset(
                            "assets/images/alert.png",
                            height: 20.0,
                            width: 20,
                            color: kRedColor,
                          )
                        : Image.asset(
                            "assets/images/alert.png",
                            height: 20.0,
                            width: 20,
                            color: Colors.white,
                          ),
                    label: 'Shortlist'),
              ]),
        ),
      ),
    );
  }

  Widget bottomsheet() {
    return new Scaffold(
        body: Container(
      height: 350,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.close_outlined, color: Colors.black38))),
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
            margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: TextFormField(
                // controller: userNameEditTextController,
                style: TextStyle(
                    /* fontFamily: "segoeregular",*/
                    fontSize: 14,
                    color: Color(0xff191847)),
                decoration: InputDecoration(
                  hintText: 'enter id e.g. - 15',
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
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
