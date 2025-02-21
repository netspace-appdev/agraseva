/// status : "Success"
/// response_code : 200
/// message : "Gallery Details"
/// result : [{"img_id":"11","image":"19-07-2017-1500433392.jpg","title":"Award  agraseva.com","date":"19-07-17","status":"1","alias":""}]

class GalleryListModel {
  String? _status;
  int? _responseCode;
  String? _message;
  List<Result>? _result;

  String? get status => _status;
  int? get responseCode => _responseCode;
  String? get message => _message;
  List<Result>? get result => _result;

  GalleryListModel({
      String? status, 
      int? responseCode, 
      String? message, 
      List<Result>? result}){
    _status = status;
    _responseCode = responseCode;
    _message = message;
    _result = result;
}

  GalleryListModel.fromJson(dynamic json) {
    _status = json["status"];
    _responseCode = json["response_code"];
    _message = json["message"];
    if (json["result"] != null) {
      _result = [];
      json["result"].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["response_code"] = _responseCode;
    map["message"] = _message;
    if (_result != null) {
      map["result"] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// img_id : "11"
/// image : "19-07-2017-1500433392.jpg"
/// title : "Award  agraseva.com"
/// date : "19-07-17"
/// status : "1"
/// alias : ""

class Result {
  String? _imgId;
  String? _image;
  String? _title;
  String? _date;
  String? _status;
  String? _alias;

  String? get imgId => _imgId;
  String? get image => _image;
  String? get title => _title;
  String? get date => _date;
  String? get status => _status;
  String? get alias => _alias;

  Result({
      String? imgId, 
      String? image, 
      String? title, 
      String? date, 
      String? status, 
      String? alias}){
    _imgId = imgId;
    _image = image;
    _title = title;
    _date = date;
    _status = status;
    _alias = alias;
}

  Result.fromJson(dynamic json) {
    _imgId = json["img_id"];
    _image = json["image"];
    _title = json["title"];
    _date = json["date"];
    _status = json["status"];
    _alias = json["alias"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["img_id"] = _imgId;
    map["image"] = _image;
    map["title"] = _title;
    map["date"] = _date;
    map["status"] = _status;
    map["alias"] = _alias;
    return map;
  }

}