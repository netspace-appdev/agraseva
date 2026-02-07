// ignore: file_names
// ignore: file_names

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:agraseva/controller/socialMemberSignUpController.dart';
import 'package:agraseva/responseModel/city_list_model.dart';
import 'package:agraseva/responseModel/gotra_list_model.dart';
import 'package:agraseva/responseModel/state_list_model.dart';
import 'package:agraseva/screen/SigninScreen.dart';
import 'package:agraseva/screen/TermsConditionScreen.dart';
import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../widgets/preLoginDrawer.dart';

class SocialMemberSignupScreen extends StatefulWidget {
  @override
  _SocialMemberSecondSignupScreenState createState() => _SocialMemberSecondSignupScreenState();
}

class _SocialMemberSecondSignupScreenState extends State<SocialMemberSignupScreen> {

  final SocialMemberSignupController socialMemberSignupController =Get.put(SocialMemberSignupController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    socialMemberSignupController.isLoading(true);
    Future.delayed(Duration.zero, () {
      this.getStateRequest();
    });

  }


  Future<http.Response?> getStateRequest() async {

    final uri = Uri.parse(Constant.base_url+'/agraapi/GetState');

    await  http.post(uri,
    ).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      setState(() {
        socialMemberSignupController.isLoading(false);
      });
     // Navigator.of(context).pop();
      if(jsonData['response_code']==200){
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = StateListModel.fromJson(map);

        socialMemberSignupController.stateListModel.value = modelData.result!;
        socialMemberSignupController.stateList.value.add('Select State');
        for (var i = 0; i < socialMemberSignupController.stateListModel.length; i++) {
          socialMemberSignupController.stateList.add(socialMemberSignupController.stateListModel[i].state!);
        }
        print('statelenght:  '+socialMemberSignupController.stateList.length.toString());
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
        socialMemberSignupController.isLoading(false);
      });
      if(jsonData['response_code']==200){
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = CityListModel.fromJson(map);
        socialMemberSignupController.cityList.clear();
        socialMemberSignupController.cityListModel.value = modelData.result!;
        socialMemberSignupController.cityList.add('Select City');
        for (var i = 0; i < socialMemberSignupController.cityListModel.length; i++) {
          socialMemberSignupController.cityList.add(socialMemberSignupController.cityListModel[i].district!);
        }
        print('citylenght:  '+socialMemberSignupController.cityList.length.toString());
      }
      else{
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    }
    );
  }




/*
  Future<http.Response?> registerRequest() async {
    CommonFunctions.showLoader(true, context);
  //  final uri = Uri.parse(Constant.base_url+'/agraapi/SocialMemberSave');
    final uri = Uri.parse('https://www.agraseva.com/agraapi/SocialMemberSave');
    Map<String, String> body = {
      'Name': _userName.text,
      'MobileNumber': _userMobile.text,
      'DOB': dob,
      'State': stateId,
      'City': cityId,
      'Address': _userAddress.text,
      'JobType':'1', //occupationDropdownValue.toString() ,
      'JobDetails':_userOccupation.text ,
      'ProfilePhoto': '',
    };
    print(body);
    await  http.post(uri,  body: body
    ).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      setState(() {
        socialMemberSignupController.isLoading = false;
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
*/

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: new PreLoginDrawer(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image:  AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Form(
          key: _formKey,
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
                child: socialMemberSignupController.isLoading(false)
                    ?Container()
                    :Container(
                  margin: EdgeInsets.only(top: 0, right: 20, left: 20, bottom: 20),
                  alignment: Alignment.center,
                  height:  MediaQuery.of(context).size.height*4/6,
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
                                    socialMemberSignupController.profileImage.value != null ? FileImage(socialMemberSignupController.profileImage.value!) : null,
                                    child: socialMemberSignupController.profileImage.value == null
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
                                      controller: socialMemberSignupController.userName,
                                      style: const TextStyle(
                                        /* fontFamily: "segoeregular",*/
                                          fontSize: 14,
                                          color: Color(0xff191847)
                                      ),
                                      decoration: const InputDecoration(
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
                                      controller: socialMemberSignupController.userMobile,
                                      maxLength: 10,
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
                                        socialMemberSignupController.dob.value =
                                        "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                      });
                                    }
                                  },
                                  child: InputDecorator(
                                    decoration:  const InputDecoration(
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
                                        socialMemberSignupController.dob.value.isEmpty ? 'Date of Birth' : socialMemberSignupController.dob.value,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: socialMemberSignupController.dob.value.isEmpty
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
                                width:  MediaQuery.of(context).size.width,
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
                                        value: socialMemberSignupController.occupationDropdownValue.value,
                                        underline: const SizedBox(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            socialMemberSignupController.occupationDropdownValue.value = newValue;
                                          });
                                        },
                                        items: socialMemberSignupController.occupationList.map((String value) {
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
                                      controller: socialMemberSignupController.userOccupation,
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
                                      maxLines: 1,
                                      keyboardType: TextInputType.text),
                                ),

                              ),
                              const SizedBox(height: 10),
                              //State
                              Container(
                                  height: 50,
                                  width:  MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only( top: 10.0,  right: 5.0, left: 5.0 ),
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
                                      Image.asset("assets/images/state.png",
                                        height: 20.0,width: 20,
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        flex: 1,
                                        child: Obx(()=>
                                           DropdownButton<String>(
                                              isExpanded: true,
                                              icon: Icon(
                                                Icons.keyboard_arrow_down_outlined,
                                                color: Colors.black,
                                              ),
                                              iconSize: 25,
                                              value: socialMemberSignupController.stateDropdownValue.value,
                                              underline: SizedBox(),
                                              onChanged: (String? newValue) {
                                              //  setState(() {
                                                  socialMemberSignupController.stateDropdownValue.value = newValue.toString();
                                                  socialMemberSignupController.cityDropdownValue.value = "Select City";
                                                  for (var i = 0; i < socialMemberSignupController.stateListModel .length; i++) {
                                                    if (socialMemberSignupController.stateListModel[i].state == socialMemberSignupController.stateDropdownValue.value) {
                                                      socialMemberSignupController.stateId.value =  socialMemberSignupController.stateListModel[i].stateId!;
                                                   //   print(stateId);
                                                      getCityRequest(socialMemberSignupController.stateId.value);
                                                    }

                                                  }
                                               // });
                                              },
                                              items: socialMemberSignupController.stateList
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
                                      ),
                                    ],
                                  )


                              ),
                              SizedBox(height: 10),
                              //City
                              Container(
                                  height: 50,
                                  width:  MediaQuery.of(context).size.width,
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
                                        child: Obx(()=>

                                           DropdownButton<String>(
                                              isExpanded: true,
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down_outlined,
                                                color: Colors.black,
                                              ),
                                              iconSize: 25,
                                              value: socialMemberSignupController.cityDropdownValue.value,
                                              underline: SizedBox(),
                                              onChanged: (String? newValue) {
                                                socialMemberSignupController.cityDropdownValue.value = newValue.toString();
                                                for (var i = 0; i < socialMemberSignupController.cityListModel .length; i++) {
                                                  if (socialMemberSignupController.cityListModel[i].district == socialMemberSignupController.cityDropdownValue.value) {
                                                    socialMemberSignupController.cityId.value =  socialMemberSignupController.cityListModel[i].distId!;
                                                    print( socialMemberSignupController.cityId.value);
                                                  }
                                                }

                                              },
                                              items: socialMemberSignupController.cityList
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
                                                  }).toList())
                                        ),
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
                                      controller: socialMemberSignupController.userAddress,
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
                                  //setState(() {
                                    socialMemberSignupController.isTermCheck.value = socialMemberSignupController.isTermCheck.value;
                                 // });
                                },
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Obx(()=>
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0.0,
                                              top: 10.0,
                                              bottom: 10.0),
                                          child: socialMemberSignupController.isTermCheck.value
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
                                                   // setState(() {
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (BuildContext context) =>
                                                              TermsConditionScreen()));
                                                   // });

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
                              ),

                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  // Full Name
                                 // if (_formKey.currentState?.validate() != true) {}
                                  if (_formKey.currentState?.validate() != true) {
                                    return; // stop if form is invalid
                                  }

                                  if (socialMemberSignupController.userName.text.trim().isEmpty) {
                                    CommonFunctions.showSuccessToast('Please enter full name');
                                    return;
                                  }

                                  // Mobile
                                  if (socialMemberSignupController.userMobile.text.trim().isEmpty) {
                                    CommonFunctions.showSuccessToast('Please enter mobile number');
                                    return;
                                  }
                                  if (socialMemberSignupController.userMobile.text.length < 10) {
                                    CommonFunctions.showSuccessToast('Please enter valid mobile number');
                                    return;
                                  }

                                  // State
                                  if (socialMemberSignupController.stateDropdownValue.value == 'Select State') {
                                    CommonFunctions.showSuccessToast('Please select state');
                                    return;
                                  }

                                  // City
                                  if (socialMemberSignupController.cityDropdownValue.value == 'Select City') {
                                    CommonFunctions.showSuccessToast('Please select city');
                                    return;
                                  }



                                  // Terms & Conditions
                                /*  if (socialMemberSignupController.isTermCheck.value) {
                                    CommonFunctions.showSuccessToast('Please accept Terms & Conditions');
                                    return;

                                  }*/
                                  // ✅ All validations passed
                                  socialMemberSignupController.registerRequest(
                                  /*   name:_userName.text,
                                     mobile:_userMobile.text,
                                      dob:dob, stateId:stateId,
                                    cityId:cityId,
                                    Address: _userAddress.text,
                                    JobType: occupationDropdownValue.toString() ,
                                    JobDetails:_userOccupation.text ,
                                    profilePhoto: _profileImage,*/
                                  );

                                 // if (socialMemberSignupController.socialLoginResponse.value?.responseCode== 200) {
                                    //isLoading(false);

                                    // clear(mobile, dob, stateId, cityId, Address, JobType, JobDetails,profilePhoto,name);

                                    //   clear();
                                    //   SnackbarHelper.showSnackbar(title: AppText.success, message: data['message'] );
                                    //Get.back();
                                 // }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height:  MediaQuery.of(context).size.height * 0.065,
                                  width:  MediaQuery.of(context).size.width,
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
        socialMemberSignupController.profileImage.value = File(pickedFile.path);
      });
    }
  }
}
