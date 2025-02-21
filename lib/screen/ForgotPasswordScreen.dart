// ignore: file_names


import 'package:agraseva/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'SignupScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
              image:  AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 0, right: 20, left: 20, bottom: 20),
            alignment: Alignment.center,
            height: size.height/2,
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
                                  "Forgot ",
                                  style: TextStyle(fontSize: 30, color: Colors.black,fontWeight: FontWeight.bold),),
                                Text(
                                  "Password",
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
                            // controller: userNameEditTextController,
                              style: TextStyle(
                                /* fontFamily: "segoeregular",*/
                                  fontSize: 14,
                                  color: Color(0xff191847)
                              ),
                              decoration: InputDecoration(
                                  hintText: 'Phone No.*',
                                  border: InputBorder.none,
                                  icon: Image.asset("assets/images/mobile.png",
                                    height: 20.0,width: 20,
                                  )
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number),

                        ),
                        SizedBox(height: 10),

                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context, true);
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
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
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
      ),
    );
  }
}
