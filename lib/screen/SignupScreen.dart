// ignore: file_names
// ignore: file_names

import 'dart:convert';

import 'package:agraseva/responseModel/city_list_model.dart';
import 'package:agraseva/responseModel/gotra_list_model.dart';
import 'package:agraseva/responseModel/state_list_model.dart';
import 'package:agraseva/screen/HomeScreen.dart';
import 'package:agraseva/screen/SigninScreen.dart';
import 'package:agraseva/screen/TermsConditionScreen.dart';
import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import '../widgets/preLoginDrawer.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int isGender = 1;
  bool isTermCheck = false;
  bool isLoading = false;
  String gotradropdownValue = "Select Gotra";
  String statedropdownValue = "Select State";
  String citydropdownValue = "Select City";
  String genderdropdownValue = "Select Gender";

  String gotraId ="";
  String stateId ="";
  String cityId ="";
  List<String> gotraList = <String>[];
  List<String> stateList = <String>[];
  List<String> cityList = <String>[];
  List<String> genderList = <String>['Select Gender','Male','Female','Other'];
  List<GotraResult> gotraListModel = <GotraResult>[];
  List<StateResult> stateListModel = <StateResult>[];
  List<CityResult> cityListModel = <CityResult>[];

  final _userName = TextEditingController();
  final _userMobile = TextEditingController();
  final _userFather = TextEditingController();
  final _userAddress = TextEditingController();
  final _password = TextEditingController();
  final _passwordComfirm = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    Future.delayed(Duration.zero, () {
      this.getGotraRequest();
    });

  }
  Future<http.Response?> getGotraRequest() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url+'/agraapi/GetGotra');

    await  http.post(uri,
    ).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);
     setState(() {
        isLoading = false;
      });
      Future.delayed(Duration.zero, () {
        this.getStateRequest();
      });
      if(jsonData['response_code']==200){
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = GotraListModel.fromJson(map);

        gotraListModel = modelData.result!;
        gotraList.add('Select Gotra');

        for (var i = 0; i < gotraListModel.length; i++) {
          gotraList.add(gotraListModel[i].gotra!);
        }
        print('lenght:  '+gotraList.length.toString());
      }
      else{
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    }
    );
  }
  Future<http.Response?> getStateRequest() async {

    final uri = Uri.parse(Constant.base_url+'/agraapi/GetState');

    await  http.post(uri,
    ).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);
     setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      if(jsonData['response_code']==200){
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = StateListModel.fromJson(map);

        stateListModel = modelData.result!;
        stateList.add('Select State');
        for (var i = 0; i < stateListModel.length; i++) {
          stateList.add(stateListModel[i].state!);
        }
        print('statelenght:  '+stateList.length.toString());
      }
      else{
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    }
    );
  }
  Future<http.Response?> getCityRequest(String StateID) async {

    final uri = Uri.parse(Constant.base_url+'/agraapi/getCity');
    Map<String, String> body = {
      'StateID': StateID,
    };
    print(body);
    await  http.post(uri,body: body
    ).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);
     setState(() {
        isLoading = false;
      });
      if(jsonData['response_code']==200){
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = CityListModel.fromJson(map);
        cityList.clear();
        cityListModel = modelData.result!;
        cityList.add('Select City');
        for (var i = 0; i < cityListModel.length; i++) {
          cityList.add(cityListModel[i].district!);
        }
        print('citylenght:  '+cityList.length.toString());
      }
      else{
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    }
    );
  }
  Future<http.Response?> registerRequest() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url+'/agraapi/UserRegistration');
    Map<String, String> body = {
      'name': _userName.text,
      'gotra': gotraId,
      'fathername': _userFather.text,
      'mobileno': _userMobile.text,
      'state': stateId,
      'city': cityId,
      'address': _userAddress.text,
      'gender': genderdropdownValue,
      'password': _passwordComfirm.text,
    };
    print(body);
    await  http.post(uri,  body: body
    ).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);
     setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      if(jsonData['response_code']==200){
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context) =>
                SigninScreen()));
      }
      else{
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: new PreLoginDrawer(),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image:  AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                      ],
                    ),
                    Text(
                      "Agraseva",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 40,),

                  ],
                ),
              ),
            ),
            Expanded(
              flex: 11,
              child: isLoading
                  ?Container()
                  :Container(
                margin: EdgeInsets.only(top: 0, right: 20, left: 20, bottom: 20),
                alignment: Alignment.center,
                height: size.height*4/6,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25.0),),
                ),
                padding:
                    EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 0.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sign",
                                      style: TextStyle(fontSize: 30, color: Colors.black,fontWeight: FontWeight.bold),),
                                    Text(
                                      "up",
                                      style: TextStyle(fontSize: 30, color: kRedColor,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 20),
                            //name
                            Container(
                              margin: EdgeInsets.only( left: 5.0, right: 5.0, ),
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25.0)),
                                boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 0.0), //(x,y)
                                  blurRadius: 5.0,
                                )],
                              ),
                              child: TextFormField(
                                controller: _userName,
                                  style: TextStyle(
                                    /* fontFamily: "segoeregular",*/
                                      fontSize: 14,
                                      color: Color(0xff191847)
                                  ),
                                  decoration: InputDecoration(
                                      hintText: 'Name',
                                      border: InputBorder.none,
                                      icon: Image.asset("assets/images/user.png",
                                        height: 20.0,width: 20,
                                      )
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text),

                            ),
                            SizedBox(height: 10),
                            //gotra
                            Container(
                                height: 50,
                                width: size.width,
                              margin: EdgeInsets.only( top: 10.0,  right: 5.0, left: 5.0 ),
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25.0)),
                                boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 0.0), //(x,y)
                                  blurRadius: 5.0,
                                )],
                              ),
                                child:Row(
                                  children: [
                                    Image.asset("assets/images/gotra.png",
                                      height: 20.0,width: 20,
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      flex: 1,
                                      child: DropdownButton<String>(
                                          isExpanded: true,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Colors.black,
                                          ),
                                          iconSize: 25,
                                          value: gotradropdownValue,
                                          underline: SizedBox(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              gotradropdownValue = newValue.toString();
                                              for (var i = 0; i < gotraListModel .length; i++) {
                                                if (gotraListModel[i].gotra == gotradropdownValue) {
                                                  gotraId =  gotraListModel[i].gId!;
                                                }
                                              }
                                            });
                                          },
                                          items: gotraList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color(
                                                            0xff191847) /* fontFamily: "segoesemibold"*/),
                                                  ),
                                                );
                                              }).toList()),
                                    ),
                                  ],
                                )


                            ),
                            SizedBox(height: 10),
                            //father name
                            Container(
                              margin: EdgeInsets.only( top: 10.0,  right: 5.0, left: 5.0 ),
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25.0)),
                                boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 0.0), //(x,y)
                                  blurRadius: 5.0,
                                )],
                              ),
                              child: TextFormField(
                                  controller: _userFather,
                                  style: TextStyle(
                                    /* fontFamily: "segoeregular",*/
                                      fontSize: 14,
                                      color: Color(0xff191847)
                                  ),
                                  decoration: InputDecoration(
                                      hintText: 'Father Name',
                                      border: InputBorder.none,
                                      icon: Image.asset("assets/images/father.png",
                                        height: 20.0,width: 20,
                                      )
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text),

                            ),
                            SizedBox(height: 10),
                            //Mobile
                            Container(
                              margin: EdgeInsets.only( top: 10.0, right: 5.0, left: 5.0 ),
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25.0)),
                                boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 0.0), //(x,y)
                                  blurRadius: 5.0,
                                )],
                              ),
                              child: TextFormField(
                                  controller: _userMobile,
                                  style: TextStyle(
                                    /* fontFamily: "segoeregular",*/
                                      fontSize: 14,
                                      color: Color(0xff191847)
                                  ),
                                  decoration: InputDecoration(
                                      hintText: 'Mobile*',
                                      border: InputBorder.none,
                                      icon: Image.asset("assets/images/mobile.png",
                                        height: 20.0,width: 20,
                                      )
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(12),
                                  ],
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number),

                            ),
                            SizedBox(height: 10),
                            //State
                            Container(
                                height: 50,
                                width: size.width,
                                margin: EdgeInsets.only( top: 10.0,  right: 5.0, left: 5.0 ),
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(25.0)),
                                  boxShadow: [BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 0.0), //(x,y)
                                    blurRadius: 5.0,
                                  )],
                                ),
                                child:Row(
                                  children: [
                                    Image.asset("assets/images/state.png",
                                      height: 20.0,width: 20,
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      flex: 1,
                                      child: DropdownButton<String>(
                                          isExpanded: true,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Colors.black,
                                          ),
                                          iconSize: 25,
                                          value: statedropdownValue,
                                          underline: SizedBox(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              statedropdownValue = newValue.toString();
                                              citydropdownValue = "Select City";
                                              for (var i = 0; i < stateListModel .length; i++) {
                                                if (stateListModel[i].state == statedropdownValue) {
                                                  stateId =  stateListModel[i].stateId!;
                                                  print(stateId);
                                                  getCityRequest(stateId);
                                                }

                                              }
                                            });
                                          },
                                          items: stateList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color(
                                                            0xff191847) /* fontFamily: "segoesemibold"*/),
                                                  ),
                                                );
                                              }).toList()),
                                    ),
                                  ],
                                )


                            ),
                            SizedBox(height: 10),
                            //City
                            Container(
                                height: 50,
                                width: size.width,
                                margin: EdgeInsets.only( top: 10.0,  right: 5.0, left: 5.0 ),
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(25.0)),
                                  boxShadow: [BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 0.0), //(x,y)
                                    blurRadius: 5.0,
                                  )],
                                ),
                                child:Row(
                                  children: [
                                    Image.asset("assets/images/city.png",
                                      height: 20.0,width: 20,
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      flex: 1,
                                      child: DropdownButton<String>(
                                          isExpanded: true,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Colors.black,
                                          ),
                                          iconSize: 25,
                                          value: citydropdownValue,
                                          underline: SizedBox(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              citydropdownValue = newValue.toString();
                                              for (var i = 0; i < cityListModel .length; i++) {
                                                if (cityListModel[i].district == citydropdownValue) {
                                                  cityId =  cityListModel[i].distId!;
                                                }
                                              }
                                            });
                                          },
                                          items: cityList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color(
                                                            0xff191847) /* fontFamily: "segoesemibold"*/),
                                                  ),
                                                );
                                              }).toList()),
                                    ),
                                  ],
                                )


                            ),
                            SizedBox(height: 10),
                            //Address
                            Container(
                              height: 100,
                              margin: EdgeInsets.only(
                                left: 5.0,
                                right: 5.0,top: 10.0,
                              ),
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25.0)),
                                boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 0.0), //(x,y)
                                  blurRadius: 5.0,
                                )],
                              ),
                              child: TextFormField(
                                  controller: _userAddress,
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xff191847)),
                                  decoration: InputDecoration(
                                    hintText: 'Address*',
                                    border: InputBorder.none,
                                      icon: Image.asset("assets/images/address.png",
                                        height: 20.0,width: 20,
                                      )
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text),
                            ),
                            SizedBox(height: 10),
                            //Gender
                             Container(
                                height: 50,
                                width: size.width,
                                margin: EdgeInsets.only( top: 10.0,  right: 5.0, left: 5.0 ),
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(25.0)),
                                  boxShadow: [BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 0.0), //(x,y)
                                    blurRadius: 5.0,
                                  )],
                                ),
                                child:Row(
                                  children: [
                                    Image.asset("assets/images/gender.png",
                                      height: 20.0,width: 20,
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      flex: 1,
                                      child: DropdownButton<String>(
                                          isExpanded: true,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Colors.black,
                                          ),
                                          iconSize: 25,
                                          value: genderdropdownValue,
                                          underline: SizedBox(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              genderdropdownValue = newValue.toString();
                                            });
                                          },
                                          items: genderList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color(
                                                            0xff191847) /* fontFamily: "segoesemibold"*/),
                                                  ),
                                                );
                                              }).toList()),
                                    ),
                                  ],
                                )


                            ),
                            SizedBox(height: 10),
                            //password
                            Container(
                              margin: EdgeInsets.only( top: 10.0, right: 5.0, left: 5.0 ),
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25.0)),
                                boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 0.0), //(x,y)
                                  blurRadius: 5.0,
                                )],
                              ),
                              child: TextFormField(
                                  controller: _password,
                                  style: TextStyle(
                                    /* fontFamily: "segoeregular",*/
                                      fontSize: 14,
                                      color: Color(0xff191847)
                                  ),
                                  decoration: InputDecoration(
                                      hintText: 'Enter Password*',
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.lock_outlined,
                                        color: kRedColor,
                                        size: 20.0,
                                      )
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(8),
                                  ],
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text),

                            ),
                            SizedBox(height: 10),
                            //confirm password
                            Container(
                              margin: EdgeInsets.only( top: 10.0, right: 5.0,left: 5.0 ),
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25.0)),
                                boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 0.0), //(x,y)
                                  blurRadius: 5.0,
                                )],
                              ),
                              child: TextFormField(
                               controller: _passwordComfirm,
                                  style: TextStyle(
                                    /* fontFamily: "segoeregular",*/
                                      fontSize: 14,
                                      color: Color(0xff191847)
                                  ),
                                  decoration: InputDecoration(
                                      hintText: 'Confirm Password*',
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.lock_outlined,
                                        color: kRedColor,
                                        size: 20.0,
                                      )
                                  ),
                                  inputFormatters: [
                                  LengthLimitingTextInputFormatter(8),
                                ],
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text),

                            ),
                            SizedBox(height: 10),
                           //checkbox
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isTermCheck = !isTermCheck;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    /* decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),*/
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0,
                                          top: 10.0,
                                          bottom: 10.0),
                                      child: isTermCheck
                                          ? Image.asset(
                                        "assets/images/checked.png",
                                        height: 25,
                                        alignment:
                                        Alignment.center,
                                      )
                                          : Image.asset(
                                        "assets/images/unchecked.png",
                                        height: 25,
                                        alignment:
                                        Alignment.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    /* color: Color(0xff122D4B),*/
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        top: 1.0, bottom: 0.0),
                                    padding: EdgeInsets.only(
                                        left: 5.0,
                                        top: 10.0,
                                        bottom: 15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "By logging in you agree to our",
                                          style: TextStyle(
                                              color: kRedColor,
                                              fontSize: 14),
                                        ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  TermsConditionScreen()));
                                        });

                                      },
                                      child:Row(children: [
                                        Text(
                                          "Terms and Conditions  ",
                                          style: TextStyle(
                                              fontSize: 14),
                                        ),Text(
                                          "and privacy policy.",
                                          style: TextStyle(
                                              fontSize: 14),
                                        ),
                                      ],)),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                if(_userName.text.isEmpty){
                                  CommonFunctions.showSuccessToast('Please enter full Name');
                                }
                              else  if(gotradropdownValue== 'Select Gotra'){
                                  CommonFunctions.showSuccessToast('Please select gotra');
                                }
                              else  if(_userFather.text.isEmpty){
                                  CommonFunctions.showSuccessToast('Please enter father name');
                                }
                              else  if(_userMobile.text.isEmpty){
                                  CommonFunctions.showSuccessToast('Please enter valid number');
                                }
                              else  if(statedropdownValue== 'Select State'){
                                  CommonFunctions.showSuccessToast('Please select state');
                                }
                                /*else  if(citydropdownValue== 'Select City'){
                                  CommonFunctions.showSuccessToast('Please Select City');
                                }*/
                                else  if(_userAddress.text.isEmpty){
                                  CommonFunctions.showSuccessToast('Please enter address');
                                }
                                else  if(genderdropdownValue == 'Select Gender'){
                                  CommonFunctions.showSuccessToast('Please select gender');
                                }
                                else  if(_password.text.isEmpty){
                                  CommonFunctions.showSuccessToast('Please enter password');
                                }
                                else  if(_passwordComfirm.text.isEmpty){
                                  CommonFunctions.showSuccessToast('Please enter confirm password');
                                }
                                else  if(_password.text != _passwordComfirm.text){
                                  CommonFunctions.showSuccessToast('Password and confirm password not match');
                                }else{
                                  setState(() {
                                    if(isTermCheck){
                                      registerRequest();
                                    }else{
                                      CommonFunctions.showSuccessToast('Please check Terms & Condition');
                                    }

                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: size.height * 0.065,
                                width: size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: kRedColor
                                ),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 5),
                                    Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

                          ],
                        ),
                      ),





                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You have an account?",
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder : (context) => SigninScreen())),
                            child: Text(
                              " SignIn",
                              style: TextStyle(
                                color: kRedColor,
                                fontSize: 14,),
                            ),
                          ),
                        ],
                      ),
                      //SizedBox(height: size.height*0.03),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
