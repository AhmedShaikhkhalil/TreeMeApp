import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:treeme/core/config/apis/config_api.dart';
import 'package:treeme/core/helpers/constants.dart';
import 'package:treeme/modules/create_event/data/models/event_type_model.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';

class TypeThemeWidgets extends StatelessWidget {
  final EventType eventTypeModel;
  const TypeThemeWidgets({
    super.key,
    required this.eventTypeModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s120.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s27.r),
          gradient: LinearGradient(
            colors: eventTypeModel.colors == null
                ? [Color(0xff8271F2), Color(0xffA99EFF)]
                : eventTypeModel.colors!
                    .split(',')
                    .map((e) => HexColor.fromHex(e))
                    .toList(),
            tileMode: TileMode.decal,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
      margin: EdgeInsets.symmetric(
          horizontal: AppSize.s12.w, vertical: AppSize.s8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  top: AppSize.s30.h,
                  left: AppSize.s30.w,
                  bottom: AppSize.s14.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventTypeModel.name ?? '',
                    style: getBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s20.sp),
                  ),
                  RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(
                            text: eventTypeModel.description ?? '',
                            style: getMediumStyle(
                                color: ColorManager.chatBackGround,
                                fontSize: FontSize.s12.sp),
                            children: [
                              WidgetSpan(
                                  child: Lottie.network(
                                      'https://fonts.gstatic.com/s/e/notoemoji/latest/1f609/lottie.json',
                                      height: AppSize.s15.h,
                                      width: AppSize.s15.w))
                            ])
                      ])),
                ],
              ),
            ),
          ),
          CachedNetworkImage(
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/7/70/Example.png',
            // imageUrl: API.imageUrl(eventTypeModel.image ?? ''),
            width: 100,
          ),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
    );
  }
}
