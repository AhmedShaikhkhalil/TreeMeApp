/// message : "Event created successfully."
/// document_id : "124d7ffcb33d48c59794"
/// data : {"title":"ytewjb","date":"2023-06-19","time":"3:07 pm","event":"BIRTHDAY","event_color":"#ff0080,#ff64b1","participants":[{"id":2,"user_type":"member","firebase_uid":"CAqUB4Gxaie7pIsa78XdrfpTBCd2","fcm_token":null,"name":null,"phone":"+970595137670","age":null,"avatar":null,"otp":"183538","contacts":"[\"+972597350412\",\"+972597450412\",\"+972597450479\"]"},{"id":3,"user_type":"member","firebase_uid":"0whsoBu5wbOkAHwmFRFSfuWJ1nQ2","fcm_token":null,"name":null,"phone":"+972595236275","age":null,"avatar":null,"otp":"960252","contacts":"[\"+972597350412\",\"+972597450412\",\"+972597450479\",\"+970592877046\",\"+970595137670\"]"}],"ownerId":"3ps6pHzfAjaUkDXvNA21yfflZN73","hostUser":"0whsoBu5wbOkAHwmFRFSfuWJ1nQ2","userIds":["CAqUB4Gxaie7pIsa78XdrfpTBCd2","0whsoBu5wbOkAHwmFRFSfuWJ1nQ2","0whsoBu5wbOkAHwmFRFSfuWJ1nQ2"],"createdAt":"2023-07-25 15:32:19","updatedAt":"2023-07-25 15:32:19","lastseen":"2023-07-25 15:32:19"}
/// status : 200

class NewEventModel {
  NewEventModel({
    String? message,
    String? documentId,
    NewEvent? data,
    num? status,
  }) {
    _message = message;
    _documentId = documentId;
    _data = data;
    _status = status;
  }

  NewEventModel.fromJson(dynamic json) {
    _message = json['message'];
    _documentId = json['document_id'];
    _data = json['data'] != null ? NewEvent.fromJson(json['data']) : null;
    _status = json['status'];
  }
  String? _message;
  String? _documentId;
  NewEvent? _data;
  num? _status;
  NewEventModel copyWith({
    String? message,
    String? documentId,
    NewEvent? data,
    num? status,
  }) =>
      NewEventModel(
        message: message ?? _message,
        documentId: documentId ?? _documentId,
        data: data ?? _data,
        status: status ?? _status,
      );
  String? get message => _message;
  String? get documentId => _documentId;
  NewEvent? get data => _data;
  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['document_id'] = _documentId;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['status'] = _status;
    return map;
  }
}

/// title : "ytewjb"
/// date : "2023-06-19"
/// time : "3:07 pm"
/// event : "BIRTHDAY"
/// event_color : "#ff0080,#ff64b1"
/// participants : [{"id":2,"user_type":"member","firebase_uid":"CAqUB4Gxaie7pIsa78XdrfpTBCd2","fcm_token":null,"name":null,"phone":"+970595137670","age":null,"avatar":null,"otp":"183538","contacts":"[\"+972597350412\",\"+972597450412\",\"+972597450479\"]"},{"id":3,"user_type":"member","firebase_uid":"0whsoBu5wbOkAHwmFRFSfuWJ1nQ2","fcm_token":null,"name":null,"phone":"+972595236275","age":null,"avatar":null,"otp":"960252","contacts":"[\"+972597350412\",\"+972597450412\",\"+972597450479\",\"+970592877046\",\"+970595137670\"]"}]
/// ownerId : "3ps6pHzfAjaUkDXvNA21yfflZN73"
/// hostUser : "0whsoBu5wbOkAHwmFRFSfuWJ1nQ2"
/// userIds : ["CAqUB4Gxaie7pIsa78XdrfpTBCd2","0whsoBu5wbOkAHwmFRFSfuWJ1nQ2","0whsoBu5wbOkAHwmFRFSfuWJ1nQ2"]
/// createdAt : "2023-07-25 15:32:19"
/// updatedAt : "2023-07-25 15:32:19"
/// lastseen : "2023-07-25 15:32:19"

class NewEvent {
  NewEvent({
    String? title,
    String? date,
    String? time,
    String? event,
    String? eventColor,
    List<Participants>? participants,
    String? ownerId,
    String? hostUser,
    List<String>? userIds,
    String? createdAt,
    String? updatedAt,
    String? lastseen,
  }) {
    _title = title;
    _date = date;
    _time = time;
    _event = event;
    _eventColor = eventColor;
    _participants = participants;
    _ownerId = ownerId;
    _hostUser = hostUser;
    _userIds = userIds;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _lastseen = lastseen;
  }

  NewEvent.fromJson(dynamic json) {
    _title = json['title'];
    _date = json['date'];
    _time = json['time'];
    _event = json['event'];
    _eventColor = json['event_color'];
    if (json['participants'] != null) {
      _participants = [];
      json['participants'].forEach((v) {
        _participants?.add(Participants.fromJson(v));
      });
    }
    _ownerId = json['ownerId'];
    _hostUser = json['hostUser'];
    _userIds = json['userIds'] != null ? json['userIds'].cast<String>() : [];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _lastseen = json['lastseen'];
  }
  String? _title;
  String? _date;
  String? _time;
  String? _event;
  String? _eventColor;
  List<Participants>? _participants;
  String? _ownerId;
  String? _hostUser;
  List<String>? _userIds;
  String? _createdAt;
  String? _updatedAt;
  String? _lastseen;
  NewEvent copyWith({
    String? title,
    String? date,
    String? time,
    String? event,
    String? eventColor,
    List<Participants>? participants,
    String? ownerId,
    String? hostUser,
    List<String>? userIds,
    String? createdAt,
    String? updatedAt,
    String? lastseen,
  }) =>
      NewEvent(
        title: title ?? _title,
        date: date ?? _date,
        time: time ?? _time,
        event: event ?? _event,
        eventColor: eventColor ?? _eventColor,
        participants: participants ?? _participants,
        ownerId: ownerId ?? _ownerId,
        hostUser: hostUser ?? _hostUser,
        userIds: userIds ?? _userIds,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        lastseen: lastseen ?? _lastseen,
      );
  String? get title => _title;
  String? get date => _date;
  String? get time => _time;
  String? get event => _event;
  String? get eventColor => _eventColor;
  List<Participants>? get participants => _participants;
  String? get ownerId => _ownerId;
  String? get hostUser => _hostUser;
  List<String>? get userIds => _userIds;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get lastseen => _lastseen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['date'] = _date;
    map['time'] = _time;
    map['event'] = _event;
    map['event_color'] = _eventColor;
    if (_participants != null) {
      map['participants'] = _participants?.map((v) => v.toJson()).toList();
    }
    map['ownerId'] = _ownerId;
    map['hostUser'] = _hostUser;
    map['userIds'] = _userIds;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['lastseen'] = _lastseen;
    return map;
  }
}

/// id : 2
/// user_type : "member"
/// firebase_uid : "CAqUB4Gxaie7pIsa78XdrfpTBCd2"
/// fcm_token : null
/// name : null
/// phone : "+970595137670"
/// age : null
/// avatar : null
/// otp : "183538"
/// contacts : "[\"+972597350412\",\"+972597450412\",\"+972597450479\"]"

class Participants {
  Participants({
    num? id,
    String? userType,
    String? firebaseUid,
    dynamic fcmToken,
    dynamic name,
    String? phone,
    dynamic age,
    dynamic avatar,
    String? otp,
    String? contacts,
  }) {
    _id = id;
    _userType = userType;
    _firebaseUid = firebaseUid;
    _fcmToken = fcmToken;
    _name = name;
    _phone = phone;
    _age = age;
    _avatar = avatar;
    _otp = otp;
    _contacts = contacts;
  }

  Participants.fromJson(dynamic json) {
    _id = json['id'];
    _userType = json['user_type'];
    _firebaseUid = json['firebase_uid'];
    _fcmToken = json['fcm_token'];
    _name = json['name'];
    _phone = json['phone'];
    _age = json['age'];
    _avatar = json['avatar'];
    _otp = json['otp'];
    _contacts = json['contacts'];
  }
  num? _id;
  String? _userType;
  String? _firebaseUid;
  dynamic _fcmToken;
  dynamic _name;
  String? _phone;
  dynamic _age;
  dynamic _avatar;
  String? _otp;
  String? _contacts;
  Participants copyWith({
    num? id,
    String? userType,
    String? firebaseUid,
    dynamic fcmToken,
    dynamic name,
    String? phone,
    dynamic age,
    dynamic avatar,
    String? otp,
    String? contacts,
  }) =>
      Participants(
        id: id ?? _id,
        userType: userType ?? _userType,
        firebaseUid: firebaseUid ?? _firebaseUid,
        fcmToken: fcmToken ?? _fcmToken,
        name: name ?? _name,
        phone: phone ?? _phone,
        age: age ?? _age,
        avatar: avatar ?? _avatar,
        otp: otp ?? _otp,
        contacts: contacts ?? _contacts,
      );
  num? get id => _id;
  String? get userType => _userType;
  String? get firebaseUid => _firebaseUid;
  dynamic get fcmToken => _fcmToken;
  dynamic get name => _name;
  String? get phone => _phone;
  dynamic get age => _age;
  dynamic get avatar => _avatar;
  String? get otp => _otp;
  String? get contacts => _contacts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_type'] = _userType;
    map['firebase_uid'] = _firebaseUid;
    map['fcm_token'] = _fcmToken;
    map['name'] = _name;
    map['phone'] = _phone;
    map['age'] = _age;
    map['avatar'] = _avatar;
    map['otp'] = _otp;
    map['contacts'] = _contacts;
    return map;
  }
}
