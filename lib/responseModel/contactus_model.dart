/// status : "Success"
/// response_code : 200
/// message : "Contact Details"
/// result : [{"con_id":"14","name":"Govind Mittal","address":"C/o Arvind Devesthle \r\nM1-132 Vyas Nagar Ujjain M.P.","contact":"9755739106","alt_contact":"7987127780","email":"agraseva1@gmail.com","image":"06-03-2020-1583469396.jpg","status":"1"},{"con_id":"16","name":"Mrs Sudha Mittal","address":"131 M Vyas Nagar","contact":"7987127780","alt_contact":"9301226997","email":"agraseva1@gmail.com","image":"24-05-2020-1590288129.jpg","status":"1"}]

class ContactusModel {
  ContactusModel({
      String? status,
      int? responseCode,
      String? message,
      List<Result>? result,}){
    _status = status;
    _responseCode = responseCode!;
    _message = message;
    _result = result!;
}

  ContactusModel.fromJson(dynamic json) {
    _status = json['status'];
    _responseCode = json['response_code'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result!.add(Result.fromJson(v));
      });
    }
  }
  String? _status;
  int? _responseCode;
  String? _message;
  List<Result>? _result;

  String? get status => _status;
  int? get responseCode => _responseCode;
  String? get message => _message;
  List<Result>? get result => _result;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['status'] = _status;
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// con_id : "14"
/// name : "Govind Mittal"
/// address : "C/o Arvind Devesthle \r\nM1-132 Vyas Nagar Ujjain M.P."
/// contact : "9755739106"
/// alt_contact : "7987127780"
/// email : "agraseva1@gmail.com"
/// image : "06-03-2020-1583469396.jpg"
/// status : "1"

class Result {
  Result({
      String? conId,
      String? name,
      String? address,
      String? contact,
      String? altContact,
      String? email,
      String? image,
      String? status,}){
    _conId = conId;
    _name = name;
    _address = address;
    _contact = contact;
    _altContact = altContact;
    _email = email;
    _image = image;
    _status = status;
}

  Result.fromJson(dynamic json) {
    _conId = json['con_id'];
    _name = json['name'];
    _address = json['address'];
    _contact = json['contact'];
    _altContact = json['alt_contact'];
    _email = json['email'];
    _image = json['image'];
    _status = json['status'];
  }
  String? _conId;
  String? _name;
  String? _address;
  String? _contact;
  String? _altContact;
  String? _email;
  String? _image;
  String? _status;

  String? get conId => _conId;
  String? get name => _name;
  String? get address => _address;
  String? get contact => _contact;
  String? get altContact => _altContact;
  String? get email => _email;
  String? get image => _image;
  String? get status => _status;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['con_id'] = _conId;
    map['name'] = _name;
    map['address'] = _address;
    map['contact'] = _contact;
    map['alt_contact'] = _altContact;
    map['email'] = _email;
    map['image'] = _image;
    map['status'] = _status;
    return map;
  }

}