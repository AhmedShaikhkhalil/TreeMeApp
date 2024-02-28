/// message : "User updated successfully"
/// status : 200
/// avatar : "avatar/tMzgwxb3B9MXkNVNQgk08UeCJBdisIsOM3DsAj4E.png"
/// name : "ghgh"
/// age : "20"

class UpdateProfileModel {
  UpdateProfileModel({
      String? message, 
      num? status, 
      String? avatar, 
      String? name, 
      String? age,}){
    _message = message;
    _status = status;
    _avatar = avatar;
    _name = name;
    _age = age;
}

  UpdateProfileModel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    _avatar = json['avatar'];
    _name = json['name'];
    _age = json['age'];
  }
  String? _message;
  num? _status;
  String? _avatar;
  String? _name;
  String? _age;
UpdateProfileModel copyWith({  String? message,
  num? status,
  String? avatar,
  String? name,
  String? age,
}) => UpdateProfileModel(  message: message ?? _message,
  status: status ?? _status,
  avatar: avatar ?? _avatar,
  name: name ?? _name,
  age: age ?? _age,
);
  String? get message => _message;
  num? get status => _status;
  String? get avatar => _avatar;
  String? get name => _name;
  String? get age => _age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    map['avatar'] = _avatar;
    map['name'] = _name;
    map['age'] = _age;
    return map;
  }

}