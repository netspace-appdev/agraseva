
import 'dart:convert';
import 'package:agraseva/responseModel/city_list_model.dart';
import 'package:agraseva/responseModel/master_model.dart';
import 'package:agraseva/responseModel/member_list_model.dart';
import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class EditFamilyDetailScreen extends StatefulWidget {
  @override
  _EditFamilyDetailScreenState createState() => _EditFamilyDetailScreenState();
}

class _EditFamilyDetailScreenState extends State<EditFamilyDetailScreen> {
  int isHomeType = 1;
  bool isLoading = false;
  List<Result>? memberList = <Result>[];
  late Result userModel;



  final _contactPersonName = TextEditingController();
  final _rsContactPerson = TextEditingController();
  final _timetoCall = TextEditingController();
  final _contactMobile = TextEditingController();
  final _contactEmail = TextEditingController();
  final _mbrother = TextEditingController();
  final _nmbrother = TextEditingController();
  final _msister = TextEditingController();
  final _nmsister = TextEditingController();
  final _fatherOcc = TextEditingController();
  final _detail = TextEditingController();

  @override
  void initState() {
    super.initState();
    print( 'ProfileID21');
    isLoading = true;
    Future.delayed(Duration.zero, () {
      this.getMemberList();
    });
  }

  Future<http.Response?> updateProfileDetail() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi/UserProfileUpdateFamilyDetails');
    String hometype;
   int mbrother = 0;
   int nmbrother = 0;
   int msister = 0;
   int nmsister = 0;
    isHomeType==1?hometype ='rent':hometype='own';

    try {
      mbrother =  int.parse( _mbrother.text);
    } on FormatException {
      mbrother = 0 ;
    }
    try {
      nmbrother =  int.parse( _nmbrother.text);
    } on FormatException {
      nmbrother = 0 ;
    }
    try {
      msister =  int.parse( _msister.text);
    } on FormatException {
      msister = 0 ;
    }
    try {
      nmsister =  int.parse( _nmsister.text);
    } on FormatException {
      nmsister = 0 ;
    }
    int tbrother =mbrother + nmbrother;
    int tsister =msister + nmsister;
    print( 'ProfileID1');
     Map<String, String> body = {
      'ProfileID': Constant.prefs!.getString("ProfileID").toString(),
       'contactperson':_contactPersonName.text,
       'contactperson_relationship':_rsContactPerson.text,
       'btimetocall':_timetoCall.text,
       'cmobile':_contactMobile.text,
       'cemail':_contactEmail.text,
       'fahetr_bussiness':_fatherOcc.text,
       'nmsister':_nmsister.text,
       'msister':_msister.text,
       'tsister':tsister.toString(),
       'nmbrother':_nmbrother.text,
       'mbrother':_mbrother.text,
       'tbrother':tbrother.toString(),
       'remark':_detail.text,
       'home_type':hometype.toString(),

    };
    print( 'ProfileID');
    print(body);
    await http.post(uri, body: body).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
        Navigator.pop(context, true);
      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }
  Future<http.Response?> getMemberList() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi/UserProfile');
    Map<String, String> body = {
      'ProfileID': Constant.prefs!.getString("ProfileID").toString(),
    };
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
        userModel = memberList![0];
        print("memberListsize:  " + memberList!.length.toString());

        if(userModel.cPName.toString() != "null"){
          _contactPersonName.text = userModel.cPName.toString();
        }
        if(userModel.relationCP.toString() != "null"){
          _rsContactPerson.text = userModel.relationCP.toString();
        }
        if(userModel.timeToCall.toString() != "null"){
          _timetoCall.text = userModel.timeToCall.toString();
        }
        if(userModel.mobileCP.toString() != "null"){
          _contactMobile.text = userModel.mobileCP.toString();
        }
        if(userModel.emailCP.toString() != "null"){
          _contactEmail.text = userModel.emailCP.toString();
        }
        if (userModel.mbrother.toString() != "null") {
          _mbrother.text = userModel.mbrother.toString();
        }
        if (userModel.nmbrother.toString() != "null") {
          _nmbrother.text = userModel.nmbrother.toString();
        }
        if (userModel.msister.toString() != "null") {
          _msister.text = userModel.msister.toString();
        }
        if (userModel.nmsister.toString() != "null") {
          _nmsister.text = userModel.nmsister.toString();
        }
        if (userModel.fahetrBussiness.toString() != "null") {
          _fatherOcc.text = userModel.fahetrBussiness.toString();
        }
        if (userModel.remark.toString() != "null") {
          _detail.text = userModel.remark.toString();
        }

        if(userModel.homeType.toString() != "null") {
          if (userModel.homeType == 'rent') {
            isHomeType = 1;
          } else {
            isHomeType = 0;
          }
        }
      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70.0,
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: kRedColor,
          title: Text(
            "Edit Family Details",
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

        body: isLoading
            ? Container()
            : Container(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                //Contact Person Name
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 1.0,
                    )],
                  ),

                  child: TextFormField(
                      controller: _contactPersonName,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Contact Person Name',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text),
                ),
                //Relationship with Contact Person
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 1.0,
                    )],
                  ),

                  child: TextFormField(
                      controller: _rsContactPerson,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Relationship with Contact Person',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text),
                ),
                //Best Time to Call
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 1.0,
                    )],
                  ),

                  child: TextFormField(
                      controller: _timetoCall,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Best Time to Call',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text),
                ),
                //Mobile
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 1.0,
                    )],
                  ),

                  child: TextFormField(
                      controller: _contactMobile,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Mobile',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number),
                ),
                //Email
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 1.0,
                    )],
                  ),

                  child: TextFormField(
                      controller: _contactEmail,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text),
                ),

                //Married Brother
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 1.0,
                    )],
                  ),

                  child: TextFormField(
                      controller: _mbrother,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Married Brother',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number),
                ),
                //Un Married Brother
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 1.0,
                    )],
                  ),

                  child: TextFormField(
                      controller: _nmbrother,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Un Married Brother',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number),
                ),

                //married Sister
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 1.0,
                    )],
                  ),

                  child: TextFormField(
                      controller: _msister,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'married Sister',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number),
                ),
                //Un married Sister
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 1.0,
                    )],
                  ),

                  child: TextFormField(
                      controller: _nmsister,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Un married Sister',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number),
                ),

                //Father Occupation
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 1.0,
                    )],
                  ),

                  child: TextFormField(
                     controller: _fatherOcc,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Father Occupation*',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text),
                ),
                // Family Type
                  Container(
                    margin: EdgeInsets.only(top: 15.0, right: 5.0, left: 5.0,bottom: 15),
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Row(
                                children: [
                                  Text(
                                    "Home Type",
                                    style: TextStyle(
                                      color: kRedColor,
                                      fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHomeType = 1;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.radio_button_checked,
                                            color: isHomeType == 1
                                                ? kRedColor
                                                : Colors.black12,
                                          ),
                                          Text(
                                            "rent",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(width: 20),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHomeType = 0;
                                        });
                                      },
                                      child:Row(
                                        children: [
                                          Icon(
                                            Icons.radio_button_checked,
                                            color: isHomeType == 0
                                                ? kRedColor
                                                : Colors.black12,
                                          ),
                                          Text(
                                            "own",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      )),

                                ],
                              ),
                  ),
                //Detail
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),

                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Write Family & Candidate Job/Business Details",
                      style: TextStyle(
                        color: kRedColor,
                        /*fontWeight: FontWeight.bold,*/
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 1.0,
                    )],
                  ),

                  child: TextFormField(
                      controller: _detail,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Detail',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text),
                ),
                //update
          GestureDetector(
            onTap: () {
              setState(() {
                updateProfileDetail();
              });
            },
            child: Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: kRedColor,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //(x,y)
                      blurRadius: 1.0,
                    )],
                  ),

                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.white,
                        /*fontWeight: FontWeight.bold,*/
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ));
  }

}
