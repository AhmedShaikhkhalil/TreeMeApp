/// message : "User registered successfully"
/// data : {"id":211,"name":"ali","email_verified_at":null,"provider":null,"provider_id":null,"created_at":"2023-07-03T13:52:17.000000Z","updated_at":"2023-07-03T13:52:17.000000Z","user_type":"member","firebase_uid":"Q3hgNFPWCcWg4oKqSmeKkAXslxu2","avatar":null,"otp":"788953","phone":"+972595236244","eventApp":null,"deleted_at":null,"age":null}
/// token : {"api_token":"272|xkOM1XWsPrZqKAyTgBwDn4KAXqY4OYmLrs1Z4eFF"}
/// otp : 788953
/// status : 200

class RegisterModel {
  RegisterModel({
      String? message, 
      Data? data, 
      Token? token, 
      num? otp, 
      num? status,}){
    _message = message;
    _data = data;
    _token = token;
    _otp = otp;
    _status = status;
}

  RegisterModel.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _token = json['token'] != null ? Token.fromJson(json['token']) : null;
    _otp = json['otp'];
    _status = json['status'];
  }
  String? _message;
  Data? _data;
  Token? _token;
  num? _otp;
  num? _status;
RegisterModel copyWith({  String? message,
  Data? data,
  Token? token,
  num? otp,
  num? status,
}) => RegisterModel(  message: message ?? _message,
  data: data ?? _data,
  token: token ?? _token,
  otp: otp ?? _otp,
  status: status ?? _status,
);
  String? get message => _message;
  Data? get data => _data;
  Token? get token => _token;
  num? get otp => _otp;
  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    if (_token != null) {
      map['token'] = _token?.toJson();
    }
    map['otp'] = _otp;
    map['status'] = _status;
    return map;
  }

}

/// api_token : "272|xkOM1XWsPrZqKAyTgBwDn4KAXqY4OYmLrs1Z4eFF"

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

/// id : 211
/// name : "ali"
/// email_verified_at : null
/// provider : null
/// provider_id : null
/// created_at : "2023-07-03T13:52:17.000000Z"
/// updated_at : "2023-07-03T13:52:17.000000Z"
/// user_type : "member"
/// firebase_uid : "Q3hgNFPWCcWg4oKqSmeKkAXslxu2"
/// avatar : null
/// otp : "788953"
/// phone : "+972595236244"
/// eventApp : null
/// deleted_at : null
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
      String? otp, 
      String? phone, 
      dynamic eventApp, 
      dynamic deletedAt, 
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
    _otp = otp;
    _phone = phone;
    _eventApp = eventApp;
    _deletedAt = deletedAt;
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
    _otp = json['otp'];
    _phone = json['phone'];
    _eventApp = json['eventApp'];
    _deletedAt = json['deleted_at'];
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
  String? _otp;
  String? _phone;
  dynamic _eventApp;
  dynamic _deletedAt;
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
  String? otp,
  String? phone,
  dynamic eventApp,
  dynamic deletedAt,
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
  otp: otp ?? _otp,
  phone: phone ?? _phone,
  eventApp: eventApp ?? _eventApp,
  deletedAt: deletedAt ?? _deletedAt,
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
  String? get otp => _otp;
  String? get phone => _phone;
  dynamic get eventApp => _eventApp;
  dynamic get deletedAt => _deletedAt;
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
    map['otp'] = _otp;
    map['phone'] = _phone;
    map['eventApp'] = _eventApp;
    map['deleted_at'] = _deletedAt;
    map['age'] = _age;
    return map;
  }

}