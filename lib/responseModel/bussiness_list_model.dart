/// status : "Success"
/// response_code : 200
/// message : "Gotralist"
/// result : [{"g_id":"1","gotra":"Airan","status":"1"},{"g_id":"2","gotra":"Bansal","status":"1"},{"g_id":"3","gotra":"Bindal","status":"1"},{"g_id":"4","gotra":"Bhandal","status":"1"},{"g_id":"5","gotra":"Dharan","status":"1"},{"g_id":"6","gotra":"Garg","status":"1"},{"g_id":"7","gotra":"Goyal","status":"1"},{"g_id":"8","gotra":"Goyan","status":"1"},{"g_id":"9","gotra":"Jindal","status":"1"},{"g_id":"10","gotra":"Mittal","status":"1"},{"g_id":"11","gotra":"Kansal","status":"1"},{"g_id":"12","gotra":"Kuchhal","status":"1"},{"g_id":"13","gotra":"Mangal","status":"1"},{"g_id":"14","gotra":"Nagal","status":"1"},{"g_id":"15","gotra":"Sinhal","status":"1"},{"g_id":"16","gotra":"Tayal","status":"1"},{"g_id":"17","gotra":"Tingal","status":"1"},{"g_id":"18","gotra":"Madhusudan","status":"1"},{"g_id":"19","gotra":"Gupta","status":"1"},{"g_id":"20","gotra":"Goyanka","status":"1"},{"g_id":"21","gotra":"Mudgal","status":"1"},{"g_id":"22","gotra":"Jain","status":"1"},{"g_id":"23","gotra":"Singhal","status":"1"},{"g_id":"26","gotra":"Harbajnka","status":"1"},{"g_id":"27","gotra":"Govil","status":"1"}]

class BussinessListModel {
  BussinessListModel({
      String? status,
      int? responseCode,
      String? message,
      List<BussinessResult>? result,}){
    _status = status!;
    _responseCode = responseCode!;
    _message = message!;
    _result = result;
}

  BussinessListModel.fromJson(dynamic json) {
    _status = json['status'];
    _responseCode = json['response_code'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(BussinessResult.fromJson(v));
      });
    }
  }
  String? _status;
  int? _responseCode;
  String? _message;
  List<BussinessResult>? _result;

  String? get status => _status;
  int? get responseCode => _responseCode;
  String? get message => _message;
  List<BussinessResult>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// g_id : "1"
/// gotra : "Airan"
/// status : "1"

class BussinessResult {
  BussinessResult({
      String? bId,
      String? business,
      String? status,}){
    _bId = bId!;
    _business = business!;
    _status = status!;
}

  BussinessResult.fromJson(dynamic json) {
    _bId = json['b_id'];
    _business = json['business'];
    _status = json['status'];
  }
  String? _bId;
  String? _business;
  String? _status;

  String? get bId => _bId;
  String? get business => _business;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['b_id'] = _bId;
    map['business'] = _business;
    map['status'] = _status;
    return map;
  }

}