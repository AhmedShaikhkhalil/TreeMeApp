import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:treeme/core/resources/assets_manager.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/resources/font_manager.dart';
import 'package:treeme/core/resources/styles_manager.dart';
import 'package:treeme/core/resources/values_manager.dart';
import 'package:treeme/modules/profile/presentation/manager/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (logic) {
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
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                actions: [
                  Container(
                    // height: AppSize.s20.h,
                    margin: EdgeInsets.only(right: AppSize.s12.w),
                    // width: 40.w,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.s15.w, vertical: AppSize.s11.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12.r),
                        // color: ColorManager.white,
                        border: Border.all(
                            color: ColorManager.white.withOpacity(0.29),
                            width: AppSize.s1.w),
                        gradient: LinearGradient(
                            colors: [
                              ColorManager.white.withOpacity(0.13),
                              ColorManager.white.withOpacity(0.51),
                            ],
                            tileMode: TileMode.decal,
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft),
                        boxShadow: [
                          BoxShadow(
                              color: ColorManager.black.withOpacity(0.03),
                              offset: Offset(0, 7),
                              blurRadius: 10)
                        ]),
                    child: Icon(Icons.more_horiz),
                  )
                ],
                leadingWidth: 70,
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    // height: AppSize.s20.h,
                    margin: EdgeInsets.only(left: AppSize.s12.w),
                    width: 40.w,
                    padding: EdgeInsets.symmetric(
                        vertical: AppSize.s10.h, horizontal: AppSize.s10.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12.r),
                        // color: ColorManager.white,
                        border: Border.all(
                            color: ColorManager.white.withOpacity(0.29),
                            width: AppSize.s1.w),
                        gradient: LinearGradient(
                            colors: [
                              ColorManager.white.withOpacity(0.13),
                              ColorManager.white.withOpacity(0.51),
                            ],
                            tileMode: TileMode.decal,
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft),
                        boxShadow: [
                          BoxShadow(
                              color: ColorManager.black.withOpacity(0.03),
                              offset: Offset(0, 7),
                              blurRadius: 10)
                        ]),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 145.h,
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
                        'Mohammed Ali',
                        style: getBoldStyle(
                            color: ColorManager.goodMorning, fontSize: FontSize.s20.sp),
                      ),
                      SizedBox(
                        height: AppSize.s9.h,
                      ),
                      Text(
                        '@mohammedAli',
                        style: getBoldStyle(
                            color: ColorManager.subTitleCreateEvent,
                            fontSize: FontSize.s16.sp),
                      ),
                      SizedBox(
                        height: AppSize.s24.h,
                      ),
                      Expanded(
                          flex: 1,
                          child: ListView.builder(
                            itemCount: logic.list.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 107.w,
                                height: 78.h,
                                margin: EdgeInsets.symmetric(horizontal: AppSize.s6.w),
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [Color(0xffFBD4A4), Color(0xffFEAA46)],
                                        end: Alignment.topCenter,
                                        begin: Alignment.bottomCenter,
                                        tileMode: TileMode.decal),
                                    borderRadius: BorderRadius.circular(AppSize.s14.r)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      logic.list[index].icon ?? '',
                                      color: ColorManager.white,
                                    ),
                                    SizedBox(
                                      height: AppSize.s9.h,
                                    ),
                                    Text(
                                      logic.list[index].title ?? '',
                                      style: getSemiBoldStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSize.s12.sp),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                      SizedBox(height: AppSize.s40.h),
                      TabBar(
                        tabs: logic.tabs,
                        controller: logic.tabController,
                        labelStyle: getBoldStyle(
                            color: ColorManager.goodMorning, fontSize: FontSize.s16.sp),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: ColorManager.goodMorning,
                        indicatorWeight: AppSize.s2.h,
                        labelColor: ColorManager.goodMorning,
                        unselectedLabelColor: ColorManager.subTitleCreateEvent,
                        unselectedLabelStyle: getRegularStyle(
                            color: ColorManager.subTitleCreateEvent,
                            fontSize: FontSize.s16.sp),
                      ),
                      Expanded(
                          flex: 4,
                          child: TabBarView(
                            controller: logic.tabController,
                            children: [
                              GridView.builder(
                                itemCount: 15,
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 117.w / 117.h,
                                    crossAxisSpacing: AppSize.s11.w,
                                    mainAxisSpacing: AppSize.s11.h),
                                itemBuilder: (BuildContext context, int index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(AppSize.s23.r),
                                    child: Image.asset(ImageAssets.character),
                                  );
                                },
                              ),

                              // GridView.builder(
                              //   itemCount: logic.eventList.length,
                              //   shrinkWrap: true,
                              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2,
                              //       childAspectRatio: 174.w/ 140.h,
                              //
                              //   crossAxisSpacing: AppSize.s11.w,
                              //     mainAxisSpacing: AppSize.s12.h
                              //   ),
                              //
                              //
                              //   itemBuilder: (BuildContext context, int index) {
                              //     return EventWidget(
                              //       cardBTH: logic.eventList[index],
                              //     );
                              //   },),
                            ],
                          ))
                    ],
                  ),
                )),
            Positioned(
                top: 88.h,
                right: 142.w,
                child: Container(
                  height: 110.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                      border: Border.all(
                          color: ColorManager.white,
                          width: AppSize.s2.w,
                          strokeAlign: BorderSide.strokeAlignOutside)),
                ))
          ],
        );
      }),
    );
  }
}
