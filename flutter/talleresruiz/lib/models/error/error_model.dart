class ErrorResponse {
  String? status;
  String? message;
  String? path;
  int? statusCode;
  String? date;
  List<SubErrorsResponse>? subErrors;

  ErrorResponse({
    required this.status,
    required this.message,
    required this.path,
    required this.statusCode,
    required this.date,
    this.subErrors,
  });

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    path = json['path'];
    statusCode = json['statusCode'];
    date = json['date'];
    if (this.subErrors != null) {
      json['subErrors'] = this.subErrors!.map((v) => v.toJson()).toList();
    }
  }
}

class SubErrorsResponse {
  String? object;
  String? message;
  String? field;
  dynamic rejectedValue;

  SubErrorsResponse(
      {this.object, this.message, this.field, this.rejectedValue});

  SubErrorsResponse.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    message = json['message'];
    field = json['field'];
    rejectedValue = json['rejectedValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object'] = this.object;
    data['message'] = this.message;
    data['field'] = this.field;
    data['rejectedValue'] = this.rejectedValue;
    return data;
  }
}
