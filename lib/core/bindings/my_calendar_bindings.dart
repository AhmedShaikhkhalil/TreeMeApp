import 'package:get/get.dart';
import 'package:treeme/modules/my_calendar/data/data_sources/calendar_data_source.dart';
import 'package:treeme/modules/my_calendar/presentation/manager/my_calendar_controller.dart';

import '../netwrok/web_connection.dart';
import '../utils/connectivity_check/i_connectivity_checker.dart';

class MyCalendarBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ICalendarDataSource>(
      () => CalendarDataSource(
          Get.find<WebServiceConnections>(), Get.find<IConnectivityChecker>()),
    );
    Get.lazyPut(() => MyCalendarController(Get.find<ICalendarDataSource>()));
  }
}
