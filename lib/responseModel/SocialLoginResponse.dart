class SocialLoginResponse {
  String? status;
  int? responseCode;
  String? message;
  int? result;

  SocialLoginResponse(
      {this.status, this.responseCode, this.message, this.result});

  SocialLoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    message = json['message'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['result'] = this.result;
    return data;
  }
}
