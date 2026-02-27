/*class GetSocialListResponse {
  String? status;
  int? responseCode;
  String? message;
  List<Result>? result;

  GetSocialListResponse(
      {this.status, this.responseCode, this.message, this.result});

  GetSocialListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? id;
  String? name;
  String? mobileNumber;
  String? dOB;
  String? address;
  String? jobType;
  String? jobDetails;
  String? profilePhoto;
  String? status;
  String? createdDate;
  String? cityName;
  String? stateName;

  Result(
      {this.id,
        this.name,
        this.mobileNumber,
        this.dOB,
        this.address,
        this.jobType,
        this.jobDetails,
        this.profilePhoto,
        this.status,
        this.createdDate,
        this.cityName,
        this.stateName});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    mobileNumber = json['MobileNumber'];
    dOB = json['DOB'];
    address = json['Address'];
    jobType = json['JobType'];
    jobDetails = json['JobDetails'];
    profilePhoto = json['ProfilePhoto'];
    status = json['Status']?.toString();

    //status = json['Status'];
    createdDate = json['CreatedDate'];
    cityName = json['CityName'];
    stateName = json['StateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['MobileNumber'] = this.mobileNumber;
    data['DOB'] = this.dOB;
    data['Address'] = this.address;
    data['JobType'] = this.jobType;
    data['JobDetails'] = this.jobDetails;
    data['ProfilePhoto'] = this.profilePhoto;
   // data['Status'] = this.status;

    data['CreatedDate'] = this.createdDate;
    data['CityName'] = this.cityName;
    data['StateName'] = this.stateName;
    return data;
  }
}*/
class GetSocialListResponse {
  String? status;
  int? responseCode;
  String? message;
  List<Result>? result;

  GetSocialListResponse({
    this.status,
    this.responseCode,
    this.message,
    this.result,
  });

  GetSocialListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    responseCode = json['response_code'] is int
        ? json['response_code']
        : int.tryParse(json['response_code']?.toString() ?? '');

    message = json['message']?.toString();

    if (json['result'] != null && json['result'] is List) {
      result = (json['result'] as List)
          .map((v) => Result.fromJson(v))
          .toList();
    } else {
      result = [];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'response_code': responseCode,
      'message': message,
      'result': result?.map((v) => v.toJson()).toList(),
    };
  }
}

class Result {
  String? id;
  String? name;
  String? mobileNumber;
  String? dOB;
  String? address;
  String? jobType;
  String? jobDetails;
  String? profilePhoto;
  String? status;
  String? createdDate;
  String? cityName;
  String? stateName;

  Result({
    this.id,
    this.name,
    this.mobileNumber,
    this.dOB,
    this.address,
    this.jobType,
    this.jobDetails,
    this.profilePhoto,
    this.status,
    this.createdDate,
    this.cityName,
    this.stateName,
  });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['Id']?.toString();
    name = json['Name']?.toString();
    mobileNumber = json['MobileNumber']?.toString();
    dOB = json['DOB']?.toString();
    address = json['Address']?.toString();
    jobType = json['JobType']?.toString();
    jobDetails = json['JobDetails']?.toString();
    profilePhoto = json['ProfilePhoto']?.toString();
    status = json['Status']?.toString();
    createdDate = json['CreatedDate']?.toString();
    cityName = json['CityName']?.toString();
    stateName = json['StateName']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'MobileNumber': mobileNumber,
      'DOB': dOB,
      'Address': address,
      'JobType': jobType,
      'JobDetails': jobDetails,
      'ProfilePhoto': profilePhoto,
      'Status': status,
      'CreatedDate': createdDate,
      'CityName': cityName,
      'StateName': stateName,
    };
  }
}