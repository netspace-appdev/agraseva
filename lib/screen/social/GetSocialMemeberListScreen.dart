import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:agraseva/responseModel/member_list_model.dart';
import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
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

    final uri = Uri.parse(
        '${Constant.base_url}/agraapi/GetSocialMemberLists');

    final body = {
      'ProfileID': Constant.prefs!.getString("ProfileID") ?? '',
    };

    try {
      final response = await http.post(uri, body: body);

      final jsonData = json.decode(response.body);

      if (response.statusCode == 200 &&
          jsonData['response_code'] == 200) {

        final socialList =
        GetSocialListResponse.fromJson(jsonData);

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

      body: Container(
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          padding: const EdgeInsets.only(bottom: 0.0,top: 0,right: 0),

          child: GridView.builder(
            itemCount: memberList!.length,
            itemBuilder: (context, index) {
              return FeaturedItem(
                result: memberList![index],
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
            ),
            shrinkWrap: false,
            /*physics: NeverScrollableScrollPhysics(),*/
          )),
    );
  }
  Widget bottomsheet() {
    return new Scaffold(body:Container(
      height: 350,
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
  const FeaturedItem({
    Key? key,
    required this.result,
  }) : super(key: key);

  final social.Result result;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SocialMemberDetailScreen(profileID: result.id,);
        }));
      },
      child: Container(
        /*height: 280.0,*/
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 0.3), //(x,y)
              spreadRadius: 0.0,
              blurRadius: 2.0,
            ),
          ],
        ),
        margin: EdgeInsets.only(left: 3.0, right: 3.0, bottom: 5.0),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          '${Constant.base_url}/${result.profilePhoto}',
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,

                          // ✅ Loader while image loads
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          },

                          // ✅ Error image if URL fails
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          result.name.toString(),
                             // ' ' +
                            //  result.lName.toString(),
                          maxLines: 1,
                          style: const TextStyle(
                              color: kTextBlackColor,
                              fontSize: 14,
                              letterSpacing: 0.1,
                              height: 1.2,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Text('Mobile: ',
                              maxLines: 1,
                              style: TextStyle(
                                color:  Colors.black,
                                fontSize: 12,
                                letterSpacing: 0.1,
                              )), Text(
                              ' ' + result.mobileNumber.toString(),
                              maxLines: 1,
                              style: const TextStyle(
                                color: kTextGreyColor,
                                fontSize: 12,
                                letterSpacing: 0.1,
                                height: 1.2,
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,

                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('City-',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                letterSpacing: 0.1,
                                height: 1.2,
                              )),
                          Text(
                              result.cityName.toString(),
                              maxLines: 1,
                              style: const TextStyle(
                                color: kTextGreyColor,
                                fontSize: 12,
                                letterSpacing: 0.1,
                                height: 1.2,
                              )),
                          SizedBox(height: 5),

                          const Text('State:',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                letterSpacing: 0.1,
                                height: 1.2,
                              )), Text(
                              result.stateName.toString(),
                              maxLines: 1,
                              style: const TextStyle(
                                color: kTextGreyColor,
                                fontSize: 12,
                                letterSpacing: 0.1,
                                height: 1.2,
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 0),
/*
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,

                      child:Text(
                          '' + result.maritialname.toString(),
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            letterSpacing: 0.1,
                            height: 1.2,
                          )),
                    ),
                  ),
*/
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,

                      child:  Row(
                        children: [
                          Text('Id: ',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                letterSpacing: 0.1,
                                height: 1.2,
                              )), Text(
                              'AGRS' +
                                  result.id.toString(),
                              maxLines: 1,
                              style: TextStyle(
                                  color: kRedColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800
                              )) ,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return SocialMemberDetailScreen(profileID: result.id,);
                  }));
                },
                child: Container(
                  height: 30,
                  margin: EdgeInsets.only(top: 5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.orangeAccent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "View Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            letterSpacing: 1.0),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


