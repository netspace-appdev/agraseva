import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:agraseva/responseModel/SocialLoginResponse.dart';
import 'package:agraseva/service/socialRegister.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helper.dart';
import '../responseModel/city_list_model.dart';
import '../responseModel/gotra_list_model.dart';
import '../responseModel/state_list_model.dart';

class SocialMemberSignupController extends GetxController{
  var socialLoginResponse = Rxn<SocialLoginResponse>(); //

  String base64Image = '';

  // ================= LOADING =================
  RxBool isLoading = false.obs;

  // ================= GENDER =================
  RxInt isGender = 1.obs;
  RxString genderDropdownValue = 'Select Gender'.obs;
  final List<String> genderList = ['Select Gender', 'Male', 'Female', 'Other'];

  // ================= TERMS =================
  RxBool isTermCheck = false.obs;

  // ================= DOB =================
  RxString dob = ''.obs;

  // ================= DROPDOWN VALUES =================
  RxString stateDropdownValue = 'Select State'.obs;
  RxString cityDropdownValue = 'Select City'.obs;
  RxnString occupationDropdownValue = RxnString();

  // ================= IDS =================
  RxString gotraId = ''.obs;
  RxString stateId = ''.obs;
  RxString cityId = ''.obs;

  // ================= LISTS =================
  RxList<String> stateList = <String>[].obs;
  RxList<String> cityList = <String>[].obs;

  final List<String> occupationList = [
  "Business",
  "Private Job",
  "Government Job",
  ];

  // ================= IMAGE =================
  Rx<File?> profileImage = Rx<File?>(null);

  // ================= API MODELS =================
  RxList<GotraResult> gotraListModel = <GotraResult>[].obs;
  RxList<StateResult> stateListModel = <StateResult>[].obs;
  RxList<CityResult> cityListModel = <CityResult>[].obs;

  // ================= TEXT CONTROLLERS =================
  // These stay in controller ONLY if reused across screens
  final userName = TextEditingController();
  final userMobile = TextEditingController();
  final userOccupation = TextEditingController();
  final userFather = TextEditingController();
  final userAddress = TextEditingController();

  // ================= CLEAR FORM =================
  void clearForm() {
  userName.clear();
  userMobile.clear();
  userOccupation.clear();
  userFather.clear();
  userAddress.clear();

  dob.value = '';
  isGender.value = 1;
  isTermCheck.value = false;

  stateDropdownValue.value = 'Select State';
  cityDropdownValue.value = 'Select City';
  occupationDropdownValue.value = null;

  stateId.value = '';
  cityId.value = '';
  gotraId.value = '';

  profileImage.value = null;
  }

  @override
  void onClose() {
  userName.dispose();
  userMobile.dispose();
  userOccupation.dispose();
  userFather.dispose();
  userAddress.dispose();
  super.onClose();

  }





  Future <void> registerRequest(
/*  {required String name,
   required String mobile,
   required String dob,
   required String stateId,
   required String cityId,
   required String Address,
   required String JobType,
   required String JobDetails,
   File? profilePhoto,
 }*/
 ) async {
   try {
     isLoading(true);


     String base64Image = '';

    // final imgBase64 = await fileToBase64(profilePhoto);
    // base64Image = 'data:image/jpeg;base64,$imgBase64';



     if (profileImage.value != null) {
       final Uint8List bytes = profileImage.value!.readAsBytesSync();
       base64Image = base64Encode(bytes);
     }
     var data = await SocialRegister.addSocialDetailApi(name: userName.text.trim(), mobileNumber: userMobile.text.trim(),
         state: stateId.value, city: cityId.value, dob: dob.value, address: userAddress.text, jobType: occupationDropdownValue.value.toString(),
         jobDetails: userOccupation.text, profilePhoto: base64Image,

     );
     socialLoginResponse.value = SocialLoginResponse.fromJson(data);
     print('SocialLoginResponse${data}');
     if (socialLoginResponse.value?.responseCode== 200) {
       isLoading(false);
       clearForm();

     } else {
       ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
     }
   } catch (e) {
     print("Error in updateBankerDetailApi: $e");
     ToastMessage.msg(AppText.somethingWentWrong);
   } finally {
     isLoading(false);
   }

 }

  Future<String> fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }



}