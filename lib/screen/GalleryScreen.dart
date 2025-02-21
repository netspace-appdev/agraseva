// ignore: file_names

import 'dart:convert';

import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import '../responseModel/gallery_list_model.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<Result>? galleryList = <Result>[];

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

  Future<http.Response?> getMemberList() async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi_dev/getGallery');

    await http.post(uri).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print("getSuccessStory");
      print(jsonData);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = GalleryListModel.fromJson(map);

        galleryList = modelData.result;
        print("galleryListsize:  " + galleryList!.length.toString());
      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }

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
          "Gallery",
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
      body: Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(bottom: 0.0, top: 0, right: 0),
          child: Container(
            child: GridView.builder(
              itemCount: galleryList!.length,
              itemBuilder: (context, index) {
                return FeaturedItem(
                    result: galleryList![index], list: galleryList, i: index);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.92,
              ),
              shrinkWrap: false,
              /*physics: NeverScrollableScrollPhysics(),*/
            ),
          )),
    );
  }
}

class FeaturedItem extends StatelessWidget {
  const FeaturedItem(
      {Key? key, required this.result, required this.list, required this.i})
      : super(key: key);

  final Result result;
  final List<Result>? list;
  final int i;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showImage(
            Constant.base_url + '/admin/images/' + result.image.toString(),
            list,
            i,
            context);
      },
      child: Container(
        /*height: 280.0,*/
        decoration: BoxDecoration(
          /*  borderRadius: BorderRadius.all(Radius.circular(15)),*/
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
        margin: EdgeInsets.only(left: 3.0, right: 3.0, bottom: 8.0),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 140,
                    child: ClipRRect(
                      /*   borderRadius: BorderRadius.circular(15.0),*/
                      child: Image.network(
                          Constant.base_url +
                              '/admin/images/' +
                              result.image.toString(),
                          /*color: Colors.black.withOpacity(0.1),
                                  colorBlendMode: BlendMode.darken,*/
                          fit: BoxFit.cover,
                          height: 120,
                          width: MediaQuery.of(context).size.width),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      result.title.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void showImage(
      String imageString, List<Result>? list, int ind, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Container(
        child: ListView.builder(
          itemCount: list!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Container contianer;
          /*  if (index == 0) {
              index = ind;
            }*/

            contianer = Container(
              margin: EdgeInsets.only(left: 3.0, right: 3.0, bottom: 8.0),
              child: Image.network(
                Constant.base_url +
                    '/admin/images/' +
                    list[index].image.toString(),
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
              ),
            );
            return GestureDetector(
              onTap: () {
                print("OnClick : ");
              },
              child: contianer,
            );
          },
          shrinkWrap: false,
          /*physics: NeverScrollableScrollPhysics(),*/
        ),
      ),
    );
  }
}
