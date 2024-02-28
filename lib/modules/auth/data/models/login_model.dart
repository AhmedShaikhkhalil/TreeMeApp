/// success : true
/// token : {"api_token":"32|PYOSN3GJzyLnarjGvm2ua38eeZ6tiysywbXW9ky6"}
/// message : "User login successfully."
/// data : {"id":5,"name":"ali","email_verified_at":null,"provider":null,"provider_id":null,"created_at":"2023-07-04T10:36:29.000000Z","updated_at":"2023-07-05T11:56:42.000000Z","user_type":"member","firebase_uid":"cBOeY1FqxFTP58PfggA4WtvlzSl1","avatar":null,"phone":"+972597250510","otp":"7701","age":null}
/// status : 200

class LoginModel {
  LoginModel({
      bool? success, 
      Token? token, 
      String? message, 
      Data? data, 
      num? status,}){
    _success = success;
    _token = token;
    _message = message;
    _data = data;
    _status = status;
}

  LoginModel.fromJson(dynamic json) {
    _success = json['success'];
    _token = json['token'] != null ? Token.fromJson(json['token']) : null;
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _status = json['status'];
  }
  bool? _success;
  Token? _token;
  String? _message;
  Data? _data;
  num? _status;
LoginModel copyWith({  bool? success,
  Token? token,
  String? message,
  Data? data,
  num? status,
}) => LoginModel(  success: success ?? _success,
  token: token ?? _token,
  message: message ?? _message,
  data: data ?? _data,
  status: status ?? _status,
);
  bool? get success => _success;
  Token? get token => _token;
  String? get message => _message;
  Data? get data => _data;
  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_token != null) {
      map['token'] = _token?.toJson();
    }
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['status'] = _status;
    return map;
  }

}

/// id : 5
/// name : "ali"
/// email_verified_at : null
/// provider : null
/// provider_id : null
/// created_at : "2023-07-04T10:36:29.000000Z"
/// updated_at : "2023-07-05T11:56:42.000000Z"
/// user_type : "member"
/// firebase_uid : "cBOeY1FqxFTP58PfggA4WtvlzSl1"
/// avatar : null
/// phone : "+972597250510"
/// otp : "7701"
/// age : null

class Data {
  Data({
      num? id, 
      String? name, 
      dynamic emailVerifiedAt, 
      dynamic provider, 
      dynamic providerId, 
      String? createdAt, 
      String? updatedAt, 
      String? userType, 
      String? firebaseUid, 
      dynamic avatar, 
      String? phone, 
      String? otp, 
      dynamic age,}){
    _id = id;
    _name = name;
    _emailVerifiedAt = emailVerifiedAt;
    _provider = provider;
    _providerId = providerId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _userType = userType;
    _firebaseUid = firebaseUid;
    _avatar = avatar;
    _phone = phone;
    _otp = otp;
    _age = age;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _emailVerifiedAt = json['email_verified_at'];
    _provider = json['provider'];
    _providerId = json['provider_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _userType = json['user_type'];
    _firebaseUid = json['firebase_uid'];
    _avatar = json['avatar'];
    _phone = json['phone'];
    _otp = json['otp'];
    _age = json['age'];
  }
  num? _id;
  String? _name;
  dynamic _emailVerifiedAt;
  dynamic _provider;
  dynamic _providerId;
  String? _createdAt;
  String? _updatedAt;
  String? _userType;
  String? _firebaseUid;
  dynamic _avatar;
  String? _phone;
  String? _otp;
  dynamic _age;
Data copyWith({  num? id,
  String? name,
  dynamic emailVerifiedAt,
  dynamic provider,
  dynamic providerId,
  String? createdAt,
  String? updatedAt,
  String? userType,
  String? firebaseUid,
  dynamic avatar,
  String? phone,
  String? otp,
  dynamic age,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
  provider: provider ?? _provider,
  providerId: providerId ?? _providerId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  userType: userType ?? _userType,
  firebaseUid: firebaseUid ?? _firebaseUid,
  avatar: avatar ?? _avatar,
  phone: phone ?? _phone,
  otp: otp ?? _otp,
  age: age ?? _age,
);
  num? get id => _id;
  String? get name => _name;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  dynamic get provider => _provider;
  dynamic get providerId => _providerId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get userType => _userType;
  String? get firebaseUid => _firebaseUid;
  dynamic get avatar => _avatar;
  String? get phone => _phone;
  String? get otp => _otp;
  dynamic get age => _age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email_verified_at'] = _emailVerifiedAt;
    map['provider'] = _provider;
    map['provider_id'] = _providerId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['user_type'] = _userType;
    map['firebase_uid'] = _firebaseUid;
    map['avatar'] = _avatar;
    map['phone'] = _phone;
    map['otp'] = _otp;
    map['age'] = _age;
    return map;
  }

}

/// api_token : "32|PYOSN3GJzyLnarjGvm2ua38eeZ6tiysywbXW9ky6"

class Token {
  Token({
      String? apiToken,}){
    _apiToken = apiToken;
}

  Token.fromJson(dynamic json) {
    _apiToken = json['api_token'];
  }
  String? _apiToken;
Token copyWith({  String? apiToken,
}) => Token(  apiToken: apiToken ?? _apiToken,
);
  String? get apiToken => _apiToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['api_token'] = _apiToken;
    return map;
  }

}