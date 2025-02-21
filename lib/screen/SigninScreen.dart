

import 'dart:convert';

import 'package:agraseva/responseModel/member_list_model.dart';
import 'package:agraseva/screen/HomeScreen.dart';
import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ForgotPasswordScreen.dart';
import 'SignupScreen.dart';

import 'package:http/http.dart' as http;
class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _userMobile = TextEditingController();
  final _password = TextEditingController();
  List<Result>? memberList = <Result>[];
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                child:Center(
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
              flex: 9,
              child: Center(

                  child: Container(
                    margin: EdgeInsets.only(top: 0, right: 20, left: 20, bottom: 10),
                    alignment: Alignment.center,
                     height: size.height*4/6,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25.0),),
                    ),
                    padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
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
                                          "Log",
                                          style: TextStyle(fontSize: 30, color: Colors.black,fontWeight: FontWeight.bold),),
                                        Text(
                                          "in",
                                          style: TextStyle(fontSize: 30, color: kRedColor,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0
                                    ),
                                    child: Text("Please enter your login details",
                                      style: TextStyle(fontSize: 14, color: Colors.black54),),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  margin: EdgeInsets.only( left: 0.0, right: 0.0, ),
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
                                            hintText: 'Mobile No.',
                                            border: InputBorder.none,
                                              icon: Image.asset("assets/images/mobile.png",
                                                height: 20.0,width: 20,
                                              )
                                          ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number),

                                ),
                                SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.only( top: 10.0, right: 0.0, ),
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
                                          fontSize: 14,
                                          color: Color(0xff191847)
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        border: InputBorder.none,
                                          icon: Icon(
                                            Icons.lock_open_sharp,
                                            color: kRedColor,
                                            size: 20.0,
                                          )
                                      ),
                                      textInputAction: TextInputAction.done,
                                      obscureText: true,
                                      keyboardType: TextInputType.text),
                                ),
                                SizedBox(height: 40),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder : (context) => ForgotPasswordScreen())),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Forgot ",
                                          style: TextStyle(fontSize: 14, color: Colors.black/*,fontWeight: FontWeight.bold*/),),
                                        Text(
                                          "password?",
                                          style: TextStyle(fontSize:14, color: kRedColor/*,fontWeight: FontWeight.bold*/),),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 40),
                                GestureDetector(
                                  onTap: () {
                                    if(_userMobile.text.isEmpty){
                                      CommonFunctions.showSuccessToast('Please enter valid number');
                                      }
                                    else  if(_password.text.isEmpty){
                                      CommonFunctions.showSuccessToast('Please enter password');
                                    }else{
                                      setState(() {

                                        loginRequest();
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 5),
                                        Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                             onTap: () => Navigator.push(context, MaterialPageRoute(builder : (context) => SignupScreen())),
                                child: Text(
                                  "    Signup",
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
            ),
          ],
        ),
      ),
    );

  }

  Future<http.Response?> loginRequest() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url+'/agraapi/UserLogin');
    Map<String, String> body = {
      'mobileno': _userMobile.text,
      'password': _password.text,
    };
    await  http.post(uri,
        /* headers: {"Content-Type": "application/json"},*/
        body: body
    ).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      Navigator.of(context).pop();
      if(jsonData['response_code']==200){
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = MemberListModel.fromJson(map);

        memberList = modelData.result;
        print("memberListsize:  " + memberList!.length.toString());
        print("memberType:  " + memberList![0].memberType!);
     Constant.prefs?.setBool("loggedIn", true);
     Constant.prefs?.setString("ProfileID", memberList![0].mId!);
     Constant.prefs?.setString("contact", memberList![0].contact!);
     Constant.prefs?.setString("token", memberList![0].token!);
     Constant.prefs?.setString("name", memberList![0].fName!+' '+ memberList![0].lName!);
   Constant.prefs?.setString("gender", memberList![0].gender!);
     Constant.prefs?.setString("gotra", memberList![0].gotra!);
     Constant.prefs?.setString("userStatus", memberList![0].status!);
     Constant.prefs?.setString("memberType", memberList![0].memberType!);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context) =>
                HomeScreen()));
      }
      else{
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }

    }

    );
  }

}

