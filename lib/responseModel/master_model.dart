/// status : "Success"
/// response_code : 200
/// message : "Master Data List"
/// result : {"Gotra":[{"g_id":"1","gotra":"Airan","status":"1"}],"MaritialStatus":[{"marid_id":"1","name":"Unmarried","status":"1"}],"education":[{"e_id":"1","education":"Trade School","status":"1"}],"bussiness":[{"b_id":"2","business":"Business","status":"1"}],"height":[{"h_id":"1","height":"4' 0\"","status":"1"}],"State":[{"state_id":"1","state":"Andaman and Nicobar Island","status":"1"}]}

class MasterModel {
  MasterModel({
      String? status, 
      int? responseCode,
      String? message,
    MasterResult? result,}){
    _status = status;
    _responseCode = responseCode!;
    _message = message;
    _result = result!;
}

  MasterModel.fromJson(dynamic json) {
    _status = json['status'];
    _responseCode = json['response_code'];
    _message = json['message'];
    _result = json['result'] != null ? MasterResult.fromJson(json['result']) : null;
  }
  String? _status;
  int? _responseCode;
  String? _message;
  MasterResult? _result;

  String? get status => _status;
  int? get responseCode => _responseCode;
  String? get message => _message;
  MasterResult? get result => _result;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['status'] = _status;
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

/// Gotra : [{"g_id":"1","gotra":"Airan","status":"1"}]
/// MaritialStatus : [{"marid_id":"1","name":"Unmarried","status":"1"}]
/// education : [{"e_id":"1","education":"Trade School","status":"1"}]
/// bussiness : [{"b_id":"2","business":"Business","status":"1"}]
/// height : [{"h_id":"1","height":"4' 0\"","status":"1"}]
/// State : [{"state_id":"1","state":"Andaman and Nicobar Island","status":"1"}]

class MasterResult {
  MasterResult({
      List<Gotra>? gotra,
      List<MaritialStatus>? maritialStatus,
      List<Education>? education,
      List<Bussiness>? bussiness,
      List<Height>? height,
      List<StateName>? state,}){
    _gotra = gotra!;
    _maritialStatus = maritialStatus!;
    _education = education!;
    _bussiness = bussiness!;
    _height = height!;
    _state = state!;
}

  MasterResult.fromJson(dynamic json) {
    if (json['Gotra'] != null) {
      _gotra = [];
      json['Gotra'].forEach((v) {
        _gotra?.add(Gotra.fromJson(v));
      });
    }
    if (json['MaritialStatus'] != null) {
      _maritialStatus = [];
      json['MaritialStatus'].forEach((v) {
        _maritialStatus?.add(MaritialStatus.fromJson(v));
      });
    }
    if (json['education'] != null) {
      _education = [];
      json['education'].forEach((v) {
        _education?.add(Education.fromJson(v));
      });
    }
    if (json['bussiness'] != null) {
      _bussiness = [];
      json['bussiness'].forEach((v) {
        _bussiness?.add(Bussiness.fromJson(v));
      });
    }
    if (json['height'] != null) {
      _height = [];
      json['height'].forEach((v) {
        _height?.add(Height.fromJson(v));
      });
    }
    if (json['State'] != null) {
      _state = [];
      json['State'].forEach((v) {
        _state?.add(StateName.fromJson(v));
      });
    }
  }
  List<Gotra>? _gotra;
  List<MaritialStatus>? _maritialStatus;
  List<Education>? _education;
  List<Bussiness>? _bussiness;
  List<Height>? _height;
  List<StateName>? _state;

  List<Gotra> get gotra => _gotra!;
  List<MaritialStatus> get maritialStatus => _maritialStatus!;
  List<Education> get education => _education!;
  List<Bussiness> get bussiness => _bussiness!;
  List<Height> get height => _height!;
  List<StateName> get state => _state!;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    if (_gotra != null) {
      map['Gotra'] = _gotra?.map((v) => v.toJson()).toList();
    }
    if (_maritialStatus != null) {
      map['MaritialStatus'] = _maritialStatus?.map((v) => v.toJson()).toList();
    }
    if (_education != null) {
      map['education'] = _education?.map((v) => v.toJson()).toList();
    }
    if (_bussiness != null) {
      map['bussiness'] = _bussiness?.map((v) => v.toJson()).toList();
    }
    if (_height != null) {
      map['height'] = _height?.map((v) => v.toJson()).toList();
    }
    if (_state != null) {
      map['State'] = _state?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// state_id : "1"
/// state : "Andaman and Nicobar Island"
/// status : "1"

class StateName {
  StateName({
      String? stateId, 
      String? state, 
      String? status,}){
    _stateId = stateId;
    _state = state;
    _status = status;
}

  StateName.fromJson(dynamic json) {
    _stateId = json['state_id'];
    _state = json['state'];
    _status = json['status'];
  }
  String? _stateId;
  String? _state;
  String? _status;

  String? get stateId => _stateId;
  String? get state => _state;
  String? get status => _status;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['state_id'] = _stateId;
    map['state'] = _state;
    map['status'] = _status;
    return map;
  }

}

/// h_id : "1"
/// height : "4' 0\""
/// status : "1"

class Height {
  Height({
      String? hId, 
      String? height, 
      String? status,}){
    _hId = hId;
    _height = height;
    _status = status;
}

  Height.fromJson(dynamic json) {
    _hId = json['h_id'];
    _height = json['height'];
    _status = json['status'];
  }
  String? _hId;
  String? _height;
  String? _status;

  String? get hId => _hId;
  String? get height => _height;
  String? get status => _status;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['h_id'] = _hId;
    map['height'] = _height;
    map['status'] = _status;
    return map;
  }

}

/// b_id : "2"
/// business : "Business"
/// status : "1"

class Bussiness {
  Bussiness({
      String? bId, 
      String? business, 
      String? status,}){
    _bId = bId;
    _business = business;
    _status = status;
}

  Bussiness.fromJson(dynamic json) {
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

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['b_id'] = _bId;
    map['business'] = _business;
    map['status'] = _status;
    return map;
  }

}

/// e_id : "1"
/// education : "Trade School"
/// status : "1"

class Education {
  Education({
      String? eId, 
      String? education, 
      String? status,}){
    _eId = eId;
    _education = education;
    _status = status;
}

  Education.fromJson(dynamic json) {
    _eId = json['e_id'];
    _education = json['education'];
    _status = json['status'];
  }
  String? _eId;
  String? _education;
  String? _status;

  String? get eId => _eId;
  String? get education => _education;
  String? get status => _status;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['e_id'] = _eId;
    map['education'] = _education;
    map['status'] = _status;
    return map;
  }

}

/// marid_id : "1"
/// name : "Unmarried"
/// status : "1"

class MaritialStatus {
  MaritialStatus({
      String? maridId, 
      String? name, 
      String? status,}){
    _maridId = maridId;
    _name = name;
    _status = status;
}

  MaritialStatus.fromJson(dynamic json) {
    _maridId = json['marid_id'];
    _name = json['name'];
    _status = json['status'];
  }
  String? _maridId;
  String? _name;
  String? _status;

  String? get maridId => _maridId;
  String? get name => _name;
  String? get status => _status;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['marid_id'] = _maridId;
    map['name'] = _name;
    map['status'] = _status;
    return map;
  }

}

/// g_id : "1"
/// gotra : "Airan"
/// status : "1"

class Gotra {
  Gotra({
      String? gId, 
      String? gotra, 
      String? status,}){
    _gId = gId;
    _gotra = gotra;
    _status = status;
}

  Gotra.fromJson(dynamic json) {
    _gId = json['g_id'];
    _gotra = json['gotra'];
    _status = json['status'];
  }
  String? _gId;
  String? _gotra;
  String? _status;

  String? get gId => _gId;
  String? get gotra => _gotra;
  String? get status => _status;

  Map<String?, dynamic> toJson() {
    final map = <String?, dynamic>{};
    map['g_id'] = _gId;
    map['gotra'] = _gotra;
    map['status'] = _status;
    return map;
  }

}