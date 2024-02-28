/// message : "The selected phone is invalid."
/// errors : {"phone":["The selected phone is invalid."]}

class ErrorResponseModel {
  ErrorResponseModel({String? message, int? code}) {
    _message = message;
    _code = code;
  }

  ErrorResponseModel.fromJson(dynamic json) {
    _message = json['error'] ?? json['message'];
    _code = json['status'];
  }
  String? _message;
  int? _code;
  ErrorResponseModel copyWith({String? message, int? code}) =>
      ErrorResponseModel(message: message ?? _message, code: code ?? _code);
  String? get message => _message;
  int? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }
}
