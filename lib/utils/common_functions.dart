import 'package:agraseva/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonFunctions {
  static void showImage(String imageString,BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Container(
        child: Image.network(imageString,
            key: ValueKey(imageString),
        /*    fit: BoxFit.cover,*/
            height:MediaQuery.of(context)
                .size
                .width,
            width: MediaQuery.of(context)
                .size
                .width),
      ),
    );
  }
  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: kRedColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showLoader(bool isshow, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) =>

            AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Container(
                child: const Center(
                    child: CircularProgressIndicator()
                ),
              ),
            )
    );
  }
  static bool isEmail(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }
  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

}
