
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

class EditProfileDetailScreen extends StatefulWidget {
  @override
  _EditProfileDetailScreenState createState() => _EditProfileDetailScreenState();
}

class _EditProfileDetailScreenState extends State<EditProfileDetailScreen> {

  bool isLoading = false;
  List<Result>? memberList = <Result>[];
  late Result userModel;

  List<String> gotraList = <String>[];
  List<Gotra> gotraListModel = <Gotra>[];
  String gotraId ="";
  String gotradropdownValue = "Select Gotra";

  List<String> stateList = <String>[];
  List<StateName> stateListModel = <StateName>[];
  String stateId ="";
  String statedropdownValue = "Select State";

  List<String> cityList = <String>[];
  List<CityResult> cityListModel = <CityResult>[];
  String cityId ="";
  String citydropdownValue = "Select City";

  List<String> educationList = <String>[];
  List<Education> educationListModel = <Education>[];
  String educationId ="";
  String educationdropdownValue = "Select Education";


  List<String> occupationList = <String>[];
  List<Bussiness> occupationListModel = <Bussiness>[];
  String occupationId ="";
  String occupationdropdownValue = "Select Occupation";

  List<String> maritalList = <String>[];
  List<MaritialStatus> maritalListModel = <MaritialStatus>[];
  String maritaldropdownValue = "Select Marital Status";
  String maritalId ="";

  final _userName = TextEditingController();
  final _userFatherName = TextEditingController();
  final _userContact = TextEditingController();
  final _userAltContact = TextEditingController();
  final _userAadhar = TextEditingController();
  final _userEmail = TextEditingController();
  final _userAddress = TextEditingController();
  final _userPincode = TextEditingController();
  final _userIncome = TextEditingController();

  @override
  void initState() {
    super.initState();

    isLoading = true;
    Future.delayed(Duration.zero, () {
      this.getMemberList();
    });
  }
  Future<http.Response?> updateProfileDetail() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi/UserProfileUpdateProfile');
    Map<String, String> body = {
      'ProfileID': Constant.prefs!.getString("ProfileID").toString(),
      'f_name':_userName.text,
      'mobile':_userContact.text,
      'alt_mobile':_userAltContact.text,
      'father_name':_userFatherName.text,
      'email':_userEmail.text,
      'aadhar_no':_userAadhar.text,
      'pincode':_userPincode.text,
      'address':_userAddress.text,
      'Occupation':occupationId,
      'education':educationId,
      'marid_status':maritalId,
      'dist':cityId,
      'state':stateId,
      'income1':_userIncome.text,
    };
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

     // Navigator.of(context).pop();
      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = MemberListModel.fromJson(map);

        memberList = modelData.result;
        userModel = memberList![0];
        print("UserProfile:  " + memberList!.length.toString());
        _userName.text = userModel.fName.toString()+' '+userModel.lName.toString();
        _userFatherName.text = userModel.fatherName.toString();
        _userContact.text = userModel.contact.toString();
        _userAltContact.text = userModel.altContact.toString();
        if(userModel.aadharNo.toString()!="null"){
          _userAadhar.text = userModel.aadharNo.toString();
        }
        if(userModel.email.toString()!="null"){
          _userEmail.text = userModel.email.toString();
        }
        if(userModel.pincode.toString()!="null"){
          _userPincode.text = userModel.pincode.toString();
        }
        if(userModel.income.toString()!="null"){
          _userIncome.text = userModel.income.toString();
        }
        if(userModel.address.toString()!="null"){
          _userAddress.text = userModel.address.toString();
        }
        print("UserProfile: maridStatus: " + userModel.maridStatus.toString());
        stateId = userModel.stateId.toString();
        cityId = userModel.distId.toString();


        educationId = userModel.eId.toString();
        occupationId = userModel.bId.toString();
        maritalId = userModel.maridStatus.toString();


        Future.delayed(Duration.zero, () {
          this.getMasterDataRequest();
          this. getCityRequest(stateId);
        });
      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }

  Future<http.Response?> getMasterDataRequest() async {
    // CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url+'/agraapi/GetMaster');

    await  http.post(uri,
    ).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      if(jsonData['response_code']==200){
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = MasterModel.fromJson(map);

        gotraListModel = modelData.result!.gotra;
        gotraList.add('Select Gotra');
        for (var i = 0; i < gotraListModel.length; i++) {
          gotraList.add(gotraListModel[i].gotra!);
        }
        print('gotra lenght:  '+gotraList.length.toString());

        stateListModel = modelData.result!.state;
        stateList.add('Select State');
        for (var i = 0; i < stateListModel.length; i++) {
          stateList.add(stateListModel[i].state!);
          if(stateId==stateListModel[i].stateId!){
            statedropdownValue = stateListModel[i].state!;
          }
        }
        print('statelenght:  '+stateList.length.toString());

        educationListModel = modelData.result!.education;
        educationList.add('Select Education');
        for (var i = 0; i < educationListModel.length; i++) {
          educationList.add(educationListModel[i].education!);
          if(educationId==educationListModel[i].eId!){
            educationdropdownValue = educationListModel[i].education!;
          }
        }
        print('education lenght:  '+educationList.length.toString());

        occupationListModel = modelData.result!.bussiness;
        occupationList.add('Select Occupation');
        for (var i = 0; i < occupationListModel.length; i++) {
          occupationList.add(occupationListModel[i].business!);
          if(occupationId==occupationListModel[i].bId!){
            occupationdropdownValue = occupationListModel[i].business!;
          }
        }
        print('occupation lenght:  '+occupationList.length.toString());


        maritalListModel = modelData.result!.maritialStatus;
        maritalList.add('Select Marital Status');
        for (var i = 0; i <  maritalListModel.length; i++) {
          maritalList.add( maritalListModel[i].name!);
          if(maritalId==maritalListModel[i].maridId!){
            maritaldropdownValue = maritalListModel[i].name!;
          }
        }
        print('marit lenght:  '+occupationList.length.toString());

        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
      else{
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    }
    );
  }
  Future<http.Response?> getCityRequest(String StateID) async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url+'/agraapi/getCity');
    Map<String, String> body = {
      'StateID': StateID,
    };
    print(body);
    await  http.post(uri,body: body
    ).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      Navigator.of(context).pop();
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
          if(cityId==cityListModel[i].distId!){
            citydropdownValue = cityListModel[i].district!;
          }
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
            "Edit Profile Details",
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
                Container(
                  margin: EdgeInsets.only(top: 20.0, right: 5.0, left: 5.0),
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
                    controller: _userName,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Name*',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text),
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
                   controller: _userFatherName,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Fathers Name*',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text),
                ),
             /*   Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
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
                      blurRadius: 1.0,
                    )],
                  ),
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
                                        0xff191847) *//* fontFamily: "segoesemibold"*//*),
                              ),
                            );
                          }).toList()),


                ),*/
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
                    controller: _userContact,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Contact No.*',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number),
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
                      controller: _userAltContact,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Contact No.*',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number),
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
                    controller: _userAadhar,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Aadhar No.*',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                      ],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number),
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
                     controller: _userEmail,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Email*',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress),
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
                     controller: _userAddress,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Address*',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text),
                ),
                //pincode
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
                   controller: _userPincode,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Pincode No.*',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                      ],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number),
                ),
                //state
                Container(
                    height: 50,
                    width:  MediaQuery.of(context).size.width,
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
                        blurRadius: 2.0,
                      )],
                    ),
                    child:DropdownButton<String>(
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
                            }).toList())


                ),
                //City
                Container(
                    height: 50,
                    width:  MediaQuery.of(context).size.width,
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
                        blurRadius: 2.0,
                      )],
                    ),
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
                                print('cityId:  '+cityId);
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
                            }).toList())


                ),
                //marital status
                Container(
                    height: 50,
                    width:  MediaQuery.of(context).size.width,
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
                        blurRadius: 2.0,
                      )],
                    ),
                    child:DropdownButton<String>(
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black,
                        ),
                        iconSize: 25,
                        value: maritaldropdownValue,
                        underline: SizedBox(),
                        onChanged: (String? newValue) {
                          setState(() {
                            maritaldropdownValue = newValue.toString();
                            for (var i = 0; i < maritalListModel .length; i++) {
                              if (maritalListModel[i].name == maritaldropdownValue) {
                                maritalId =  maritalListModel[i].maridId!;
                                print(maritalId);

                              }

                            }
                          });
                        },
                        items: maritalList
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
                //education
                Container(
                    height: 50,
                    width:  MediaQuery.of(context).size.width,
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
                        blurRadius: 2.0,
                      )],
                    ),
                    child:DropdownButton<String>(
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black,
                        ),
                        iconSize: 25,
                        value: educationdropdownValue,
                        underline: SizedBox(),
                        onChanged: (String? newValue) {
                          setState(() {
                            educationdropdownValue = newValue.toString();
                            for (var i = 0; i < educationListModel .length; i++) {
                              if (educationListModel[i].education == educationdropdownValue) {
                                educationId =  educationListModel[i].eId!;
                                print(educationId);

                              }

                            }
                          });
                        },
                        items: educationList
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
                            }).toList())


                ),
                //occupation
                Container(
                    height: 50,
                    width:  MediaQuery.of(context).size.width,
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
                        blurRadius: 2.0,
                      )],
                    ),
                    child:DropdownButton<String>(
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black,
                        ),
                        iconSize: 25,
                        value: occupationdropdownValue,
                        underline: SizedBox(),
                        onChanged: (String? newValue) {
                          setState(() {
                            occupationdropdownValue = newValue.toString();
                            for (var i = 0; i < occupationListModel .length; i++) {
                              if (occupationListModel[i].business == occupationdropdownValue) {
                                occupationId =  occupationListModel[i].bId!;
                                print(occupationId);

                              }

                            }
                          });
                        },
                        items: occupationList
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
                            }).toList())


                ),
                //income
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
                    controller: _userIncome,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Income',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number),
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
