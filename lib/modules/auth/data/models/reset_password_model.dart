/// message : "OTP sent successfully."
/// otp : "5569"

class ResetPasswordModel {
  ResetPasswordModel({
      String? message, 
      String? otp,}){
    _message = message;
    _otp = otp;
}

  ResetPasswordModel.fromJson(dynamic json) {
    _message = json['message'];
    _otp = json['otp'];
  }
  String? _message;
  String? _otp;
ResetPasswordModel copyWith({  String? message,
  String? otp,
}) => ResetPasswordModel(  message: message ?? _message,
  otp: otp ?? _otp,
);
  String? get message => _message;
  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['otp'] = _otp;
    return map;
  }

}