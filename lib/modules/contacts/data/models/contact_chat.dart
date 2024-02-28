/// document_id : "fafe7c23f60a459aada7"
/// firebase_uid : "iFLF7ybiX8TR5N8MuPKufOMX29P2"
/// status : 200

class ContactChat {
  ContactChat({
      String? documentId, 
      String? firebaseUid, 
      num? status,}){
    _documentId = documentId;
    _firebaseUid = firebaseUid;
    _status = status;
}

  ContactChat.fromJson(dynamic json) {
    _documentId = json['document_id'];
    _firebaseUid = json['firebase_uid'];
    _status = json['status'];
  }
  String? _documentId;
  String? _firebaseUid;
  num? _status;
ContactChat copyWith({  String? documentId,
  String? firebaseUid,
  num? status,
}) => ContactChat(  documentId: documentId ?? _documentId,
  firebaseUid: firebaseUid ?? _firebaseUid,
  status: status ?? _status,
);
  String? get documentId => _documentId;
  String? get firebaseUid => _firebaseUid;
  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['document_id'] = _documentId;
    map['firebase_uid'] = _firebaseUid;
    map['status'] = _status;
    return map;
  }

}