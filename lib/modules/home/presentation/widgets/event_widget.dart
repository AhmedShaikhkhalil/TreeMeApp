import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:treeme/core/config/apis/config_api.dart';
import 'package:treeme/core/helpers/date_format_extensions.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../data/models/home_model.dart';
import 'avatar_widget.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    required this.cardBTH,
  });

  final EventData cardBTH;

  @override
  Widget build(BuildContext context) {
    print(cardBTH.eventColor!.split('"').toString());
    return Container(
      // height: 135.h,
      // width: 151.w,
      margin: EdgeInsets.only(
        left: AppSize.s8.w,
        right: AppSize.s8.w,
      ),
      // constraints: BoxConstraints(minHeight: 135),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: cardBTH.eventColor == null
                ? [Color(0xff8271F2), Color(0xffA99EFF)]
                : cardBTH.eventColor!.split(',').map((e) => HexColor.fromHex(e)).toList(),
            tileMode: TileMode.decal,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
                color: cardBTH.eventColor == null
                    ? Color(0xff8271F2)
                    : cardBTH.eventColor!
                        .split(',')
                        .map((e) => HexColor.fromHex(e))
                        .toList()
                        .first
                        .withOpacity(0.3),
                offset: const Offset(0, 6),
                blurRadius: 12,
                spreadRadius: 0)
          ],
          borderRadius: BorderRadius.circular(AppSize.s24.r)),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              ImageAssets.intersectIcon,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: AppSize.s16.h,
                bottom: AppSize.s16.h,
                left: AppSize.s14.w,
                right: AppSize.s9.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 39.w,
                        height: 39.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppSize.s10.r)),
                        child: Image.network(
                          API.imageUrl(cardBTH.eventImage ?? ''),
                          width: AppSize.s24.w,
                          height: AppSize.s24.h,
                        ),
                      ),
                      SizedBox(
                        width: 28.w,
                      ),
                      // Spacer(),
                      Text(
                        DateFormatTimeToString(
                                DateTime.parse('1970-01-01 ${cardBTH.time}'))
                            .formatDateToString(),
                        style: getBoldStyle(
                            color: ColorManager.white, fontSize: FontSize.s12.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppSize.s9.h,
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    '${cardBTH.title}',
                    style: getBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s14.sp),
                  ),
                ),
                SizedBox(
                  height: AppSize.s8.h,
                ),
                AvatarWidget(avatar: cardBTH.avatars,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
