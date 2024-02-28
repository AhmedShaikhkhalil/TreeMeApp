/// message : "All events here"
/// data : [{"id":1,"name":"BIRTHDAY","description":"brbr","image":"images/GINP1DwAzRdZc2admIo00oMqO0m8i4kDI0d29tqL.jpg","created_at":"2023-07-24T11:05:04.000000Z","updated_at":"2023-07-24T11:05:04.000000Z","colors":"#ff0080,#ff64b1"}]
/// status : 200

class EventTypeModel {
  EventTypeModel({
    String? message,
    List<EventType>? data,
    num? status,
  }) {
    _message = message;
    _data = data;
    _status = status;
  }

  EventTypeModel.fromJson(dynamic json) {
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(EventType.fromJson(v));
      });
    }
    _status = json['status'];
  }
  String? _message;
  List<EventType>? _data;
  num? _status;
  EventTypeModel copyWith({
    String? message,
    List<EventType>? data,
    num? status,
  }) =>
      EventTypeModel(
        message: message ?? _message,
        data: data ?? _data,
        status: status ?? _status,
      );
  String? get message => _message;
  List<EventType>? get data => _data;
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
/// name : "BIRTHDAY"
/// description : "brbr"
/// image : "images/GINP1DwAzRdZc2admIo00oMqO0m8i4kDI0d29tqL.jpg"
/// created_at : "2023-07-24T11:05:04.000000Z"
/// updated_at : "2023-07-24T11:05:04.000000Z"
/// colors : "#ff0080,#ff64b1"

class EventType {
  EventType({
    num? id,
    String? name,
    String? description,
    String? image,
    String? createdAt,
    String? updatedAt,
    String? colors,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _colors = colors;
  }

  EventType.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _colors = json['colors'];
  }
  num? _id;
  String? _name;
  String? _description;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  String? _colors;
  EventType copyWith({
    num? id,
    String? name,
    String? description,
    String? image,
    String? createdAt,
    String? updatedAt,
    String? colors,
  }) =>
      EventType(
        id: id ?? _id,
        name: name ?? _name,
        description: description ?? _description,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        colors: colors ?? _colors,
      );
  num? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get colors => _colors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['colors'] = _colors;
    return map;
  }
}
