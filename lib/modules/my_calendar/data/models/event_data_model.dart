/// message : "user events"
/// data : [{"id":1,"document_id":"e7140f2bf1c142839214","title":"birthdaaaaaay","time":"15:07:00","date":"2023-06-19","event_color":"#ff0080,#ff64b1","event_image":"images/GINP1DwAzRdZc2admIo00oMqO0m8i4kDI0d29tqL.jpg","avatars":[{"id":1,"avatar":null},{"id":2,"avatar":null},{"id":3,"avatar":null},{"id":4,"avatar":null}]},{"id":2,"document_id":"4a55d8418d354b669c61","title":"mmoh","time":"18:52:00","date":"2023-07-20","event_color":"#ff0080,#ff64b1","event_image":"images/GINP1DwAzRdZc2admIo00oMqO0m8i4kDI0d29tqL.jpg","avatars":[{"id":1,"avatar":null},{"id":2,"avatar":null},{"id":3,"avatar":null}]},{"id":3,"document_id":"ab5206eb7fc24910975f","title":"test evenr","time":"19:32:00","date":"2023-07-12","event_color":"#ff0080,#ff64b1","event_image":"images/GINP1DwAzRdZc2admIo00oMqO0m8i4kDI0d29tqL.jpg","avatars":[{"id":1,"avatar":null},{"id":2,"avatar":null},{"id":3,"avatar":null}]},{"id":4,"document_id":"1567264e95c84966abc9","title":"hhgg","time":"15:46:00","date":"2023-07-26","event_color":"#A99EFF,#8271F2","event_image":"images/SJ92NpDWXJiAFVr7YmvtI3Ijm2x0SEu8nzTcI4TV.png","avatars":[{"id":1,"avatar":null},{"id":3,"avatar":null},{"id":5,"avatar":null}]},{"id":5,"document_id":"8c7fcf2ae6c9435fa7b9","title":"ytewjb","time":"15:07:00","date":"2023-06-19","event_color":"#ff0080,#ff64b1","event_image":"images/GINP1DwAzRdZc2admIo00oMqO0m8i4kDI0d29tqL.jpg","avatars":[{"id":2,"avatar":null},{"id":3,"avatar":null},{"id":4,"avatar":null}]},{"id":6,"document_id":"124d7ffcb33d48c59794","title":"ytewjb","time":"15:07:00","date":"2023-06-19","event_color":"#ff0080,#ff64b1","event_image":"images/GINP1DwAzRdZc2admIo00oMqO0m8i4kDI0d29tqL.jpg","avatars":[{"id":2,"avatar":null},{"id":3,"avatar":null},{"id":4,"avatar":null}]},{"id":7,"document_id":"5a665d2b1b9f4899b48d","title":"hi","time":"23:06:00","date":"2023-07-27","event_color":"#FBD4A4,#FEAA46","event_image":"images/dvxG8JjzTxz7EaES7aEbvERLk4U5VGUPS8q1PCMv.png","avatars":[{"id":2,"avatar":null},{"id":3,"avatar":null},{"id":5,"avatar":null}]},{"id":8,"document_id":"56906a6c1f5d4fd293ae","title":"nmkiu","time":"23:13:00","date":"2023-07-28","event_color":"#FB84A7,#EA4477","event_image":"images/9ZUQ4ATdMv8F27b3JYSIQbyIWxE9buHKA1bzJgFH.png","avatars":[{"id":1,"avatar":null},{"id":3,"avatar":null},{"id":5,"avatar":null}]}]
/// status : 200

class EventDataModel {
  EventDataModel({
    String? message,
    List<EventData>? data,
    num? status,
  }) {
    _message = message;
    _data = data;
    _status = status;
  }

  EventDataModel.fromJson(dynamic json) {
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(EventData.fromJson(v));
      });
    }
    _status = json['status'];
  }
  String? _message;
  List<EventData>? _data;
  num? _status;
  EventDataModel copyWith({
    String? message,
    List<EventData>? data,
    num? status,
  }) =>
      EventDataModel(
        message: message ?? _message,
        data: data ?? _data,
        status: status ?? _status,
      );
  String? get message => _message;
  List<EventData>? get data => _data;
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
/// document_id : "e7140f2bf1c142839214"
/// title : "birthdaaaaaay"
/// time : "15:07:00"
/// date : "2023-06-19"
/// event_color : "#ff0080,#ff64b1"
/// event_image : "images/GINP1DwAzRdZc2admIo00oMqO0m8i4kDI0d29tqL.jpg"
/// avatars : [{"id":1,"avatar":null},{"id":2,"avatar":null},{"id":3,"avatar":null},{"id":4,"avatar":null}]

class EventData {
  EventData({
    num? id,
    String? documentId,
    String? title,
    String? time,
    String? date,
    String? eventColor,
    String? eventImage,
    List<Avatars>? avatars,
  }) {
    _id = id;
    _documentId = documentId;
    _title = title;
    _time = time;
    _date = date;
    _eventColor = eventColor;
    _eventImage = eventImage;
    _avatars = avatars;
  }

  EventData.fromJson(dynamic json) {
    _id = json['id'];
    _documentId = json['document_id'];
    _title = json['title'];
    _time = json['time'];
    _date = json['date'];
    _eventColor = json['event_color'];
    _eventImage = json['event_image'];
    if (json['avatars'] != null) {
      _avatars = [];
      json['avatars'].forEach((v) {
        _avatars?.add(Avatars.fromJson(v));
      });
    }
  }
  num? _id;
  String? _documentId;
  String? _title;
  String? _time;
  String? _date;
  String? _eventColor;
  String? _eventImage;
  List<Avatars>? _avatars;
  EventData copyWith({
    num? id,
    String? documentId,
    String? title,
    String? time,
    String? date,
    String? eventColor,
    String? eventImage,
    List<Avatars>? avatars,
  }) =>
      EventData(
        id: id ?? _id,
        documentId: documentId ?? _documentId,
        title: title ?? _title,
        time: time ?? _time,
        date: date ?? _date,
        eventColor: eventColor ?? _eventColor,
        eventImage: eventImage ?? _eventImage,
        avatars: avatars ?? _avatars,
      );
  num? get id => _id;
  String? get documentId => _documentId;
  String? get title => _title;
  String? get time => _time;
  String? get date => _date;
  String? get eventColor => _eventColor;
  String? get eventImage => _eventImage;
  List<Avatars>? get avatars => _avatars;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['document_id'] = _documentId;
    map['title'] = _title;
    map['time'] = _time;
    map['date'] = _date;
    map['event_color'] = _eventColor;
    map['event_image'] = _eventImage;
    if (_avatars != null) {
      map['avatars'] = _avatars?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// avatar : null

class Avatars {
  Avatars({
    num? id,
    dynamic avatar,
  }) {
    _id = id;
    _avatar = avatar;
  }

  Avatars.fromJson(dynamic json) {
    _id = json['id'];
    _avatar = json['avatar'];
  }
  num? _id;
  dynamic _avatar;
  Avatars copyWith({
    num? id,
    dynamic avatar,
  }) =>
      Avatars(
        id: id ?? _id,
        avatar: avatar ?? _avatar,
      );
  num? get id => _id;
  dynamic get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['avatar'] = _avatar;
    return map;
  }
}
