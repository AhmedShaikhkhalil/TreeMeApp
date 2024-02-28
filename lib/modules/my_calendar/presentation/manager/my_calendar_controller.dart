import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:treeme/modules/my_calendar/data/data_sources/calendar_data_source.dart';
import 'package:treeme/modules/my_calendar/presentation/pages/my_calendar_screen.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/netwrok/failure.dart';
import '../../data/models/event_data_model.dart';

class MyCalendarController extends GetxController {
  final ICalendarDataSource _calendarDataSource;

  MyCalendarController(this._calendarDataSource);

  final rxRequestStatus = RequestStatus.LOADING.obs;

  void setRxRequestStatus(RequestStatus value) => rxRequestStatus.value = value;
  final Rx<EventDataModel> rxEventDataModel = EventDataModel().obs;

  void setRxEventDataModel(EventDataModel value) => rxEventDataModel.value = value;
  late MeetingDataSource events;
  @override
  void onInit() {
    super.onInit();
    getCalendar();

  }

  Future<void> getCalendar() async {
    setRxRequestStatus(RequestStatus.LOADING);
    final Either<Failure, EventDataModel> myHome =
        await _calendarDataSource.getCalendar();
    myHome.fold((l) {
      setRxRequestStatus(RequestStatus.ERROR);

      log(l.message.toString());
      log(l.code.toString());
      // errorToast(l.message);
    }, (r) {
      // r = _myContactModel.value;
      // r.eventData?.sort((a, b) => DateTime.parse('${a.date} ${a.time} ')
      //     .compareTo(DateTime.parse('${b.date} ${b.time} ')));
      setRxEventDataModel(r);
      setRxRequestStatus(RequestStatus.SUCESS);
      events = MeetingDataSource( getAppointmentData(r.data??[]));

      update();
    });
  }
  // List<EventData> getAppointments(EventDataModel eventDataModel) {
  //   /// Creates the required appointment subject details as a list.
  //   final List<String> subjectCollection = <String>[];
  //   // subjectCollection.add(eventDataModel.data.map((e) => e.));
  //   subjectCollection.add('Plan Execution');
  //   subjectCollection.add('Project Plan');
  //   subjectCollection.add('Consulting');
  //   subjectCollection.add('Support');
  //   subjectCollection.add('Development Meeting');
  //   subjectCollection.add('Scrum');
  //   subjectCollection.add('Project Completion');
  //   subjectCollection.add('Release updates');
  //   subjectCollection.add('Performance Check');
  //
  //   /// Creates the required appointment color details as a list.
  //   final List<Color> colorCollection = <Color>[];
  //   colorCollection.add(const Color(0xFF0F8644));
  //
  //   final List<EventData> meetings = <EventData>[];
  //   final Random random = Random();
  //   final DateTime rangeStartDate = DateTime.now().add(const Duration(days: -(365 ~/ 2)));
  //   final DateTime rangeEndDate = DateTime.now().add(const Duration(days: 365));
  //   for (DateTime i = rangeStartDate;
  //   i.isBefore(rangeEndDate);
  //   i = i.add(const Duration(days: 1))) {
  //     final DateTime date = i;
  //     final num count = 1 + random.nextInt(3);
  //     for (int j = 0; j < count; j++) {
  //       final DateTime startDate =
  //       DateTime(date.year, date.month, date.day, (8 + random.nextInt(8)).toInt());
  //       // meetings.add(EventData(
  //       //     0,
  //       //     '',
  //       //     '',
  //       //     null,
  //       //     startDate,
  //       //     startDate.add(Duration(hours: random.nextInt(3))),
  //       //     colorCollection[random.nextInt(9)],
  //       //     false,
  //       //     '',
  //       //     '',
  //       //     ''));
  //     }
  //   }
  //
  //   // added recurrence appointment
  //   // meetings.add(_Meeting(
  //   //     'Development status',
  //   //     '',
  //   //     '',
  //   //     null,
  //   //     DateTime.now(),
  //   //     DateTime.now().add(const Duration(hours: 2)),
  //   //     colorCollection[random.nextInt(9)],
  //   //     false,
  //   //     '',
  //   //     '',
  //   //     'FREQ=WEEKLY;BYDAY=FR;INTERVAL=1'));
  //   return meetings;
  // }


  List<Meeting>  getAppointmentData(List<EventData> dataEvent){

    final List<Meeting> appointmentData = [];
    for (var data in dataEvent ) {
      print(DateFormat(''));
      Meeting meetingData =Meeting(data.title??'', null, null, null, DateTime.parse("${data.date} ${data.time}"), DateTime.parse("${data.date} ${data.time}").add(Duration(hours: 3)),data.eventColor!.split(',').map((e) => HexColor.fromHex(e)).toList().first, false, null, null, null);
      appointmentData.add(meetingData);
    }
    print(appointmentData.toString());
    return appointmentData;

  }
}
