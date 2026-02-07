class GetNewsAndEventsListResponse {
  String? status;
  int? responseCode;
  String? message;
  List<Result>? result;

  GetNewsAndEventsListResponse(
      {this.status, this.responseCode, this.message, this.result});

  GetNewsAndEventsListResponse.fromJson(Map<String, dynamic> json) {
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
  String? newsId;
  String? title;
  String? details;
  String? image;
  String? date;
  String? status;
  String? createdDate;
  String? updatedDate;

  Result(
      {this.newsId,
        this.title,
        this.details,
        this.image,
        this.date,
        this.status,
        this.createdDate,
        this.updatedDate});

  Result.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    title = json['title'];
    details = json['details'];
    image = json['image'];
    date = json['date'];
    status = json['status'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['title'] = this.title;
    data['details'] = this.details;
    data['image'] = this.image;
    data['date'] = this.date;
    data['status'] = this.status;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
