import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:treeme/core/config/apis/config_api.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../data/models/home_model.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key, this.avatar}) : super(key: key);
  final List<Avatars>? avatar;
  @override
  Widget build(BuildContext context) {
    final settings = RestrictedAmountPositions(
        maxAmountItems: 4,
        maxCoverage: 0.3,
        minCoverage: 0.2,
        align: StackAlign.left,
        laying: StackLaying.first);
    List RandomImages = [
      'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg',
      'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg',
      'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg',
      'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
      'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
      'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
      'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
      'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
    ];
    return AvatarStack(
      height: AppSize.s24.h,
      width: 100,
      borderWidth: AppSize.s1.w,
      borderColor: ColorManager.white,
      settings: settings,
      avatars: [
        for (var n = 0; n < avatar!.length; n++)
          CachedNetworkImageProvider(
            avatar?[n].avatar != null ?  '${API.baseImageUrl}${avatar?[n].avatar}' : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
            // errorListener: () {},
          )
      ],
      infoWidgetBuilder: (surplus) => _infoWidget(surplus, context),
    );
  }

  String getAvatarUrl(int n) {
    final url = 'https://i.pravatar.cc/150?img=$n';
    // final url = 'https://robohash.org/$n?bgset=bg1';
    return url;
  }

  Widget _infoWidget(int surplus, BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xffFEAA46), Color(0xffFBD4A4)],
              tileMode: TileMode.clamp,
              begin: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              end: Alignment.topCenter),
          borderRadius: BorderRadius.circular(AppSize.s50.r),
          border: Border.all(color: ColorManager.white, width: AppSize.s1.w)),
      child: Text(
        '+${surplus}',
        style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s12.sp),
      ),
    );
  }
}
