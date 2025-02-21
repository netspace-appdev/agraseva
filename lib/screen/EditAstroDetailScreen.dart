
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

class EditAstroDetailScreen extends StatefulWidget {
  @override
  _EditAstroDetailScreenState createState() => _EditAstroDetailScreenState();
}

class _EditAstroDetailScreenState extends State<EditAstroDetailScreen> {
  int isManglik = 1;
  bool isLoading = false;
  List<Result>? memberList = <Result>[];
  late Result userModel;


  String rashidropdownValue = "Select Rashi";
  List<String> rashiList = <String>['Select Rashi','Mesha | Aries','Vrishabha | Taurus','Mithuna | Gemini',
  'Karka | Cancer','Simha | Leo','Kanya | Virgo','Tula | Libra','Vrishchika | Scorpio','Dhanu | Sagittarius',
  'Makar | Capricorn','Kumbha | Aquarius','Meena | Pisces'];


  final _Nakshatra = TextEditingController();
  final _userBirthPlace = TextEditingController();

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
    final uri = Uri.parse(Constant.base_url + '/agraapi/UserProfileUpdateAstroDetails');
    String maglik;
    isManglik==1?maglik ='Yes':maglik='No';


    Map<String, String> body = {
      'ProfileID': Constant.prefs!.getString("ProfileID").toString(),
      'Nakshatra':_Nakshatra.text,
      'Manglik':maglik,
      'dob':dob.toString(),
      'age':AgeDifference.toString(),
      'birth_time':dot.toString(),
      'place_birth':_userBirthPlace.text,
      'sunsign':rashidropdownValue,
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
        print("editAstroDetail:  " + memberList!.length.toString());

        if(userModel.dob.toString() != "null"){
          dob = userModel.dob.toString();
        }
        if(userModel.age.toString() != "null"){
          AgeDifference = userModel.age.toString();
        }
        if(userModel.gender.toString() != "null"){
          gender = userModel.gender.toString();
        }
        if(userModel.dot.toString() != "null"){
          dot = userModel.dot.toString();
        }
        if(userModel.nakshatra.toString() != "null"){
          _Nakshatra.text = userModel.nakshatra.toString();
        }
        if(userModel.placeBirth.toString() != "null"){
          _userBirthPlace.text = userModel.placeBirth.toString();
        }
        if(userModel.rashi.toString() == "null"){
          rashidropdownValue = "Select Rashi";
        }else{
          rashidropdownValue = userModel.rashi.toString();
        }
        if(userModel.manglik=='Yes'){
          isManglik =1;
        }else{
          isManglik = 0;
        }
      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }



  TimeOfDay? selectedTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime! );

    if (picked_s != null && picked_s != selectedTime )
      setState(() {
        selectedTime = picked_s;

        dot = '${selectedTime!.hour.toString()}:${selectedTime!.minute}';
        print(dot);
      });
  }

  DateTime? _selectedDate;
 String? dob;
 String? dot;
  String? AgeDifference;
  String? gender;
  void _pickDateDialog() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime
            .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
        dob = '${_selectedDate!.day.toString()}-${_selectedDate!.month.toString()}-${_selectedDate!.year.toString()}';
      });
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
            "Edit Astro Details",
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
                //dob
                GestureDetector(
                onTap: () {
                  _pickDateDialog();

                  },
            child: Container(
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
                  child:Align(
                    alignment: Alignment.centerLeft,
                    child: Text(dob==null //ternary expression to check if date is null
                        ? 'Choose Date of Birth'
                        : dob!),
                  ),


                )),
                //birth time
          GestureDetector(
            onTap: () {
              _selectTime(context);

            },
            child:  Container(
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
                  child:Align(
                    alignment: Alignment.centerLeft,
                    child: Text(dot == null //ternary expression to check if date is null
                        ? 'Choose Birth Date'
                        : dot! ,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),


                )),
              
                //Birth Place
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
                      controller: _userBirthPlace,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Birth Place*',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text),
                ),
                //rashi
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
                      value:rashidropdownValue,
                      underline: SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          rashidropdownValue = newValue.toString();
                        });
                      },
                      items: rashiList
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
                //Nakshatra
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
                     controller: _Nakshatra,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Nakshatra*',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text),
                ),
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
                if(_selectedDate!=null) {
                  final birthday = DateTime(
                      _selectedDate!.year, _selectedDate!.month, _selectedDate!.day);
                  final date2 = DateTime.now();
                  final int difference = date2.difference(birthday).inDays;
                  AgeDifference = (difference/365).floor().toString();
                  print( 'Age" '+AgeDifference.toString());
                }
                print( 'gender" '+gender.toString());
                if(gender.toString()=='Male'){
                  if(int.parse(AgeDifference.toString())<21){
                    CommonFunctions.showSuccessToast('Age should be more then or equal to 21 year');
                  }else{
                    updateProfileDetail();
                  }
                }else{
                  if(int.parse(AgeDifference.toString())<18){
                    CommonFunctions.showSuccessToast('Age should be more then or equal to 18 year');
                  }else{
                    updateProfileDetail();
                  }
                }


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
