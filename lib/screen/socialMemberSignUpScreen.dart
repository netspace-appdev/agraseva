// ignore: file_names
// ignore: file_names

import 'dart:convert';
import 'dart:io';

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
import 'package:flutter_html/flutter_html.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SocialMemberSignupScreen extends StatefulWidget {
  @override
  _SocialMemberSecondSignupScreenState createState() => _SocialMemberSecondSignupScreenState();
}

class _SocialMemberSecondSignupScreenState extends State<SocialMemberSignupScreen> {
  int isGender = 1;
  bool isTermCheck = false;
  bool isLoading = false;
  String statedropdownValue = "Select State";
  String citydropdownValue = "Select City";
  String genderdropdownValue = "Select Gender";

  String gotraId ="";
  String stateId ="";
  String cityId ="";
  List<String> stateList = <String>[];
  List<String> cityList = <String>[];
  List<String> genderList = <String>['Select Gender','Male','Female','Other'];
  List<String> occupationList = [
    "Business",
    "Private Job",
    "Government Job",
  ];
  String? occupationDropdownValue;
  String dob = ''; // non-nullable

  final ImagePicker _picker = ImagePicker();

  File? _profileImage;
  List<GotraResult> gotraListModel = <GotraResult>[];
  List<StateResult> stateListModel = <StateResult>[];
  List<CityResult> cityListModel = <CityResult>[];

  final _userName = TextEditingController();
  final _userMobile = TextEditingController();
  final _userOccupation = TextEditingController();
  final _userFather = TextEditingController();
  final _userAddress = TextEditingController();


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
     // 'password': _passwordComfirm.text,
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

      body: Container(
        decoration: const BoxDecoration(
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
                child:const Center(
                    child: Text(
                      "Agraseva",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
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
                decoration: const BoxDecoration(
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
                            const Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(
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
                            Stack(
                              children: [
                                // Obx(() {return
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage:
                                  _profileImage != null ? FileImage(_profileImage!) : null,
                                  child: _profileImage == null
                                      ? const Icon(Icons.person, size: 55, color: Colors.white)
                                      : null,
                                ),
                                // }),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () => _showPicker(context),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.camera_alt,
                                          color: Colors.white, size: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),

                            //name
                            Container(
                              margin: EdgeInsets.only( left: 5.0, right: 5.0, ),
                              padding: const EdgeInsets.only(
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
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextFormField(
                                    controller: _userName,
                                    style: const TextStyle(
                                      /* fontFamily: "segoeregular",*/
                                        fontSize: 14,
                                        color: Color(0xff191847)
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Full Name*',
                                      border: InputBorder.none,
                                      //  icon: Image.asset("assets/images/user.png", height: 20.0,width: 20,)
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text),
                              ),

                            ),

                            SizedBox(height: 10),


                            //Mobile
                            Container(
                              margin: EdgeInsets.only( top: 10.0, right: 5.0, left: 5.0 ),
                              padding: const EdgeInsets.only(
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
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextFormField(
                                    controller: _userMobile,
                                    style: const TextStyle(
                                      /* fontFamily: "segoeregular",*/
                                        fontSize: 14,
                                        color: Color(0xff191847)
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Mobile Number*',
                                      border: InputBorder.none,
                                      // icon: Image.asset("assets/images/mobile.png", height: 20.0,width: 20,)
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(12),
                                    ],
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number),
                              ),

                            ),
                            const SizedBox(height: 10),

                            Container(
                              margin: const EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                  )
                                ],
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(25),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2000),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );

                                  if (pickedDate != null) {
                                    setState(() {
                                      dob =
                                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                    });
                                  }
                                },
                                child: InputDecorator(
                                  decoration:  InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Date of Birth',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff191847)

                                    ),

                                    suffixIcon: Icon(Icons.calendar_today, size: 18),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0,left: 8),
                                    child: Text(
                                      dob.isEmpty ? 'Date of Birth' : dob,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: dob.isEmpty
                                            ? Colors.black
                                            : const Color(0xff191847),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 50,
                              width: size.width,
                              margin: const EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      hint: const Text(
                                        "Select Occupation",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: Colors.black,
                                      ),
                                      value: occupationDropdownValue,
                                      underline: const SizedBox(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          occupationDropdownValue = newValue;
                                        });
                                      },
                                      items: occupationList.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xff191847),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //gotra
                            SizedBox(height: 10),
                            //Gender
                            SizedBox(height: 10),

                            //Mobile
                            Container(
                              margin: EdgeInsets.only( top: 10.0, right: 5.0, left: 5.0 ),
                              padding: const EdgeInsets.only(
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
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextFormField(
                                    controller: _userOccupation,
                                    style: const TextStyle(
                                      /* fontFamily: "segoeregular",*/
                                        fontSize: 14,
                                        color: Color(0xff191847)
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Occupation Detail*',
                                      border: InputBorder.none,
                                      // icon: Image.asset("assets/images/mobile.png", height: 20.0,width: 20,)
                                    ),

                                    textInputAction: TextInputAction.next,
                                    maxLines: 3,
                                    keyboardType: TextInputType.text),
                              ),

                            ),
                            const SizedBox(height: 10),
                            //State
                            Container(
                                height: 50,
                                width: size.width,
                                margin: EdgeInsets.only( top: 10.0,  right: 5.0, left: 5.0 ),
                                padding: const EdgeInsets.only(
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
                                child:Row(
                                  children: [
                                    // Image.asset("assets/images/state.png", height: 20.0,width: 20,),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      flex: 1,
                                      child: DropdownButton<String>(
                                          isExpanded: true,
                                          // icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black,),
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
                                                    style: const TextStyle(
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
                                padding: const EdgeInsets.only(
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
                                child:Row(
                                  children: [
                                    //Image.asset("assets/images/city.png", height: 20.0,width: 20,),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      flex: 1,
                                      child: DropdownButton<String>(
                                          isExpanded: true,
                                          icon: const Icon(
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
                                                    style: const TextStyle(
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
                              margin: const EdgeInsets.only(
                                left: 5.0,
                                right: 5.0,top: 10.0,
                              ),
                              padding: const EdgeInsets.only(
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
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextFormField(
                                    controller: _userAddress,
                                    style: const TextStyle(
                                        fontSize: 14, color: Color(0xff191847)),
                                    decoration: const InputDecoration(
                                      hintText: 'Address*',
                                      border: InputBorder.none,
                                      // icon: Image.asset("assets/images/address.png", height: 20.0,width: 20,)
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text),
                              ),
                            ),


                            SizedBox(height: 10),
                            //checkbox
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isTermCheck = !isTermCheck;
                                });
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      margin: const EdgeInsets.only(top: 1.0, bottom: 0.0),
                                      padding: const EdgeInsets.only(left: 5.0, top: 10.0, bottom: 15.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
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
                                              child:const Row(children: [
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
                            ),

                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                // Full Name
                                if (_userName.text.trim().isEmpty) {
                                  CommonFunctions.showSuccessToast('Please enter full name');
                                  return;
                                }

                                // Mobile
                                if (_userMobile.text.trim().isEmpty) {
                                  CommonFunctions.showSuccessToast('Please enter mobile number');
                                  return;
                                }
                                if (_userMobile.text.length < 10) {
                                  CommonFunctions.showSuccessToast('Please enter valid mobile number');
                                  return;
                                }

                                // Date of Birth
                                if (dob.isEmpty) {
                                  CommonFunctions.showSuccessToast('Please select date of birth');
                                  return;
                                }

                                // Occupation dropdown
                                if (occupationDropdownValue == null) {
                                  CommonFunctions.showSuccessToast('Please select occupation');
                                  return;
                                }

                                // Occupation detail
                                if (_userOccupation.text.trim().isEmpty) {
                                  CommonFunctions.showSuccessToast('Please enter occupation details');
                                  return;
                                }

                                // State
                                if (statedropdownValue == 'Select State') {
                                  CommonFunctions.showSuccessToast('Please select state');
                                  return;
                                }

                                // City
                                if (citydropdownValue == 'Select City') {
                                  CommonFunctions.showSuccessToast('Please select city');
                                  return;
                                }

                                // Address
                                if (_userAddress.text.trim().isEmpty) {
                                  CommonFunctions.showSuccessToast('Please enter address');
                                  return;
                                }

                                // Terms & Conditions
                                if (!isTermCheck) {
                                  CommonFunctions.showSuccessToast('Please accept Terms & Conditions');
                                  return;
                                }

                                // ✅ All validations passed
                                registerRequest();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: size.height * 0.065,
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: kRedColor
                                ),
                                child: const Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 5),
                                    Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Have an account?",
                                  style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder : (context) => SigninScreen())),
                                  child: const Text(
                                    "    Signin",
                                    style: TextStyle(
                                      color: kRedColor,
                                      fontSize: 14,),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),



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
  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context); // close bottom sheet
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context); // close bottom sheet
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile =
    await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }
}
