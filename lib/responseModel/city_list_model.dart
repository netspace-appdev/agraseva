/// status : "Success"
/// response_code : 200
/// message : "Gotralist"
/// result : [{"g_id":"1","gotra":"Airan","status":"1"},{"g_id":"2","gotra":"Bansal","status":"1"},{"g_id":"3","gotra":"Bindal","status":"1"},{"g_id":"4","gotra":"Bhandal","status":"1"},{"g_id":"5","gotra":"Dharan","status":"1"},{"g_id":"6","gotra":"Garg","status":"1"},{"g_id":"7","gotra":"Goyal","status":"1"},{"g_id":"8","gotra":"Goyan","status":"1"},{"g_id":"9","gotra":"Jindal","status":"1"},{"g_id":"10","gotra":"Mittal","status":"1"},{"g_id":"11","gotra":"Kansal","status":"1"},{"g_id":"12","gotra":"Kuchhal","status":"1"},{"g_id":"13","gotra":"Mangal","status":"1"},{"g_id":"14","gotra":"Nagal","status":"1"},{"g_id":"15","gotra":"Sinhal","status":"1"},{"g_id":"16","gotra":"Tayal","status":"1"},{"g_id":"17","gotra":"Tingal","status":"1"},{"g_id":"18","gotra":"Madhusudan","status":"1"},{"g_id":"19","gotra":"Gupta","status":"1"},{"g_id":"20","gotra":"Goyanka","status":"1"},{"g_id":"21","gotra":"Mudgal","status":"1"},{"g_id":"22","gotra":"Jain","status":"1"},{"g_id":"23","gotra":"Singhal","status":"1"},{"g_id":"26","gotra":"Harbajnka","status":"1"},{"g_id":"27","gotra":"Govil","status":"1"}]

class CityListModel {
  CityListModel({
      String? status,
      int? responseCode,
      String? message,
      List<CityResult>? result,}){
    _status = status!;
    _responseCode = responseCode!;
    _message = message!;
    _result = result;
}

  CityListModel.fromJson(dynamic json) {
    _status = json['status'];
    _responseCode = json['response_code'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(CityResult.fromJson(v));
      });
    }
  }
  String? _status;
  int? _responseCode;
  String? _message;
  List<CityResult>? _result;

  String? get status => _status;
  int? get responseCode => _responseCode;
  String? get message => _message;
  List<CityResult>? get result => _result;

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

class CityResult {
  CityResult({
      String? distId,
      String? stateId,
      String? district,
      String? status,}){
    _distId = distId!;
    _stateId = stateId!;
    _district = district!;
    _status = status!;
}

  CityResult.fromJson(dynamic json) {
    _distId = json['dist_id'];
    _stateId = json['state_id'];
    _district= json['district'];
    _status = json['status'];
  }
  String? _distId;
  String? _stateId;
  String? _district;
  String? _status;

  String? get distId => _distId;
  String? get stateId => _stateId;
  String? get district => _district;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dist_id'] = _distId;
    map['state_id'] = _stateId;
    map['district'] = _district;
    map['status'] = _status;
    return map;
  }

}