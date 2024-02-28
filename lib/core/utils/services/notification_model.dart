import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  int id;
  String title;
  String body;
  String date;

  NotificationModel(
      {required this.id, required this.title, required this.body, required this.date});

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, body, date];
  factory NotificationModel.fromJson(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      date: map['date'],
    );
  }
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "body": body,
        "date": date,
      };

  @override
  String toString() {
    return 'NotificationModel{id: $id, title: $title, body: $body, date: $date}';
  }
}
