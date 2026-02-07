


import 'package:agraseva/utils/constant.dart';

class MyHeader{
  static Future<Map<String, String>> getHeaders2() async {
    String? token =  Constant.prefs!.getString("ProfileID").toString();

    if (token == null) {
      throw Exception("No token found. Please login again.");
    }

    return {
      'Authorization': 'Bearer $token',
      'accept': 'text/plain',
    };
  }

  static Future<Map<String, String>> getHeader() async {
    String? token =  Constant.prefs!.getString("ProfileID").toString();

    if (token == null) {
      throw Exception("No token found. Please login again.");
    }

    return {
      'Authorization': 'Bearer $token',
      'accept': 'text/plain',
      'Content-Type': 'multipart/form-data'
    };
  }



  static Future<Map<String, String>> getHeaders3() async {
    String? token =  Constant.prefs!.getString("Token").toString();

    if (token == null) {
      throw Exception("No token found. Please login again.");
    }

    return {
      'Authorization': 'Bearer $token',
      'accept': 'text/plain',
      'Content-Type': 'application/json'
    };
  }
}