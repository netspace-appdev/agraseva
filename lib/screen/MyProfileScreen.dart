// ignore: file_names

import 'dart:convert';
import 'dart:io';

import 'package:agraseva/responseModel/city_list_model.dart';
import 'package:agraseva/responseModel/gotra_list_model.dart';
import 'package:agraseva/responseModel/member_list_model.dart';
import 'package:agraseva/responseModel/state_list_model.dart';
import 'package:agraseva/screen/EditAstroDetailScreen.dart';
import 'package:agraseva/screen/EditBasicDetailScreen.dart';
import 'package:agraseva/screen/EditProfileDetailScreen.dart';
import 'package:agraseva/screen/deleteMyAccountScreen.dart';
import 'package:agraseva/utils/common_functions.dart';
import 'package:agraseva/utils/constant.dart';
import 'package:agraseva/widgets/MySeparator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/CustomCachedImage.dart';
import 'EditFamilyDetailScreen.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  List<Result>? memberList = <Result>[];
  late Result userModel;
  bool isLoading = false;
  String gotradropdownValue = "Select Gotra";
  String statedropdownValue = "Select State";
  String citydropdownValue = "Select City";

  String gotraId ="";
  String stateId ="";
  String cityId ="";
  List<String> gotraList = <String>[];
  List<String> stateList = <String>[];
  List<String> cityList = <String>[];
  List<GotraResult> gotraListModel = <GotraResult>[];
  List<StateResult> stateListModel = <StateResult>[];
  List<CityResult> cityListModel = <CityResult>[];
  XFile? _image;
  File? imageFile;
  int imagesize = 0;
  String imageProfile ="";
  String imageCover ="";

  _imgFromCamera(String? from) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.camera,imageQuality: 30);
    setState(() {

      _image = image;
      if(from=='profile'){
        _cropProfileImage(_image!.path);

      }else
      if(from=='cover'){
        _cropCoverImage(_image!.path);
      }else{
        updateImageRequest();
      }

    });
  }

  _imgFromGallery(String? from) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an gallery
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 30);
    setState(() {
      _image = image;
      if(from=='profile'){
        _cropProfileImage(_image!.path);
      }else
      if(from=='cover'){
        _cropCoverImage(_image!.path);
      }else{
        updateImageRequest();
      }
    });
  }

  void _showPicker(context,String? from) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(from);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(from);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void _deleteViewPhoto(context,String? imgId,String? imgUrl) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.delete_forever),
                      title: new Text('Delete Photo'),
                      onTap: () {
                        Navigator.of(context).pop();
                        deleteImageRequest(imgId);

                      }),
                  new ListTile(
                    leading: new Icon(Icons.preview),
                    title: new Text('View Photo'),
                    onTap: () {
                      CommonFunctions.showImage(imgUrl!, context);

                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.cancel_outlined),
                    title: new Text('Cancel'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

/*  Future<Null> _cropCoverImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
        aspectRatio: CropAspectRatio(ratioX: 2.0, ratioY: 1.0)
    );
    if (croppedImage  != null) {
      imageFile = croppedImage ;
      setState(() {
       updateCoverImageRequest(imageFile);
      });
    }
  }*/
  Future<void> _cropCoverImage(String filePath) async {  // Use void instead of Null
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 2.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.red,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );

    if (croppedImage != null) {
      File imageFile = File(croppedImage.path); // Convert CroppedFile to File
      setState(() {
        updateCoverImageRequest(imageFile);
      });
    }
  }

/*  Future<Null> _cropProfileImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    );
    if (croppedImage  != null) {
      imageFile = croppedImage ;
      setState(() {
        updateProfileImageRequest(imageFile);
      });
    }
  }*/
  Future<void> _cropProfileImage(String filePath) async {  // Use void instead of Null
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 2.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.red,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );

    if (croppedImage != null) {
      File imageFile = File(croppedImage.path); // Convert CroppedFile to File
      setState(() {
        updateCoverImageRequest(imageFile);
      });
    }
  }

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

  Future<http.Response?> updateProfileImageRequest(File? image) async {
    CommonFunctions.showLoader(true, context);
    final bytes = image!.readAsBytesSync();

    String img64 = base64Encode(bytes);
    final uri = Uri.parse(Constant.base_url + '/agraapi/UploadProfilePic');
    Map<String, String> body = {
      'ProfileID': Constant.prefs!.getString("ProfileID").toString(),
      'ProfilePhoto': img64,
    };
    print(body);
    await http.post(uri, body: body).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print('ProfilePhoto');
      print(jsonData);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
        getMemberList();

      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }
  Future<http.Response?> deleteImageRequest(String? imgId) async {
    CommonFunctions.showLoader(true, context);
    final uri = Uri.parse(Constant.base_url + '/agraapi/DeletePhoto');
    Map<String, String> body = {
      'ImgID': imgId.toString(),
    };
    print(body);
    await http.post(uri, body: body).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print('deletePhoto');
      print(jsonData);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
        getMemberList();

      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }
  Future<http.Response?> updateCoverImageRequest(File? image) async {
    CommonFunctions.showLoader(true, context);
    final bytes = image!.readAsBytesSync();
    String img64 = base64Encode(bytes);
    final uri = Uri.parse(Constant.base_url + '/agraapi/UploadCoverPic');
    Map<String, String> body = {
      'ProfileID': Constant.prefs!.getString("ProfileID").toString(),
      'ProfilePhoto': img64,
    };
    print('CoverPhoto');
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
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
        getMemberList();

      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
    });
  }
  Future<http.Response?> updateImageRequest() async {
    CommonFunctions.showLoader(true, context);
    final bytes = File(_image!.path).readAsBytesSync();

    String img64 = base64Encode(bytes);
    final uri = Uri.parse(Constant.base_url + '/agraapi/AddProfilePhotos');
    Map<String, String> body = {
      'ProfileID': Constant.prefs!.getString("ProfileID").toString(),
      'ProfilePhoto': img64,
    };
    print(body);
    await http.post(uri, body: body).then((http.Response response) {
      final jsonData = json.decode(response.body);
      print('OtherPhoto');
      print(jsonData);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
        getMemberList();

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

      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        var map = Map<String, dynamic>.from(jsonData);
        var modelData = MemberListModel.fromJson(map);

        memberList = modelData.result;
        userModel = memberList![0];
        print("memberListsize:  " + memberList!.length.toString());
        imageProfile =  Constant.base_url+'/uploaded/matri/profilepic/'+userModel.profilePic.toString();
        imageCover =  Constant.base_url+'/uploaded/matri/coverpic/'+userModel.coverPic.toString();
        print(imageProfile);
        if(userModel.photoList!.length>2){
          imagesize =userModel.photoList!.length;
        }else{
          imagesize =userModel.photoList!.length+1;
        }
      } else {
        print(jsonData['message'] as String);
        CommonFunctions.showSuccessToast(jsonData['message'] as String);
      }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Container()
          : Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(bottom: 0.0, top: 0.0),
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2.0,
                                spreadRadius: 3.0,
                                offset: Offset(
                                    1.0, 1.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(15.0),
                          alignment: AlignmentDirectional.centerStart,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Update profile pictures",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              MySeparator(color: kRedColor),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child:   GestureDetector(
                                      onTap: () {
                                        CommonFunctions.showImage(imageCover, context);
                                      },
                                      child: Container(
                                      height: 120,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                     /*   child: Image.network(imageCover,
                                            key: ValueKey(imageCover),
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width),*/
                                        child: CustomCachedImage(
                                          imageUrl: imageCover,
                                          width: MediaQuery.of(context).size.width,
                                          height: 120,
                                          borderRadius: BorderRadius.circular(12),
                                          errorIcon:  Icons.image,
                                        ),
                                      ),
                                    ),
                                  )),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 120,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: GestureDetector(
                                              onTap: () {
                                                CommonFunctions.showImage(imageProfile, context);
                                              },
                                              child:  CircleAvatar(
                                              radius: 40.0,
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(imageProfile),
                                               /* child: ClipOval(
                                                  child: CustomCachedImage(
                                                    imageUrl: imageCover,
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 60,
                                                    borderRadius: BorderRadius.circular(12),


                                                  ),
                                                ),*/
                                            ),)
                                          ),
                                      GestureDetector(
                                        onTap: () {
                                          _showPicker(context,'profile');
                                        },
                                        child:  Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.edit_outlined,
                                                color: kRedColor,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                "Profile",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ],
                                          ),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                          GestureDetector(
                            onTap: () {
                              print('onclickimage');
                              _showPicker(context,'cover');
                            },
                            child:  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(1.0,
                                          1.0), // shadow direction: bottom right
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      color: kRedColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      "Change cover picture",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 100.0,
                                width: 300,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: imagesize,
                                      itemBuilder: (context, index) {
                                        Container contianer;

                                        if(index<userModel.photoList!.length) {
                                          contianer = Container(
                                            height: 100,
                                            width: 100,
                                            margin: EdgeInsets.all(5.0),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              child: Image.network(
                                                  Constant.base_url +
                                                      '/uploaded/matri/' +
                                                      userModel
                                                          .photoList![index]
                                                          .profile.toString(),
                                                  /*color: Colors.black.withOpacity(0.1),
                                          colorBlendMode: BlendMode.darken,*/
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: 100),
                                            ),
                                          );
                                        }else{
                                          contianer =  Container(
                                            height: 100,
                                            width: 100,
                                            margin: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                              color: kGreyLightColor,
                                            ),
                                            child: Icon(
                                              Icons.add_circle,
                                              color: Colors.white,
                                              size: 60,
                                            ),
                                          );
                                        }
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if(index<userModel.photoList!.length) {
                                                _deleteViewPhoto(context, userModel
                                                    .photoList![index].img_id.toString(),
                                                    Constant.base_url +
                                                    '/uploaded/matri/' +
                                                    userModel
                                                        .photoList![index]
                                                        .profile.toString());
                                              }else{
                                                _showPicker(context,'otherImage');
                                              }

                                            });
                                          },
                                          child: contianer,
                                        );
                                      },
                                    ),
                                  ),

                                ],
                              )
                            ],
                          )),
                      profileDetailContainer(),
                      basicDetailContainer(),
                      astroDetailContainer(),
                      familyDetailContainer(),
                      SizedBox(height: 10,),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DeleteMyAccountScreen()));
                          },
                          child: Text(
                            "Delete my account",
                            style: TextStyle(
                              color: kRedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          )
                      ),
                      SizedBox(height: 30,)

                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Container profileDetailContainer() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
              spreadRadius: 3.0,
              offset: Offset(1.0, 1.0), // shadow direction: bottom right
            )
          ],
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(
          bottom: 15.0,
          left: 15.0,
          right: 15.0,
        ),
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          children: [
            GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Profile Details",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                            onTap: () {

                              navigateToProfileDetail(context);
                            },
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: kRedColor,
                                  size: 20,
                                )))),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            MySeparator(color: kRedColor),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel != null
                            ? userModel.fName.toString() +
                                ' ' +
                                userModel.lName.toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Father's Name:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel != null
                            ? userModel.fatherName.toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Gotra:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel != null ? userModel.gotra2.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Gender:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel != null ? userModel.gender.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Contact No.:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel != null ? userModel.contact.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Alternate Contact No.:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel != null ? userModel.altContact.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Aadhar No.:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.aadharNo.toString() != "null" ? userModel.aadharNo.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.email.toString() != "null" ? userModel.email.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Address:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.address.toString() != "null" ? userModel.address.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Pincode No.:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.pincode.toString() != "null" ? userModel.pincode.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "State:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.stateName.toString() != "null" ? userModel.stateName.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "City:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.cityName.toString() != "null" ? userModel.cityName.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Marital Status:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.maritialname.toString() != "null"
                            ? userModel.maritialname.toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Education:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.education.toString() != "null"? userModel.education.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Occupation:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.businessName.toString() != "null"
                            ? userModel.businessName.toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Income:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.income.toString() != "null" ? userModel.income.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ));
  }

  Container basicDetailContainer() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
              spreadRadius: 3.0,
              offset: Offset(1.0, 1.0), // shadow direction: bottom right
            )
          ],
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(
          bottom: 15.0,
          left: 15.0,
          right: 15.0,
        ),
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Basic Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                          navigateToBasicDetail(context);
                        },
                        child:Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.edit_outlined,
                          color: kRedColor,
                          size: 20,
                        )))),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            MySeparator(color: kRedColor),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Complexion:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.complexion.toString() != "null"
                            ? userModel.complexion.toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Body Type:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.bodyType.toString() != "null" ? userModel.bodyType.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Blood Group:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.bloodGroup.toString() != "null"
                            ? userModel.bloodGroup.toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Age:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.age.toString() != "null" ? userModel.age.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Height:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.height2.toString() != "null" ? userModel.height2.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Weight:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.weight.toString() != "null" ? userModel.weight.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ));
  }

  Container astroDetailContainer() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
              spreadRadius: 3.0,
              offset: Offset(1.0, 1.0), // shadow direction: bottom right
            )
          ],
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(
          bottom: 15.0,
          left: 15.0,
          right: 15.0,
        ),
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Astro Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child:GestureDetector(
                            onTap: () {
                              navigateToAstroDetail(context);
                            },
                            child: Icon(
                          Icons.edit_outlined,
                          color: kRedColor,
                          size: 20,
                        )))),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            MySeparator(color: kRedColor),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "DOB:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.dob.toString() != "null" ? userModel.dob.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Birth Time:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.dot.toString() != "null" ? userModel.dot.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Birth Place:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.placeBirth.toString() != "null"
                            ? userModel.placeBirth.toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sem Singh/Rashi",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.rashi.toString() != "null" ? userModel.rashi.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nakshatra:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.nakshatra.toString() != "null" ? userModel.nakshatra.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Manglik:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.manglik.toString() != "null" ? userModel.manglik.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ));
  }

  Container familyDetailContainer() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
              spreadRadius: 3.0,
              offset: Offset(1.0, 1.0), // shadow direction: bottom right
            )
          ],
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(
          bottom: 15.0,
          left: 15.0,
          right: 15.0,
        ),
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Family Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                          navigateToFamilyDetail(context);
                        },
                        child:Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.edit_outlined,
                          color: kRedColor,
                          size: 20,
                        )))),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            MySeparator(color: kRedColor),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Contact Person Name:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.cPName.toString() != "null" ? userModel.cPName.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Relationship With Contact Person:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.relationCP.toString() != "null"
                            ? userModel.relationCP.toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Best Time To Call:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.timeToCall.toString() != "null"
                            ? userModel.timeToCall.toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mobile Contact Person:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.mobileCP.toString() != "null" ? userModel.mobileCP.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.emailCP.toString() != "null" ? userModel.emailCP.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Total Brother:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.brother.toString() != "null" ? userModel.brother.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Married Brother:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.mbrother.toString() != "null" ? userModel.mbrother.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Unmarried Brother:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.nmbrother.toString() != "null" ? userModel.nmbrother.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Total Sister:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.tsister.toString() != "null" ? userModel.tsister.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Father Occupation:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.fahetrBussiness.toString() != "null"
                            ? userModel.fahetrBussiness.toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Home Type:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.homeType.toString() != "null" ? userModel.homeType.toString() : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Family & Candidate Job/Business Details:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userModel.remark.toString() != "null"
                            ? userModel.remark.toString()
                            : '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ));
  }


  navigateToProfileDetail(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileDetailScreen()),
    );
    if(result!=null) {
      isLoading = true;
      Future.delayed(Duration.zero, () {
        this.getMemberList();
      });
    }
  }
  navigateToBasicDetail(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditBasicDetailScreen()),
    );
    if(result!=null) {
      isLoading = true;
      Future.delayed(Duration.zero, () {
        this.getMemberList();
      });
    }
  }
  navigateToAstroDetail(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditAstroDetailScreen()),
    );
    if(result!=null) {
      isLoading = true;
      Future.delayed(Duration.zero, () {
        this.getMemberList();
      });
    }
  }
  navigateToFamilyDetail(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditFamilyDetailScreen()),
    );
    if(result!=null) {
      isLoading = true;
      Future.delayed(Duration.zero, () {
        this.getMemberList();
      });
    }
  }
}
