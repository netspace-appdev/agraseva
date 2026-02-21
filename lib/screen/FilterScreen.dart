
import 'dart:convert';
import 'package:agraseva/responseModel/city_list_model.dart';
import 'package:agraseva/responseModel/master_model.dart';
import 'package:agraseva/responseModel/member_list_model.dart';
import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  bool isLoading = false;
  List<Result>? memberList = <Result>[];
  late Result userModel;


  List<String> educationList = <String>[];
  List<Education> educationListModel = <Education>[];
  String educationId ="";
  String educationdropdownValue = "Select Education";

  List<String> heightListFrom = <String>[];
  List<String> heightListTo = <String>[];
  List<Height> heightListModel = <Height>[];
  String heightIdFrom ="";
  String heightdropdownValueFrom = "Select Height From";
  String heightIdTo ="";
  String heightdropdownValueTo = "Select Height To";

  List<String> maritalList = <String>[];
  List<MaritialStatus> maritalListModel = <MaritialStatus>[];
  String maritaldropdownValue = "Select Marital Status";
  String maritalId = "";

  final _profileId= TextEditingController();
  final _ageFrom = TextEditingController();
  final _ageTo = TextEditingController();
  int isManglik = 1;
  @override
  void initState() {
    super.initState();

    isLoading = true;
    Future.delayed(Duration.zero, () {
      this.getMasterDataRequest();
    });
  }
  Future<http.Response?> getMasterDataRequest() async {
     CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url+'/agraapi/GetMaster');

    await  http.post(uri,
    ).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      if(jsonData['response_code']==200){
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = MasterModel.fromJson(map);

        heightListModel = modelData.result!.height;
        heightListFrom.add('Select Height From');
        heightListTo.add('Select Height To');
        for (var i = 0; i <  heightListModel.length; i++) {
          heightListFrom.add(heightListModel[i].height!);
          heightListTo.add(heightListModel[i].height!);
          if(heightIdFrom==heightListModel[i].hId!){
            heightdropdownValueFrom = heightListModel[i].height!;
          }
          if(heightIdTo==heightListModel[i].hId!){
            heightdropdownValueTo = heightListModel[i].height!;
          }
        }
        educationListModel = modelData.result!.education;
        educationList.add('Select Education');
        for (var i = 0; i < educationListModel.length; i++) {
          educationList.add(educationListModel[i].education!);
          if(educationId==educationListModel[i].eId!){
            educationdropdownValue = educationListModel[i].education!;
          }
        }
        print('education lenght:  '+educationList.length.toString());

        maritalListModel = modelData.result!.maritialStatus;
        maritalList.add('Select Marital Status');
        for (var i = 0; i <  maritalListModel.length; i++) {
          maritalList.add( maritalListModel[i].name!);
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
            "Find Partner",
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
                      controller: _profileId,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Profile ID',
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(8),
                      ],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2.5,
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
                        controller: _ageFrom,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            hintText: 'Age From',
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2.5,
                      margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                      padding: EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
                      decoration: const BoxDecoration(
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
                          controller: _ageTo,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Age To',
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number),
                    ),
                  ],
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
                                print(educationId);

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
                // height from
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 50,
                        width:  MediaQuery.of(context).size.width/2.3,
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
                            value:  heightdropdownValueFrom,
                            underline: SizedBox(),
                            onChanged: (String? newValue) {
                              setState(() {
                                heightdropdownValueFrom = newValue.toString();
                                for (var i = 0; i < heightListModel .length; i++) {
                                  if ( heightListModel[i].height == heightdropdownValueFrom) {
                                    heightIdFrom =  heightListModel[i].hId!;
                                    print( heightIdFrom);
                                  }

                                }
                              });
                            },
                            items: heightListFrom
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
                    Container(
                        height: 50,
                        width:  MediaQuery.of(context).size.width/2.5,
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
                            value:  heightdropdownValueTo,
                            underline: SizedBox(),
                            onChanged: (String? newValue) {
                              setState(() {
                                heightdropdownValueTo = newValue.toString();
                                for (var i = 0; i < heightListModel .length; i++) {
                                  if ( heightListModel[i].height == heightdropdownValueTo) {
                                    heightIdTo =  heightListModel[i].hId!;
                                    print( heightIdTo);
                                  }

                                }
                              });
                            },
                            items: heightListTo
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
                  ],
                ),
                // height from
                // Manglik
                Container(
                  margin: EdgeInsets.only(top: 15.0, right: 5.0, left: 5.0,bottom: 15),
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Manglik",
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
                              isManglik = 1;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.radio_button_checked,
                                color: isManglik == 1
                                    ? kRedColor
                                    : Colors.black12,
                              ),
                              Text(
                                "Yes",
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
                              isManglik = 0;
                            });
                          },
                          child:Row(
                            children: [
                              Icon(
                                Icons.radio_button_checked,
                                color: isManglik == 0
                                    ? kRedColor
                                    : Colors.black12,
                              ),
                              Text(
                                "No",
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
                //update
          GestureDetector(
            onTap: () {
              setState(() {
               // updateProfileDetail();
                String maglik;
                isManglik==1?maglik ='Yes':maglik='No';
                Map<String, String> body = {
                  'mobileno': Constant.prefs!.getString("contact").toString(),
                  'gender': Constant.prefs!.getString("gender").toString(),
                  'gotra': Constant.prefs!.getString("gotra").toString(),
                  'HeightFrom': heightIdFrom,
                  'HeightTo': heightIdTo,
                  'Education': educationId,
                  'MarriedStatus': maritalId,
                  'AgeFrom': _ageFrom.text,
                  'AgeTo': _ageTo.text,
                  'ProfileID': _profileId.text,
                  'ManglikStatus': maglik,
                };
                FBroadcast.instance().broadcast(
                  "filter_data",
                  value: body,
                );
                Navigator.of(context).pop();

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
                      "Apply",
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
