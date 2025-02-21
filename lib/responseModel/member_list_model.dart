/// status : "Success"
/// response_code : 200
/// message : "Member List"
/// result : [{"m_id":"4120","matri_id":"9826732050","f_name":"Himanshu ","l_name":"","gender":"Male","father_name":"Late Shri Sanjay Agrawal","gotra":"1","contact":"9826732050","alt_contact":"9425923350","email":"agrawal.hunny20@gmail.com","address":"Prahalad Das mangilalji Agrawal, Gandhi Chowk, Garoth 458880. Dist- Mandsaur\r\n","pincode":"458880","state_id":"20","dist_id":"325","tehsil_id":"","marid_status":"1","e_id":"45","b_id":"2","income":"7digits","complexion":"Fair","body_type":"Slim","blood_group":"","age":"28","height":"20","weight":"74","dob":"20-11-1993","dot":"07:15","place_birth":"Ujjain","rashi":"","nakshatra":"","manglik":"Yes","c_p_name":"Mr.Mahesh Agrawal","relation_c_p":"Bade Papa","family_status":"","time_to_call":"9AM To 9PM","mobile_c_p":"9425923350    ","email_c_p":"agrawal.hunny20@gmail.com","password":"Hunny050*","profile":"","status":"1","last_login":"13-11-2021 09:27:AM","remark":"Education : B.Com. + LLB (Hons.). Firm:- M/s. Prahlad Das Mangilalji Agrawal\r\nM/s. Sanjay Sales\r\n(Wholesale Kirana Trader)\r\nGandhi Chowk, Garoth,\r\nDistt . Mandsaur (M.P.)\r\n","date":"","aadhar_no":"","brother":"1","mbrother":"00","nmbrother":"01","tsister":"0","msister":"0","nmsister":"0","fahetr_bussiness":"no","home_type":"Own","MemberType":"Premier","VisitCount":"25","token":"","updated_at":"2021-11-13 03:57:00","createdDate":"2021-10-07 17:08:43","Gotra":"Airan","Education":"L.L.B.","Height":"5' 8\"","StateName":"Madhya Pradesh","CityName":"Mandsaur","BusinessName":"Business","ProfilePic":"61600516ea866_himanshu.jpg","maritialname":"Unmarried"},null]

class MemberListModel {
  MemberListModel({
      String? status,
      int? responseCode,
      String? message,
      List<Result>? result,}){
    _status = status!;
    _responseCode = responseCode!;
    _message = message!;
    _result = result!;
}

  MemberListModel.fromJson(dynamic json) {
    _status = json['status'];
    _responseCode = json['response_code'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }
  String? _status;
  int? _responseCode;
  String? _message;
  List<Result>? _result;

  String? get status => _status!;
  int get responseCode => _responseCode!;
  String? get message => _message!;
  List<Result>? get result => _result!;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['status'] = _status;
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// m_id : "4120"
/// matri_id : "9826732050"
/// f_name : "Himanshu "
/// l_name : ""
/// gender : "Male"
/// father_name : "Late Shri Sanjay Agrawal"
/// gotra : "1"
/// contact : "9826732050"
/// alt_contact : "9425923350"
/// email : "agrawal.hunny20@gmail.com"
/// address : "Prahalad Das mangilalji Agrawal, Gandhi Chowk, Garoth 458880. Dist- Mandsaur\r\n"
/// pincode : "458880"
/// state_id : "20"
/// dist_id : "325"
/// tehsil_id : ""
/// marid_status : "1"
/// e_id : "45"
/// b_id : "2"
/// income : "7digits"
/// complexion : "Fair"
/// body_type : "Slim"
/// blood_group : ""
/// age : "28"
/// height : "20"
/// weight : "74"
/// dob : "20-11-1993"
/// dot : "07:15"
/// place_birth : "Ujjain"
/// rashi : ""
/// nakshatra : ""
/// manglik : "Yes"
/// c_p_name : "Mr.Mahesh Agrawal"
/// relation_c_p : "Bade Papa"
/// family_status : ""
/// time_to_call : "9AM To 9PM"
/// mobile_c_p : "9425923350    "
/// email_c_p : "agrawal.hunny20@gmail.com"
/// password : "Hunny050*"
/// profile : ""
/// status : "1"
/// last_login : "13-11-2021 09:27:AM"
/// remark : "Education : B.Com. + LLB (Hons.). Firm:- M/s. Prahlad Das Mangilalji Agrawal\r\nM/s. Sanjay Sales\r\n(Wholesale Kirana Trader)\r\nGandhi Chowk, Garoth,\r\nDistt . Mandsaur (M.P.)\r\n"
/// date : ""
/// aadhar_no : ""
/// brother : "1"
/// mbrother : "00"
/// nmbrother : "01"
/// tsister : "0"
/// msister : "0"
/// nmsister : "0"
/// fahetr_bussiness : "no"
/// home_type : "Own"
/// MemberType : "Premier"
/// VisitCount : "25"
/// token : ""
/// updated_at : "2021-11-13 03:57:00"
/// createdDate : "2021-10-07 17:08:43"
/// Gotra : "Airan"
/// Education : "L.L.B."
/// Height : "5' 8\""
/// StateName : "Madhya Pradesh"
/// CityName : "Mandsaur"
/// BusinessName : "Business"
/// ProfilePic : "61600516ea866_himanshu.jpg"
/// maritialname : "Unmarried"

class Result {
  Result({
      String? mId,
      String? matriId,
      String? fName,
      String? lName,
      String? gender,
      String? fatherName,
      String? gotra,
      String? contact,
      String? altContact,
      String? email,
      String? address,
      String? pincode,
      String? stateId,
      String? distId,
      String? tehsilId,
      String? maridStatus,
      String? eId,
      String? bId,
      String? income,
      String? complexion,
      String? bodyType,
      String? bloodGroup,
      String? age,
      String? height,
      String? weight,
      String? dob,
      String? dot,
      String? placeBirth,
      String? rashi,
      String? nakshatra,
      String? manglik,
      String? cPName,
      String? relationCP,
      String? familyStatus,
      String? timeToCall,
      String? mobileCP,
      String? emailCP,
      String? password,
      String? profile,
      String? status,
      String? lastLogin,
      String? remark,
      String? date,
      String? aadharNo,
      String? brother,
      String? mbrother,
      String? nmbrother,
      String? tsister,
      String? msister,
      String? nmsister,
      String? fahetrBussiness,
      String? homeType,
      String? memberType,
      String? visitCount,
      String? token,
      String? updatedAt,
      String? createdDate,
      String? gotra2,
      String? education,
      String? height2,
      String? stateName,
      String? cityName,
      String? businessName,
      String? profilePic,
      String? maritialname,
      String? isuserShortlisted,
    List<ProfilePhotoList>? photoList,
  }){
    _mId = mId!;
    _matriId = matriId!;
    _fName = fName!;
    _lName = lName!;
    _gender = gender!;
    _fatherName = fatherName!;
    _gotra = gotra!;
    _contact = contact!;
    _altContact = altContact!;
    _email = email!;
    _address = address!;
    _pincode = pincode!;
    _stateId = stateId!;
    _distId = distId!;
    _tehsilId = tehsilId!;
    _maridStatus = maridStatus!;
    _eId = eId!;
    _bId = bId!;
    _income = income!;
    _complexion = complexion!;
    _bodyType = bodyType!;
    _bloodGroup = bloodGroup!;
    _age = age!;
    _height = height!;
    _weight = weight!;
    _dob = dob!;
    _dot = dot!;
    _placeBirth = placeBirth!;
    _rashi = rashi!;
    _nakshatra = nakshatra!;
    _manglik = manglik!;
    _cPName = cPName!;
    _relationCP = relationCP!;
    _familyStatus = familyStatus!;
    _timeToCall = timeToCall!;
    _mobileCP = mobileCP!;
    _emailCP = emailCP!;
    _password = password!;
    _profile = profile!;
    _status = status!;
    _lastLogin = lastLogin!;
    _remark = remark!;
    _date = date!;
    _aadharNo = aadharNo!;
    _brother = brother!;
    _mbrother = mbrother!;
    _nmbrother = nmbrother!;
    _tsister = tsister!;
    _msister = msister!;
    _nmsister = nmsister!;
    _fahetrBussiness = fahetrBussiness!;
    _homeType = homeType!;
    _memberType = memberType!;
    _visitCount = visitCount!;
    _token = token!;
    _updatedAt = updatedAt!;
    _createdDate = createdDate!;
    _gotra2 = gotra2!;
    _education = education!;
    _height2 = height2!;
    _stateName = stateName!;
    _cityName = cityName!;
    _businessName = businessName!;
    _profilePic = profilePic!;
    _coverPic = coverPic!;
    _maritialname = maritialname!;
    _isuserShortlisted = isuserShortlisted!;
    _photoList = photoList!;
}

  Result.fromJson(dynamic json) {
    _mId = json['m_id'];
    _matriId = json['matri_id'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _gender = json['gender'];
    _fatherName = json['father_name'];
    _gotra = json['gotra'];
    _contact = json['contact'];
    _altContact = json['alt_contact'];
    _email = json['email'];
    _address = json['address'];
    _pincode = json['pincode'];
    _stateId = json['state_id'];
    _distId = json['dist_id'];
    _tehsilId = json['tehsil_id'];
    _maridStatus = json['marid_status'];
    _eId = json['e_id'];
    _bId = json['b_id'];
    _income = json['income'];
    _complexion = json['complexion'];
    _bodyType = json['body_type'];
    _bloodGroup = json['blood_group'];
    _age = json['age'];
    _height = json['height'];
    _weight = json['weight'];
    _dob = json['dob'];
    _dot = json['dot'];
    _placeBirth = json['place_birth'];
    _rashi = json['rashi'];
    _nakshatra = json['nakshatra'];
    _manglik = json['manglik'];
    _cPName = json['c_p_name'];
    _relationCP = json['relation_c_p'];
    _familyStatus = json['family_status'];
    _timeToCall = json['time_to_call'];
    _mobileCP = json['mobile_c_p'];
    _emailCP = json['email_c_p'];
    _password = json['password'];
    _profile = json['profile'];
    _status = json['status'];
    _lastLogin = json['last_login'];
    _remark = json['remark'];
    _date = json['date'];
    _aadharNo = json['aadhar_no'];
    _brother = json['brother'];
    _mbrother = json['mbrother'];
    _nmbrother = json['nmbrother'];
    _tsister = json['tsister'];
    _msister = json['msister'];
    _nmsister = json['nmsister'];
    _fahetrBussiness = json['fahetr_bussiness'];
    _homeType = json['home_type'];
    _memberType = json['MemberType'];
    _visitCount = json['VisitCount'];
    _token = json['token'];
    _updatedAt = json['updated_at'];
    _createdDate = json['createdDate'];
    _gotra2 = json['Gotra'];
    _education = json['Education'];
    _height2 = json['Height'];
    _stateName = json['StateName'];
    _cityName = json['CityName'];
    _businessName = json['BusinessName'];
    _profilePic = json['ProfilePhoto'];
    _coverPic = json['Coverphoto'];
    _maritialname = json['maritialname'];
    _isuserShortlisted = json['IsuserShortlisted'];
    if (json['ProfilePhotoList'] != null) {
      _photoList = [];
      json['ProfilePhotoList'].forEach((v) {
        _photoList?.add(ProfilePhotoList.fromJson(v));
      });
    }

  }
  String? _mId;
  String? _matriId;
  String? _fName;
  String? _lName;
  String? _gender;
  String? _fatherName;
  String? _gotra;
  String? _contact;
  String? _altContact;
  String? _email;
  String? _address;
  String? _pincode;
  String? _stateId;
  String? _distId;
  String? _tehsilId;
  String? _maridStatus;
  String? _eId;
  String? _bId;
  String? _income;
  String? _complexion;
  String? _bodyType;
  String? _bloodGroup;
  String? _age;
  String? _height;
  String? _weight;
  String? _dob;
  String? _dot;
  String? _placeBirth;
  String? _rashi;
  String? _nakshatra;
  String? _manglik;
  String? _cPName;
  String? _relationCP;
  String? _familyStatus;
  String? _timeToCall;
  String? _mobileCP;
  String? _emailCP;
  String? _password;
  String? _profile;
  String? _status;
  String? _lastLogin;
  String? _remark;
  String? _date;
  String? _aadharNo;
  String? _brother;
  String? _mbrother;
  String? _nmbrother;
  String? _tsister;
  String? _msister;
  String? _nmsister;
  String? _fahetrBussiness;
  String? _homeType;
  String? _memberType;
  String? _visitCount;
  String? _token;
  String? _updatedAt;
  String? _createdDate;
  String? _gotra2;
  String? _education;
  String? _height2;
  String? _stateName;
  String? _cityName;
  String? _businessName;
  String? _profilePic;
  String? _coverPic;
  String? _maritialname;
  String? _isuserShortlisted;
  List<ProfilePhotoList>? _photoList;

  String? get mId => _mId;
  String? get matriId => _matriId;
  String? get fName => _fName;
  String? get lName => _lName;
  String? get gender => _gender;
  String? get fatherName => _fatherName;
  String? get gotra => _gotra;
  String? get contact => _contact;
  String? get altContact => _altContact;
  String? get email => _email;
  String? get address => _address;
  String? get pincode => _pincode;
  String? get stateId => _stateId;
  String? get distId => _distId;
  String? get tehsilId => _tehsilId;
  String? get maridStatus => _maridStatus;
  String? get eId => _eId;
  String? get bId => _bId;
  String? get income => _income;
  String? get complexion => _complexion;
  String? get bodyType => _bodyType;
  String? get bloodGroup => _bloodGroup;
  String? get age => _age;
  String? get height => _height;
  String? get weight => _weight;
  String? get dob => _dob;
  String? get dot => _dot;
  String? get placeBirth => _placeBirth;
  String? get rashi => _rashi;
  String? get nakshatra => _nakshatra;
  String? get manglik => _manglik;
  String? get cPName => _cPName;
  String? get relationCP => _relationCP;
  String? get familyStatus => _familyStatus;
  String? get timeToCall => _timeToCall;
  String? get mobileCP => _mobileCP;
  String? get emailCP => _emailCP;
  String? get password => _password;
  String? get profile => _profile;
  String? get status => _status;
  String? get lastLogin => _lastLogin;
  String? get remark => _remark;
  String? get date => _date;
  String? get aadharNo => _aadharNo;
  String? get brother => _brother;
  String? get mbrother => _mbrother;
  String? get nmbrother => _nmbrother;
  String? get tsister => _tsister;
  String? get msister => _msister;
  String? get nmsister => _nmsister;
  String? get fahetrBussiness => _fahetrBussiness;
  String? get homeType => _homeType;
  String? get memberType => _memberType;
  String? get visitCount => _visitCount;
  String? get token => _token;
  String? get updatedAt => _updatedAt;
  String? get createdDate => _createdDate;
  String? get gotra2 => _gotra2;
  String? get education => _education;
  String? get height2 => _height2;
  String? get stateName => _stateName;
  String? get cityName => _cityName;
  String? get businessName => _businessName;
  String? get profilePic => _profilePic;
  String? get coverPic => _coverPic;
  String? get maritialname => _maritialname;
  String? get isuserShortlisted => _isuserShortlisted;
  List<ProfilePhotoList>? get photoList => _photoList;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['m_id'] = _mId;
    map['matri_id'] = _matriId;
    map['f_name'] = _fName;
    map['l_name'] = _lName;
    map['gender'] = _gender;
    map['father_name'] = _fatherName;
    map['gotra'] = _gotra;
    map['contact'] = _contact;
    map['alt_contact'] = _altContact;
    map['email'] = _email;
    map['address'] = _address;
    map['pincode'] = _pincode;
    map['state_id'] = _stateId;
    map['dist_id'] = _distId;
    map['tehsil_id'] = _tehsilId;
    map['marid_status'] = _maridStatus;
    map['e_id'] = _eId;
    map['b_id'] = _bId;
    map['income'] = _income;
    map['complexion'] = _complexion;
    map['body_type'] = _bodyType;
    map['blood_group'] = _bloodGroup;
    map['age'] = _age;
    map['height'] = _height;
    map['weight'] = _weight;
    map['dob'] = _dob;
    map['dot'] = _dot;
    map['place_birth'] = _placeBirth;
    map['rashi'] = _rashi;
    map['nakshatra'] = _nakshatra;
    map['manglik'] = _manglik;
    map['c_p_name'] = _cPName;
    map['relation_c_p'] = _relationCP;
    map['family_status'] = _familyStatus;
    map['time_to_call'] = _timeToCall;
    map['mobile_c_p'] = _mobileCP;
    map['email_c_p'] = _emailCP;
    map['password'] = _password;
    map['profile'] = _profile;
    map['status'] = _status;
    map['last_login'] = _lastLogin;
    map['remark'] = _remark;
    map['date'] = _date;
    map['aadhar_no'] = _aadharNo;
    map['brother'] = _brother;
    map['mbrother'] = _mbrother;
    map['nmbrother'] = _nmbrother;
    map['tsister'] = _tsister;
    map['msister'] = _msister;
    map['nmsister'] = _nmsister;
    map['fahetr_bussiness'] = _fahetrBussiness;
    map['home_type'] = _homeType;
    map['MemberType'] = _memberType;
    map['VisitCount'] = _visitCount;
    map['token'] = _token;
    map['updated_at'] = _updatedAt;
    map['createdDate'] = _createdDate;
    map['Gotra'] = _gotra2;
    map['Education'] = _education;
    map['Height'] = _height2;
    map['StateName'] = _stateName;
    map['CityName'] = _cityName;
    map['BusinessName'] = _businessName;
    map['ProfilePhoto'] = _profilePic;
    map['Coverphoto'] = _coverPic;
    map['maritialname'] = _maritialname;
    map['IsuserShortlisted'] = _isuserShortlisted;
    if (_photoList != null) {
      map['ProfilePhotoList'] = _photoList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ProfilePhotoList {
  ProfilePhotoList({
    String? img_id,
    String? profile,
    String? matri_id,
    String? m_id,
    String? status,
  }){
    _img_id = img_id!;
    _profile = profile!;
    _matri_id= matri_id!;
    _m_id = m_id!;
    _status = status!;
  }

  ProfilePhotoList.fromJson(dynamic json) {
    _img_id = json['img_id'];
    _profile = json['profile'];
    _matri_id = json['matri_id'];
    _m_id= json['m_id'];
    _status = json['status'];
  }
  String? _img_id;
  String? _profile;
  String? _matri_id;
  String? _m_id;
  String? _status;

  String? get img_id => _img_id;
  String? get profile => _profile;
  String? get matri_id => _matri_id;
  String? get m_id => _m_id;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['img_id'] = _img_id;
    map['profile'] = _profile;
    map['matri_id'] = _matri_id;
    map['m_id'] = _m_id;
    map['status'] = _status;
    return map;
  }

}