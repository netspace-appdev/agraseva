import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart'as http;
import 'package:agraseva/responseModel/member_list_model.dart';
import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import '../../controller/socialMemberSignUpController.dart';
import '../../responseModel/GetSocialListResponse.dart';
import 'package:agraseva/responseModel/GetSocialListResponse.dart' as social;

import 'SocialMemberDetailScreen.dart';


class GetsocialMemeberListScreen extends StatefulWidget {
  const GetsocialMemeberListScreen({super.key});

  @override
  State<GetsocialMemeberListScreen> createState() => _GetsocialMemeberListScreenState();
}

class _GetsocialMemeberListScreenState extends State<GetsocialMemeberListScreen> {


  List<social.Result>? memberList = <social.Result>[];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  Constant.prefs?.setBool("loggedIn", false);
    isLoading = true;
    Future.delayed(Duration.zero, () {
      this.getMemberList();
    });
  }
  Future<void> getMemberList() async {
    setState(() => isLoading = true);

    final uri = Uri.parse('${Constant.base_url}/agraapi/GetSocialMemberLists');

    final body = {
      'ProfileID': Constant.prefs!.getString("ProfileID") ?? '',
    };

    try {
      final response = await http.post(uri, body: body);

      final jsonData = json.decode(response.body);

      if (response.statusCode == 200 && jsonData['response_code'] == 200) {

        final socialList = GetSocialListResponse.fromJson(jsonData);

        setState(() {
          memberList = socialList.result ?? [];
          isLoading = false;

        });
      } else {
        setState(() => isLoading = false);
        CommonFunctions.showSuccessToast(jsonData['message']);
      }
    } catch (e) {
      setState(() => isLoading = false);
      CommonFunctions.showSuccessToast("Something went wrong");
      print('memberList${e.toString()}');
    }
  }

/*
  Future<http.Response?> getMemberList() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi/GetSocialMemberLists');
    Map<String, String> body = {
      'ProfileID': Constant.prefs!.getString("ProfileID").toString(),
    };
    print(body);
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
        print("memberListsize:  ${memberList!.length}");
      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: kRedColor,
        title: Text(
          "Social Memebers",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            )),
      ),

      body:  memberList != null && memberList!.isNotEmpty?Container(
       // height: 300,
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          padding: const EdgeInsets.only(bottom: 0.0,top: 0,right: 0),

          child: ListView.builder(
            itemCount: memberList!.length,
            itemBuilder: (context, index) {
              print('memberList....${memberList?[index].name}');
              print('memberList....${memberList?[index].profilePhoto}');
              print('memberList....${memberList?[index].mobile}');
              print('memberList....${memberList?[index].dob}');

              return FeaturedItem(
                result: memberList![index],
              );
            },

            shrinkWrap: true,
            /*physics: NeverScrollableScrollPhysics(),*/
          )):Center(
           child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Image.asset(
          "assets/images/no_data.jfif",
          // height: 150,
        ),
      ],
    ),
    ));

  }
  Widget bottomsheet() {
    return new Scaffold(body:Container(
     // height: 350,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.close_outlined, color: Colors.black38)),

          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Find Partner",
                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only( top: 10.0, right: 5.0,left: 5.0 ),
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(25.0)),
            ),
            child: TextFormField(
              // controller: userNameEditTextController,
                style: TextStyle(
                  /* fontFamily: "segoeregular",*/
                    fontSize: 14,
                    color: Color(0xff191847)
                ),
                decoration: InputDecoration(
                  hintText: 'enter id e.g. - 15',
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number),

          ),
          Container(

            margin: EdgeInsets.only( top: 10.0, right: 5.0,left: 5.0 ),
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(25.0)),
            ),
            child: Text(
              "From age",
              style: TextStyle(
                color: kTextBlackColor,
                fontSize: 14,
              ),
            ),

          ),
        ],
      ),
    ));
  }
}

class FeaturedItem extends StatelessWidget {
  FeaturedItem({
    Key? key,
    required this.result,
  }) : super(key: key);

  final social.Result result;
  final SocialMemberSignupController controller =
  Get.put(SocialMemberSignupController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.getSocialMemberDetailById(id: result.memId);
        print('vuuvuvu${result.profilePhoto}');
      //  Navigator.push(context, MaterialPageRoute(builder: (_) => SocialMemberDetailScreen()),);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PROFILE IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                '${Constant.base_url}/${result.profilePhoto}',
                height: 130,
                width: 90,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 130,
                    width: 90,
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: 100,
                    width: 90,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.person, size: 40),
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            /// DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// NAME
                  Text(
                    result.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),

                  _infoRow(Icons.phone, result.mobile),
                  _infoRow(Icons.date_range, result.dob),
                  _infoRow(
                    Icons.work,
                    buildFullAddress(
                      address: result.address,
                      city: result.cityName,
                    ),
                  ),
                  _infoRow(
                     Icons.location_on,
                     buildFullAddress(
                      address: result.address,
                      city: result.cityName,
                      state: result.stateName,
                    ),
                  ),

                /*  const SizedBox(height: 4),
                  _infoRow(
                    "Job",
                    "${result.jobType ?? ''} - ${result.jobDetails ?? ''}",
                  ),

                  const SizedBox(height: 4),
                  _infoRow(
                    "Location",
                  ),*/

                //  const SizedBox(height: 6),

                  /// ID
                /*  Text(
                    "ID: ASSM${result.memId}",
                    style: const TextStyle(
                      color: kTextBlackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),*/
                ],
              ),
            ),

            /// VIEW BUTTON
          ],
        ),
      ),
    );
  }
  String buildFullAddress({
    String? address,
    String? city,
    String? state,
  }) {
    final parts = <String>[];

    if (address != null && address.isNotEmpty) parts.add(address);
    if (city != null && city.isNotEmpty) parts.add(city);
    if (state != null && state.isNotEmpty) parts.add(state);

    return parts.join(', ');
  }

  /// Reusable text row
  Widget _infoRow(IconData icon,String? value
  //{
  //  required IconData icon,
  //  required String? value,
  //}
  ) {
    if (value == null || value.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: kTextBlackColor,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: kTextGreyColor,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


