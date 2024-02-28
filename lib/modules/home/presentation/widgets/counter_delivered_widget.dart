import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/resource.dart';
import '../../data/models/stream_model.dart';

class CounterNumberWidget extends StatefulWidget {
  const CounterNumberWidget({super.key, required this.data});
 final  Stream<QuerySnapshot<Map<String, dynamic>>> data ;
  @override
  _CounterNumberWidgetState createState() => _CounterNumberWidgetState();
}

class _CounterNumberWidgetState extends State<CounterNumberWidget> {
  final YourStreamService _streamService = YourStreamService();

  @override
  void initState() {
    super.initState();
    _streamService.startListeningToDeliveredCount(widget.data);
  }

  @override
  void dispose() {
    _streamService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _streamService.deliveredCountStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        int deliveredCount = snapshot.data!;

        return deliveredCount==0 ?SizedBox(): Container(
          // height: AppSize.s16.h,
          //
          // width: AppSize.s16.w,
          padding: EdgeInsets.all(5),
          decoration: const BoxDecoration(
              shape:
              BoxShape.circle,
              gradient: LinearGradient(
                  colors: [
                    Color(
                        0xffEA4477),
                    Color(
                        0xffFB84A7)
                  ],
                  tileMode: TileMode
                      .clamp,
                  begin: Alignment
                      .bottomRight,
                  stops: [0.0, 1.0],
                  end: Alignment
                      .topLeft)),
          child: Text(
            '${deliveredCount}',
            style: getBoldStyle(
                color: ColorManager
                    .white,
                fontSize: FontSize
                    .s12.sp),
          ),
        );
      },
    );
  }
}
