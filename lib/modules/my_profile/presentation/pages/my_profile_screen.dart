import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:treeme/core/config/apis/config_api.dart';
import 'package:treeme/core/helpers/constants.dart';
import 'package:treeme/core/resources/assets_manager.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/resources/font_manager.dart';
import 'package:treeme/core/resources/styles_manager.dart';
import 'package:treeme/core/resources/values_manager.dart';
import 'package:treeme/core/utils/services/storage.dart';
import 'package:treeme/modules/my_profile/presentation/manager/my_profile_controller.dart';

import '../../../../core/utils/svg_provider.dart';

class MyProfileScreen extends GetView<MyProfileController> {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: AppSize.s286.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffFBD4A4), Color(0xffFEAA46)],
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    tileMode: TileMode.decal),
              ),
              alignment: Alignment.topRight,
              child: SvgPicture.asset(ImageAssets.intersectCorner),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    'My Profile',
                    style: getBoldStyle(
                        color: ColorManager.chatBackGround, fontSize: FontSize.s16.sp),
                  ),
                  leading: SizedBox(),
                  // actions: [
                  //   Container(
                  //     // height: AppSize.s20.h,
                  //     margin: EdgeInsets.only(right: AppSize.s12.w),
                  //     // width: 40.w,
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: AppSize.s15.w, vertical: AppSize.s11.h),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(AppSize.s12.r),
                  //         // color: ColorManager.white,
                  //         border: Border.all(
                  //             color: ColorManager.white.withOpacity(0.29),
                  //             width: AppSize.s1.w),
                  //         gradient: LinearGradient(
                  //             colors: [
                  //               ColorManager.white.withOpacity(0.13),
                  //               ColorManager.white.withOpacity(0.51),
                  //             ],
                  //             tileMode: TileMode.decal,
                  //             begin: Alignment.bottomRight,
                  //             end: Alignment.topLeft),
                  //         boxShadow: [
                  //           BoxShadow(
                  //               color: ColorManager.black.withOpacity(0.03),
                  //               offset: Offset(0, 7),
                  //               blurRadius: 10)
                  //         ]),
                  //     child: SvgPicture.asset(ImageAssets.notificationIcon,
                  //         color: ColorManager.white),
                  //   )
                  // ],
                  // leadingWidth: 70,
                  // leading: Container(
                  //   // height: AppSize.s20.h,
                  //   margin: EdgeInsets.only(left: AppSize.s12.w),
                  //   width: 40.w,
                  //   padding: EdgeInsets.symmetric(
                  //       vertical: AppSize.s10.h, horizontal: AppSize.s10.w),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(AppSize.s12.r),
                  //       // color: ColorManager.white,
                  //       border: Border.all(
                  //           color: ColorManager.white.withOpacity(0.29),
                  //           width: AppSize.s1.w),
                  //       gradient: LinearGradient(
                  //           colors: [
                  //             ColorManager.white.withOpacity(0.13),
                  //             ColorManager.white.withOpacity(0.51),
                  //           ],
                  //           tileMode: TileMode.decal,
                  //           begin: Alignment.bottomRight,
                  //           end: Alignment.topLeft),
                  //       boxShadow: [
                  //         BoxShadow(
                  //             color: ColorManager.black.withOpacity(0.03),
                  //             offset: Offset(0, 7),
                  //             blurRadius: 10)
                  //       ]),
                  //   child: SvgPicture.asset(
                  //     ImageAssets.qrIcon,
                  //     color: ColorManager.white,
                  //     height: AppSize.s20.h,
                  //     width: AppSize.s20.w,
                  //   ),
                  // ),
                ),
              ),
            ),
            Positioned(
                top: 196.h,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(top: AppSize.s80.h),
                  decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(AppSize.s36.r),
                          right: Radius.circular(AppSize.s36.r))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${AppConfig.firstName}',
                        style: getBoldStyle(
                            color: ColorManager.goodMorning, fontSize: FontSize.s20.sp),
                      ),
                      SizedBox(
                        height: AppSize.s9.h,
                      ),
                      Text(
                        '${AppConfig.phoneNumber}',
                        style: getBoldStyle(
                            color: ColorManager.subTitleCreateEvent,
                            fontSize: FontSize.s16.sp),
                      ),
                      SizedBox(
                        height: AppSize.s24.h,
                      ),
                      Divider(
                        height: AppSize.s1.h,
                        color: ColorManager.chatBackGround,
                        thickness: 1,
                      ),
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                                left: AppSize.s32.w,
                                right: AppSize.s32.w,
                                top: AppSize.s24.h),
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: controller.listProfile[index].onTap,
                                leading: controller.listProfile[index].icon,
                                title: Text(
                                  controller.listProfile[index].title ?? '',
                                  style: getBoldStyle(
                                      color: ColorManager.goodMorning,
                                      fontSize: FontSize.s16.sp),
                                ),
                                trailing: controller.listProfile[index].trailing,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: AppSize.s1.h,
                                color: ColorManager.chatBackGround,
                                thickness: AppSize.s1.h,
                              );
                            },
                            itemCount: controller.listProfile.length),
                      ),
                    ],
                  ),
                )),
            Positioned(
              top: 135.h,
              right: 137.w,
              child: Container(
                height: 110.h,
                width: 110.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: ColorManager().gradientFloating,
                    border: Border.all(
                        color: ColorManager.white,
                        width: AppSize.s2.w,
                        strokeAlign: BorderSide.strokeAlignOutside),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AppConfig.avatar != null || Storage().avatar != null
                            ? CachedNetworkImageProvider(API.imageUrl(AppConfig.avatar ??
                                Storage().avatar ??
                                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.businessnetworks.com%2Fimage%2Fdefault-avatarpng&psig=AOvVaw3u97diAqPZhe1_v73AuGm_&ust=1690873615751000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCOjKsJuxuIADFQAAAAAdAAAAABAH'))
                            : const Image(image: SvgProvider(ImageAssets.splashLogo))
                                .image)),
                // child: GestureDetector(
                //     onTap: () {
                //       controller.pickImageDriverLicence();
                //     },
                //     child: controller.havePickImage == true
                //         ? Image.file(
                //             File(controller.filePickImage!.path),
                //             fit: BoxFit.contain,
                //           )
                //         : SvgPicture.asset(ImageAssets.splashLogo)),
              ),
            )
          ],
        );
      }),
    );
  }
}
