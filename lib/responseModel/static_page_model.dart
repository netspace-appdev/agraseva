/// status : "Success"
/// response_code : 200
/// message : "Page Details"
/// result : [{"id":"2","content":"</div>","content_type":"terms","status":"1","created_date":"2022-04-23 11:02:15","updated_date":"2022-04-23 11:02:15"}]

class StaticPageModel {
  StaticPageModel({
      String? status,
      int? responseCode,
      String? message,
      List<Result>? result,}){
    _status = status;
    _responseCode = responseCode!;
    _message = message;
    _result = result;
}

  StaticPageModel.fromJson(dynamic json) {
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

  String? get status => _status!;
  int? get responseCode => _responseCode!;
  String? get message => _message!;
  List<Result>? get result => _result!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// content : "</div>"
/// content_type : "terms"
/// status : "1"
/// created_date : "2022-04-23 11:02:15"
/// updated_date : "2022-04-23 11:02:15"

class Result {
  Result({
    String? id,
    String? content,
    String? contentType,
    String? status,
    String? createdDate,
    String? updatedDate,}){
    _id = id!;
    _content = content!;
    _contentType = contentType!;
    _status = status!;
    _createdDate = createdDate!;
    _updatedDate = updatedDate!;
}

  Result.fromJson(dynamic json) {
    _id = json['id'];
    _content = json['content'];
    _contentType = json['content_type'];
    _status = json['status'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
  }
  String? _id;
  String? _content;
  String? _contentType;
  String? _status;
  String? _createdDate;
  String? _updatedDate;

  String? get id => _id;
  String? get content => _content;
  String? get contentType => _contentType;
  String? get status => _status;
  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['content'] = _content;
    map['content_type'] = _contentType;
    map['status'] = _status;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    return map;
  }

}