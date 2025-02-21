
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

class EditBasicDetailScreen extends StatefulWidget {
  @override
  _EditBasicDetailScreenState createState() => _EditBasicDetailScreenState();
}

class _EditBasicDetailScreenState extends State<EditBasicDetailScreen> {

  bool isLoading = false;
  List<Result>? memberList = <Result>[];
  late Result userModel;

  List<String> heightList = <String>[];
  List<Height> heightListModel = <Height>[];
  String heightId ="";
  String heightdropdownValue = "Select Height";

  String complexiondropdownValue = "Select Complexion";
  List<String> complexionList = <String>['Select Complexion','fair','Very Fair','Wheatish','Wheatish Brown','Dark'];

  String bodyTypedropdownValue = "Select Body Type";
  List<String> bodyTypeList = <String>['Select Body Type','slim','Average','Athletic','Fat'];

  String bloodGroupdropdownValue = "Select blood Group";
  List<String> bloodGroupList = <String>['Select blood Group','O+','O-','A+','A-','B+','B-','AB+','AB-'];


  final _userAge = TextEditingController();
  final _userWeight = TextEditingController();

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
    final uri = Uri.parse(Constant.base_url + '/agraapi/UserProfileUpdateBasicDetails');
    Map<String, String> body = {
      'ProfileID': Constant.prefs!.getString("ProfileID").toString(),
      'weight':_userWeight.text,
      'complexion':complexiondropdownValue,
      'bodytype':bodyTypedropdownValue,
      'bloodgroup':bloodGroupdropdownValue,
      'height':heightId,
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


     // Navigator.of(context).pop();
      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = MemberListModel.fromJson(map);

        memberList = modelData.result;
        userModel = memberList![0];

        print("editBasicDetails:1 "+userModel.complexion.toString());

        if(!userModel.weight.toString().isEmpty  && userModel.weight.toString() != "null"){
          _userWeight.text = userModel.weight.toString();
        }
        if(!userModel.height.toString().isEmpty  && userModel.height.toString() != "null"){
          heightId = userModel.height.toString();
        }
        if(!userModel.bodyType.toString().isEmpty && userModel.bodyType.toString() != "null"){
          bodyTypedropdownValue = userModel.bodyType.toString();
        }
        if(!userModel.bloodGroup.toString().isEmpty && userModel.bloodGroup.toString() != "null"){
          bloodGroupdropdownValue = userModel.bloodGroup.toString();
        }
         if(!userModel.complexion.toString().isEmpty && userModel.complexion.toString() != "null"){
          complexiondropdownValue = userModel.complexion.toString();
        }

        Future.delayed(Duration.zero, () {
          this.getMasterDataRequest();
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

        heightListModel = modelData.result!.height;
        heightList.add('Select Height');
        for (var i = 0; i <  heightListModel.length; i++) {
          heightList.add(heightListModel[i].height!);
          if(heightId==heightListModel[i].hId!){
            heightdropdownValue = heightListModel[i].height!;
          }
        }

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
            "Edit Basic Details",
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
                //complexion
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
                      value:complexiondropdownValue,
                      underline: SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          complexiondropdownValue = newValue.toString();
                        });
                      },
                      items: complexionList
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
                //Body Type
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
                      value:bodyTypedropdownValue,
                      underline: SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          bodyTypedropdownValue = newValue.toString();
                        });
                      },
                      items: bodyTypeList
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
                //blood Group
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
                      value:bloodGroupdropdownValue,
                      underline: SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          bloodGroupdropdownValue = newValue.toString();
                        });
                      },
                      items: bloodGroupList
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
                //Age
                /*Container(
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
                      controller: _userAge,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Age',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                      ],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number),
                ),*/
                // height
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
                        value:  heightdropdownValue,
                        underline: SizedBox(),
                        onChanged: (String? newValue) {
                          setState(() {
                            heightdropdownValue = newValue.toString();
                            for (var i = 0; i < heightListModel .length; i++) {
                              if ( heightListModel[i].height == heightdropdownValue) {
                                heightId =  heightListModel[i].hId!;
                                print( heightId);
                              }

                            }
                          });
                        },
                        items: heightList
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
                //Weight
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
                    controller: _userWeight,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Weight',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
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
