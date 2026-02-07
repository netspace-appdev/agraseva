
import 'dart:convert';
import 'dart:io';
import 'package:agraseva/get_header.dart';
import 'package:http/http.dart'as http;
import 'package:agraseva/utils/constant.dart';

import '../helper.dart';



class SocialRegister{

  static final String SocialMemberSave = 'https://www.agraseva.com/agraapi/SocialMemberSave';
  static final String NewsAndEventResponse = 'https://www.agraseva.com/agraapi/GetNewsList';

 /*static Future<Map<String, dynamic>> addSocialDetailApi({
    required String Name,
    required String MobileNumber,
    required String State,
    required String City,
    required String DOB,
    required String Address,
    required String JobType,
    required String JobDetails,
     required String profilePhoto,
  //  File? image,
  }) async
  {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(SocialMemberSave),
      );

      // Headers
      final header = await MyHeader.getHeaders2();
      header['Content-Type'] = 'application/json';


      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Name', Name, fallback: "0",);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'MobileNumber', MobileNumber, fallback: "",);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'State', State, fallback: "",);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'City', City,fallback: "0",);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'DOB', DOB,fallback: "0",);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Address', Address,fallback: "0",);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'JobType', JobType,fallback: "0",);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'JobDetails', JobDetails,fallback: "0",);

      // Image
      request.files.add(await http.MultipartFile.fromPath('ProfilePhoto', profilePhoto,),);

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Logs
      Helper.ApiReq('SocialMemberSave', request.fields);
      Helper.ApiRes('SocialMemberSave', response.body);

      // Response
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Failed to submit application: ${response.statusCode}',
        );
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }*/


  static Future<Map<String, dynamic>> addSocialDetailApi({
    required String name,
    required String mobileNumber,
    required String state,
    required String city,
    required String dob,
    required String address,
    required String jobType,
    required String jobDetails,
    required String profilePhoto, // FILE, not base64
  }) async {
    try {
      final headers = await MyHeader.getHeaders2();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(SocialMemberSave),
      );

      request.headers.addAll(headers);

      // 🔹 Text fields
      request.fields['Name'] = name;
      request.fields['MobileNumber'] = mobileNumber;
      request.fields['State'] = state;
      request.fields['City'] = city;
      request.fields['DOB'] = dob;
      request.fields['Address'] = address;
      request.fields['JobType'] = jobType;
      request.fields['JobDetails'] = jobDetails;
      request.fields['Status'] = '1';
      request.fields["ProfilePhoto"]= profilePhoto; // ✅ base64 here

      // 🔹 File field (matches Postman)
     /* request.files.add(
        await http.MultipartFile.fromPath(
          'ProfilePhoto',
          profilePhoto,
        ),
      );*/

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq('SocialMemberSave', request.fields);
      Helper.ApiRes('SocialMemberSave', response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>> getNewsAndEventApi() async {
    try {
      final headers = await MyHeader.getHeaders2();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(NewsAndEventResponse),
      );


      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq('NewsAndEventResponse', request.fields);
      Helper.ApiRes('NewsAndEventResponse', response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error while submitting: $e');
    }
  }

}