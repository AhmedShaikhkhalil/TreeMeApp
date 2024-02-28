import 'package:get/get.dart';

/// message : "Your Contacts "
/// data : [{"phone":"+972597350412","status":"found","user_data":{"id":5,"name":"IMAN123","email_verified_at":null,"provider":null,"provider_id":null,"created_at":"2023-07-24T12:26:53.000000Z","updated_at":"2023-07-24T12:26:53.000000Z","user_type":"member","firebase_uid":"N8qQjbnewQXqg8eui761EIMra5A2","avatar":null,"phone":"+972597350412","otp":"773841","age":null,"contacts":null,"email":null}},{"phone":"+972597450412","status":"not found","user_data":null},{"phone":"+972597450479","status":"not found","user_data":null},{"phone":"+970592877046","status":"found","user_data":{"id":1,"name":"ghgh","email_verified_at":null,"provider":null,"provider_id":null,"created_at":"2023-07-24T11:12:31.000000Z","updated_at":"2023-07-30T16:01:19.000000Z","user_type":"member","firebase_uid":"Undg0qwkkDSa8uZO61W701ghtT23","avatar":"avatar/tMzgwxb3B9MXkNVNQgk08UeCJBdisIsOM3DsAj4E.png","phone":"+970592877046","otp":"304360","age":20,"contacts":"[\"+972597350412\",\"+972597450412\",\"+972597450479\"]","email":null}},{"phone":"+970595137670","status":"found","user_data":{"id":2,"name":"HIND","email_verified_at":null,"provider":null,"provider_id":null,"created_at":"2023-07-24T11:40:07.000000Z","updated_at":"2023-07-24T13:22:01.000000Z","user_type":"member","firebase_uid":"CAqUB4Gxaie7pIsa78XdrfpTBCd2","avatar":null,"phone":"+970595137670","otp":"183538","age":null,"contacts":"[\"+972597350412\",\"+972597450412\",\"+972597450479\"]","email":null}}]
/// status : 200

class MyContactModel {
  MyContactModel({
    String? message,
    List<Data>? data,
    num? status,
  }) {
    _message = message;
    _data = data;
    _status = status;
  }

  MyContactModel.fromJson(dynamic json) {
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _status = json['status'];
  }
  String? _message;
  List<Data>? _data;
  num? _status;
  MyContactModel copyWith({
    String? message,
    List<Data>? data,
    num? status,
  }) =>
      MyContactModel(
        message: message ?? _message,
        data: data ?? _data,
        status: status ?? _status,
      );
  String? get message => _message;
  List<Data>? get data => _data;
  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    return map;
  }
}

/// phone : "+972597350412"
/// status : "found"
/// user_data : {"id":5,"name":"IMAN123","email_verified_at":null,"provider":null,"provider_id":null,"created_at":"2023-07-24T12:26:53.000000Z","updated_at":"2023-07-24T12:26:53.000000Z","user_type":"member","firebase_uid":"N8qQjbnewQXqg8eui761EIMra5A2","avatar":null,"phone":"+972597350412","otp":"773841","age":null,"contacts":null,"email":null}

class Data {
  Data({
    String? phone,
    String? status,
    UserData? userData,
  }) {
    _phone = phone;
    _status = status;
    _userData = userData;
  }

  Data.fromJson(dynamic json) {
    _phone = json['phone'];
    _status = json['status'];
    _userData = json['user_data'] != null ? UserData.fromJson(json['user_data']) : null;
  }
  String? _phone;
  String? _status;
  UserData? _userData;
  RxBool isCheck = false.obs;
  Data copyWith({
    String? phone,
    String? status,
    UserData? userData,
  }) =>
      Data(
        phone: phone ?? _phone,
        status: status ?? _status,
        userData: userData ?? _userData,
      );
  String? get phone => _phone;
  String? get status => _status;
  UserData? get userData => _userData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    map['status'] = _status;
    if (_userData != null) {
      map['user_data'] = _userData?.toJson();
    }
    return map;
  }
}

/// id : 5
/// name : "IMAN123"
/// email_verified_at : null
/// provider : null
/// provider_id : null
/// created_at : "2023-07-24T12:26:53.000000Z"
/// updated_at : "2023-07-24T12:26:53.000000Z"
/// user_type : "member"
/// firebase_uid : "N8qQjbnewQXqg8eui761EIMra5A2"
/// avatar : null
/// phone : "+972597350412"
/// otp : "773841"
/// age : null
/// contacts : null
/// email : null

class UserData {
  UserData({
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
    dynamic age,
    dynamic contacts,
    dynamic email,
  }) {
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
    _contacts = contacts;
    _email = email;
  }

  UserData.fromJson(dynamic json) {
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
    _contacts = json['contacts'];
    _email = json['email'];
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
  dynamic _contacts;
  dynamic _email;
  UserData copyWith({
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
    dynamic age,
    dynamic contacts,
    dynamic email,
  }) =>
      UserData(
        id: id ?? _id,
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
        contacts: contacts ?? _contacts,
        email: email ?? _email,
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
  dynamic get contacts => _contacts;
  dynamic get email => _email;

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
    map['contacts'] = _contacts;
    map['email'] = _email;
    return map;
  }
}
