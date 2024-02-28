/// message : "The searched user contacts:"
/// data : [{"id":1,"name":"Maram","email_verified_at":null,"provider":null,"provider_id":null,"created_at":"2023-07-24T11:12:31.000000Z","updated_at":"2023-07-26T09:40:36.000000Z","user_type":"member","firebase_uid":"Undg0qwkkDSa8uZO61W701ghtT23","avatar":null,"phone":"+970592877046","otp":"304360","age":null,"contacts":"[\"+972597350412\",\"+972597450412\",\"+972597450479\"]","email":null},{"id":2,"name":"HIND","email_verified_at":null,"provider":null,"provider_id":null,"created_at":"2023-07-24T11:40:07.000000Z","updated_at":"2023-07-24T13:22:01.000000Z","user_type":"member","firebase_uid":"CAqUB4Gxaie7pIsa78XdrfpTBCd2","avatar":null,"phone":"+970595137670","otp":"183538","age":null,"contacts":"[\"+972597350412\",\"+972597450412\",\"+972597450479\"]","email":null},{"id":5,"name":"IMAN123","email_verified_at":null,"provider":null,"provider_id":null,"created_at":"2023-07-24T12:26:53.000000Z","updated_at":"2023-07-24T12:26:53.000000Z","user_type":"member","firebase_uid":"N8qQjbnewQXqg8eui761EIMra5A2","avatar":null,"phone":"+972597350412","otp":"773841","age":null,"contacts":null,"email":null}]
/// status : 200

class SearchContact {
  SearchContact({
    String? message,
    List<Contact>? data,
    num? status,
  }) {
    _message = message;
    _data = data;
    _status = status;
  }

  SearchContact.fromJson(dynamic json) {
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Contact.fromJson(v));
      });
    }
    _status = json['status'];
  }
  String? _message;
  List<Contact>? _data;
  num? _status;
  SearchContact copyWith({
    String? message,
    List<Contact>? data,
    num? status,
  }) =>
      SearchContact(
        message: message ?? _message,
        data: data ?? _data,
        status: status ?? _status,
      );
  String? get message => _message;
  List<Contact>? get data => _data;
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

/// id : 1
/// name : "Maram"
/// email_verified_at : null
/// provider : null
/// provider_id : null
/// created_at : "2023-07-24T11:12:31.000000Z"
/// updated_at : "2023-07-26T09:40:36.000000Z"
/// user_type : "member"
/// firebase_uid : "Undg0qwkkDSa8uZO61W701ghtT23"
/// avatar : null
/// phone : "+970592877046"
/// otp : "304360"
/// age : null
/// contacts : "[\"+972597350412\",\"+972597450412\",\"+972597450479\"]"
/// email : null

class Contact {
  Contact({
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
    String? contacts,
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

  Contact.fromJson(dynamic json) {
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
  String? _contacts;
  dynamic _email;
  Contact copyWith({
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
    String? contacts,
    dynamic email,
  }) =>
      Contact(
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
  String? get contacts => _contacts;
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
