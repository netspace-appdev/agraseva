/// status : "Success"
/// response_code : 200
/// message : "DashBoard Data"
/// result : [{"QuickInfo":[{"id":"3","Information":"Now we Start online Match Event complete your Registration.","status":"1","created_at":"2022-03-05 08:01:38","updated_At":"2022-03-05 08:01:38"}],"NotificationContent":[{"id":"1","details":"<![endif]-->","CreatedDate":"2018-09-18 08:45:32"}],"NotificationAlert":[{"id":"9","Title":"Online Matchmaking","Details":"Now we Start online Match Event complete your Registration.","Image":"220320010328.jpg","NotificationFor":null,"m_id":null,"CreateDate":"2020-03-22 01:27:28","UpdatedDate":"2020-03-22 01:27:28","Status":"1"}]}]

class DashboardModel {
  DashboardModel({
      String? status, 
      int? responseCode,
      String? message, 
      List<DashboradResult>? result,}){
    _status = status;
    _responseCode = responseCode!;
    _message = message;
    _result = result!;
}

  DashboardModel.fromJson(dynamic json) {
    _status = json['status'];
    _responseCode = json['response_code'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result!.add(DashboradResult.fromJson(v));
      });
    }
  }
  String? _status;
  int? _responseCode;
  String? _message;
  List<DashboradResult>? _result;

  String? get status => _status;
  int get responseCode => _responseCode!;
  String? get message => _message;
  List<DashboradResult> get result => _result!;

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

/// QuickInfo : [{"id":"3","Information":"Now we Start online Match Event complete your Registration.","status":"1","created_at":"2022-03-05 08:01:38","updated_At":"2022-03-05 08:01:38"}]
/// NotificationContent : [{"id":"1","details":"<![endif]-->","CreatedDate":"2018-09-18 08:45:32"}]
/// NotificationAlert : [{"id":"9","Title":"Online Matchmaking","Details":"Now we Start online Match Event complete your Registration.","Image":"220320010328.jpg","NotificationFor":null,"m_id":null,"CreateDate":"2020-03-22 01:27:28","UpdatedDate":"2020-03-22 01:27:28","Status":"1"}]

class DashboradResult {
  DashboradResult({
      List<QuickInfo>? quickInfo, 
      List<NotificationContent>? notificationContent, 
      List<NotificationAlert>? notificationAlert,}){
    _quickInfo = quickInfo!;
    _notificationContent = notificationContent!;
    _notificationAlert = notificationAlert!;
}

  DashboradResult.fromJson(dynamic json) {
    if (json['QuickInfo'] != null) {
      _quickInfo = [];
      json['QuickInfo'].forEach((v) {
        _quickInfo!.add(QuickInfo.fromJson(v));
      });
    }
    if (json['NotificationContent'] != null) {
      _notificationContent = [];
      json['NotificationContent'].forEach((v) {
        _notificationContent!.add(NotificationContent.fromJson(v));
      });
    }
    if (json['NotificationAlert'] != null) {
      _notificationAlert = [];
      json['NotificationAlert'].forEach((v) {
        _notificationAlert!.add(NotificationAlert.fromJson(v));
      });
    }
  }
  List<QuickInfo>? _quickInfo;
  List<NotificationContent>? _notificationContent;
  List<NotificationAlert>? _notificationAlert;

  List<QuickInfo> get quickInfo => _quickInfo!;
  List<NotificationContent> get notificationContent => _notificationContent!;
  List<NotificationAlert> get notificationAlert => _notificationAlert!;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    if (_quickInfo != null) {
      map['QuickInfo'] = _quickInfo!.map((v) => v.toJson()).toList();
    }
    if (_notificationContent != null) {
      map['NotificationContent'] = _notificationContent!.map((v) => v.toJson()).toList();
    }
    if (_notificationAlert != null) {
      map['NotificationAlert'] = _notificationAlert!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "9"
/// Title : "Online Matchmaking"
/// Details : "Now we Start online Match Event complete your Registration."
/// Image : "220320010328.jpg"
/// NotificationFor : null
/// m_id : null
/// CreateDate : "2020-03-22 01:27:28"
/// UpdatedDate : "2020-03-22 01:27:28"
/// Status : "1"

class NotificationAlert {
  NotificationAlert({
      String? id, 
      String? title, 
      String? details, 
      String? image, 
      dynamic notificationFor, 
      dynamic mId, 
      String? createDate, 
      String? updatedDate, 
      String? status,}){
    _id = id;
    _title = title;
    _details = details;
    _image = image;
    _notificationFor = notificationFor;
    _mId = mId;
    _createDate = createDate;
    _updatedDate = updatedDate;
    _status = status;
}

  NotificationAlert.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['Title'];
    _details = json['Details'];
    _image = json['Image'];
    _notificationFor = json['NotificationFor'];
    _mId = json['m_id'];
    _createDate = json['CreateDate'];
    _updatedDate = json['UpdatedDate'];
    _status = json['Status'];
  }
  String? _id;
  String? _title;
  String? _details;
  String? _image;
  dynamic _notificationFor;
  dynamic _mId;
  String? _createDate;
  String? _updatedDate;
  String? _status;

  String? get id => _id;
  String? get title => _title;
  String? get details => _details;
  String? get image => _image;
  dynamic get notificationFor => _notificationFor;
  dynamic get mId => _mId;
  String? get createDate => _createDate;
  String? get updatedDate => _updatedDate;
  String? get status => _status;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['id'] = _id;
    map['Title'] = _title;
    map['Details'] = _details;
    map['Image'] = _image;
    map['NotificationFor'] = _notificationFor;
    map['m_id'] = _mId;
    map['CreateDate'] = _createDate;
    map['UpdatedDate'] = _updatedDate;
    map['Status'] = _status;
    return map;
  }

}

/// id : "1"
/// details : "<![endif]-->"
/// CreatedDate : "2018-09-18 08:45:32"

class NotificationContent {
  NotificationContent({
      String? id, 
      String? details, 
      String? createdDate,}){
    _id = id;
    _details = details;
    _createdDate = createdDate;
}

  NotificationContent.fromJson(dynamic json) {
    _id = json['id'];
    _details = json['details'];
    _createdDate = json['CreatedDate'];
  }
  String? _id;
  String? _details;
  String? _createdDate;

  String? get id => _id;
  String? get details => _details;
  String? get createdDate => _createdDate;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['id'] = _id;
    map['details'] = _details;
    map['CreatedDate'] = _createdDate;
    return map;
  }

}

/// id : "3"
/// Information : "Now we Start online Match Event complete your Registration."
/// status : "1"
/// created_at : "2022-03-05 08:01:38"
/// updated_At : "2022-03-05 08:01:38"

class QuickInfo {
  QuickInfo({
      String? id, 
      String? information, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _information = information;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  QuickInfo.fromJson(dynamic json) {
    _id = json['id'];
    _information = json['Information'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_At'];
  }
  String? _id;
  String? _information;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get information => _information;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['id'] = _id;
    map['Information'] = _information;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_At'] = _updatedAt;
    return map;
  }

}