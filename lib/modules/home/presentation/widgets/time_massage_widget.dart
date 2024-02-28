import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:treeme/core/helpers/date_format_extensions.dart';

import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../data/models/stream_model.dart';
class TimeMassageWidget extends StatefulWidget {
  const TimeMassageWidget({super.key, required this.data});
  final  Stream<QuerySnapshot<Map<String, dynamic>>> data ;

  @override
  _TimeMassageWidgetState createState() => _TimeMassageWidgetState();
}

class _TimeMassageWidgetState extends State<TimeMassageWidget> {
  final DateStreamService _streamService = DateStreamService();

  @override
  void initState() {
    super.initState();
    _streamService.startListeningToUpdatedAt(widget.data);
  }

  @override
  void dispose() {
    _streamService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: _streamService.updatedAtStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        DateTime latestUpdatedAt = snapshot.data!;

        return  Text(
          DateFormatTimeToString(latestUpdatedAt
          ).formatDateToString(),
          style: getBoldStyle(
              color: Color(0xffC3C2C9),
              fontSize: FontSize.s12.sp),
        );
      },
    );
  }
}
