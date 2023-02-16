class ErrorResponse {
  String? status;
  String? message;
  String? path;
  String? statusCode;
  DateTime? date;

  ErrorResponse({
    required this.status,
    required this.message,
    required this.path,
    required this.statusCode,
    required this.date,
  });

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    path = json['path'];
    statusCode = json['statusCode'];
    date = json['date'];
  }
}
