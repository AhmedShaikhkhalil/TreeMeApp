import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:treeme/core/helpers/show_bottom_sheet/show_bottom_sheet_impl.dart';
import 'package:treeme/core/helpers/show_bottom_sheet/show_bottom_sheet_input.dart';
import 'package:treeme/core/resources/assets_manager.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/resources/font_manager.dart';
import 'package:treeme/core/resources/styles_manager.dart';
import 'package:treeme/core/resources/values_manager.dart';
import 'package:treeme/core/routes/app_routes.dart';
import 'package:treeme/modules/contacts/presentation/manager/my_contact_controller.dart';

import '../../../../core/config/apis/config_api.dart';
import '../../../../core/helpers/constants.dart';
import '../../data/models/my_contact_model.dart';

class ContactsScreen extends GetView<MyContactController> {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => controller.getMyContact(),
            child: CustomScrollView(
              clipBehavior: Clip.none,
              slivers: [
                SliverAppBar(
                    expandedHeight: AppSize.s130.h,
                    backgroundColor: ColorManager.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppSize.s36.r),
                          bottomRight: Radius.circular(AppSize.s36.r)),
                    ),
                    elevation: 4,
                    // toolbarHeight: 40.h,
                    actions: [
                      GestureDetector(
                        onTap: () {
                          // Get.find<HomeController>().prepreContact();
                          controller.getMyContact();
                        },
                        child: Container(
                            // height: AppSize.s20.h,
                            margin: EdgeInsets.only(right: AppSize.s24.w),
                            width: 50.w,
                            padding: EdgeInsets.all(AppSize.s15.h),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s12.r),
                                // color: ColorManager.white,
                                // border: Border.all(
                                //     color: ColorManager.white.withOpacity(0.29),
                                //     width: AppSize.s1.w),
                                gradient: LinearGradient(
                                    colors: [
                                      ColorManager.white.withOpacity(0.11),
                                      ColorManager.white,
                                    ],
                                    tileMode: TileMode.decal,
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xff16434D).withAlpha(10),
                                      offset: Offset(0, 3),
                                      blurRadius: 13)
                                ]),
                            child: Icon(
                              Icons.refresh,
                              color: Colors.black,
                            )),
                      )
                    ],
                    centerTitle: true,
                    title: Text(
                      'My Contacts',
                      style: getBoldStyle(
                          color: ColorManager.goodMorning,
                          fontSize: FontSize.s16.sp),
                    ),
                    flexibleSpace: Container(
                      height: 56.h,
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(
                          left: AppSize.s30.w,
                          right: AppSize.s30.w,
                          top: AppSize.s100.h,
                          bottom: AppSize.s20.h),
                      decoration: BoxDecoration(
                          color: ColorManager.chatBackGround,
                          borderRadius: BorderRadius.circular(AppSize.s10.r)),
                      child: TextField(
                        controller: controller.searchController,
                        onChanged: (value) {
                          controller.searchContact(value);
                        },
                        onSubmitted: (value) {
                          controller.searchContact(value);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: AppSize.s16.w,
                                top: AppSize.s20.h,
                                right: AppSize.s12.w,
                                bottom: AppSize.s10.h),
                            fillColor: ColorManager.chatBackGround,
                            hintStyle: getRegularStyle(
                                color: ColorManager.hintColor,
                                fontSize: FontSize.s16.sp),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            // suffix: suffix,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                ImageAssets.iconSearch,
                                height: AppSize.s16.h,
                                color: ColorManager.subTitleCreateEvent,
                                width: AppSize.s16.w,
                              ),
                            ),
                            hintText: 'Search here'),
                      ),
                    ),
                    pinned: false,
                    snap: true,
                    floating: true),
                SliverFillRemaining(
                  hasScrollBody: true,
                  // fillOverscroll: true,
                  child: Obx(() {
                    if (controller.isTyping.value == true) {
                      switch (controller.rxRequestStatusSearch.value) {
                        case RequestStatus.LOADING:
                          return Center(
                            child: CircularProgressIndicator.adaptive(),
                          );

                        case RequestStatus.SUCESS:
                          return ListView.builder(
                            itemCount: controller
                                    .rxMySearchContact.value.data?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: AppSize.s30.w,
                                    vertical: AppSize.s5.h),
                                child: ListTile(
                                  onTap: () {
                                    if (controller.rxMySearchContact.value
                                            .data?[index] !=
                                        null) {
                                      ShowBottomSheetHelperImpl()
                                          .showBottomSheet(
                                              ShowBottomSheetInput(Container(
                                        height: 300,
                                        padding: EdgeInsets.all(AppSize.s20.h),
                                        decoration: BoxDecoration(
                                          color: ColorManager.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15.r),
                                              topRight: Radius.circular(15.r)),
                                        ),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                                radius: AppSize.s32,
                                                foregroundImage:
                                                    CachedNetworkImageProvider(controller
                                                                .rxMySearchContact
                                                                .value
                                                                .data?[index]
                                                                .avatar ==
                                                            null
                                                        ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                                                        : API.imageUrl(controller
                                                            .rxMySearchContact
                                                            .value
                                                            .data?[index]
                                                            .avatar))),
                                            SizedBox(
                                              height: AppSize.s15.h,
                                            ),
                                            Text(
                                              '${controller.rxMySearchContact.value.data?[index]?.name ?? controller.rxMySearchContact.value.data?[index].phone}',
                                              style: getBoldStyle(
                                                  color:
                                                      ColorManager.goodMorning,
                                                  fontSize: FontSize.s16.sp),
                                            ),
                                            SizedBox(
                                              height: AppSize.s15.h,
                                            ),
                                            Text(
                                              '${controller.rxMySearchContact.value.data?[index].phone ?? ''}',
                                              style: getBoldStyle(
                                                  color:
                                                      ColorManager.goodMorning,
                                                  fontSize: FontSize.s16.sp),
                                            ),
                                            SizedBox(
                                              height: AppSize.s15.h,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.sendMessage(
                                                    controller
                                                            .rxMySearchContact
                                                            .value
                                                            .data?[index]
                                                            ?.id
                                                            .toString() ??
                                                        '',
                                                    controller
                                                            .rxMySearchContact
                                                            .value
                                                            .data?[index]
                                                            .avatar ??
                                                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
                                              },
                                              child: Container(
                                                width: 107.w,
                                                height: 78.h,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: AppSize.s6.w),
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                            colors: [
                                                          Color(0xffFBD4A4),
                                                          Color(0xffFEAA46)
                                                        ],
                                                            end: Alignment
                                                                .topCenter,
                                                            begin: Alignment
                                                                .bottomCenter,
                                                            tileMode:
                                                                TileMode.decal),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s14.r)),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      ImageAssets.messageIcon,
                                                      color: ColorManager.white,
                                                    ),
                                                    SizedBox(
                                                      height: AppSize.s9.h,
                                                    ),
                                                    Text(
                                                      'Message',
                                                      style: getSemiBoldStyle(
                                                          color: ColorManager
                                                              .white,
                                                          fontSize:
                                                              FontSize.s12.sp),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )));
                                    }
                                  },
                                  tileColor: ColorManager.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s10.r)),
                                  leading: CircleAvatar(
                                      radius: AppSize.s28,
                                      foregroundImage:
                                          CachedNetworkImageProvider(controller
                                                      .rxMySearchContact
                                                      .value
                                                      .data?[index]
                                                      .avatar ==
                                                  null
                                              ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                                              : API.imageUrl(controller
                                                  .rxMySearchContact
                                                  .value
                                                  .data?[index]
                                                  .avatar))),
                                  contentPadding: EdgeInsets.only(
                                      left: 12, top: 18, bottom: 12, right: 16),
                                  horizontalTitleGap: 8,
                                  title: Text(
                                    '${controller.rxMySearchContact.value.data?[index]?.name ?? controller.rxMySearchContact.value.data?[index].phone}',
                                    style: getBoldStyle(
                                        color: ColorManager.goodMorning,
                                        fontSize: FontSize.s16.sp),
                                  ),
                                  subtitle: controller.rxMySearchContact.value
                                              .data?[index] ==
                                          null
                                      ? null
                                      : Text(
                                          '${controller.rxMySearchContact.value.data?[index].phone ?? ''}',
                                          style: getBoldStyle(
                                              color: ColorManager.goodMorning,
                                              fontSize: FontSize.s16.sp),
                                        ),
                                  trailing: controller.rxMySearchContact.value
                                              .data?[index] ==
                                          null
                                      ? TextButton(
                                          onPressed: () {
                                            String message =
                                                "Try Tree me: app://com.wiz.treeme/invite";
                                            List<String> recipents = [
                                              controller.rxMySearchContact.value
                                                      .data?[index].phone ??
                                                  ""
                                            ];

                                            _sendSMS(message, recipents);
                                          },
                                          child: Text('Invite'))
                                      : null,
                                ),
                              );
                            },
                          );

                        case RequestStatus.ERROR:
                          return Center(
                            child: Text('NO Data'),
                          );
                          break;
                      }
                    }
                    switch (controller.rxRequestStatus.value) {
                      case RequestStatus.LOADING:
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );

                      case RequestStatus.SUCESS:
                        return GroupedListView<Data, String>(
                          elements:
                              controller.rxMyContactModel.value.data ?? [],
                          groupBy: (element) => element.status ?? '',
                          groupSeparatorBuilder: (String groupByValue) =>
                              controller.groupSeparatorBuilder(groupByValue),
                          itemBuilder: (context, Data element) => Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: AppSize.s30.w,
                                vertical: AppSize.s5.h),
                            child: ListTile(
                              onTap: () {
                                if (element.userData != null) {
                                  ShowBottomSheetHelperImpl().showBottomSheet(
                                      ShowBottomSheetInput(Container(
                                    height: 374,
                                    padding: EdgeInsets.all(AppSize.s20.h),
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.r),
                                          topRight: Radius.circular(15.r)),
                                    ),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                            radius: AppSize.s32,
                                            foregroundImage:
                                                CachedNetworkImageProvider(element
                                                            .userData?.avatar ==
                                                        null
                                                    ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                                                    : API.imageUrl(element
                                                        .userData?.avatar))),
                                        SizedBox(
                                          height: AppSize.s15.h,
                                        ),
                                        Text(
                                          '${element.userData?.name ?? element.phone}',
                                          style: getBoldStyle(
                                              color: ColorManager.goodMorning,
                                              fontSize: FontSize.s16.sp),
                                        ),
                                        SizedBox(
                                          height: AppSize.s15.h,
                                        ),
                                        Text(
                                          '${element.phone ?? ''}',
                                          style: getBoldStyle(
                                              color: ColorManager.goodMorning,
                                              fontSize: FontSize.s16.sp),
                                        ),
                                        SizedBox(
                                          height: AppSize.s15.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.sendMessage(
                                                element.userData?.id
                                                        .toString() ??
                                                    '',
                                                element.userData?.avatar ??
                                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
                                          },
                                          child: Container(
                                            width: 107.w,
                                            height: 78.h,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: AppSize.s6.w),
                                            decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xffFBD4A4),
                                                      Color(0xffFEAA46)
                                                    ],
                                                    end: Alignment.topCenter,
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    tileMode: TileMode.decal),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s14.r)),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  ImageAssets.messageIcon,
                                                  color: ColorManager.white,
                                                ),
                                                SizedBox(
                                                  height: AppSize.s9.h,
                                                ),
                                                Text(
                                                  'Message',
                                                  style: getSemiBoldStyle(
                                                      color: ColorManager.white,
                                                      fontSize:
                                                          FontSize.s12.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )));
                                }
                              },
                              tileColor: ColorManager.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s10.r)),
                              leading: CircleAvatar(
                                  radius: AppSize.s28,
                                  foregroundImage: CachedNetworkImageProvider(
                                      element.userData?.avatar == null
                                          ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                                          : API.imageUrl(
                                              element.userData?.avatar))),
                              contentPadding: EdgeInsets.only(
                                  left: 12, top: 18, bottom: 12, right: 16),
                              horizontalTitleGap: 8,
                              title: Text(
                                '${element.userData?.name ?? element.phone}',
                                style: getBoldStyle(
                                    color: ColorManager.goodMorning,
                                    fontSize: FontSize.s16.sp),
                              ),
                              subtitle: element.userData == null
                                  ? null
                                  : Text(
                                      '${element.phone ?? ''}',
                                      style: getBoldStyle(
                                          color: ColorManager.goodMorning,
                                          fontSize: FontSize.s16.sp),
                                    ),
                              trailing: element.userData == null
                                  ? TextButton(
                                      onPressed: () {
                                        String message =
                                            "Try Tree me: app://com.wiz.treeme/invite";
                                        List<String> recipents = [
                                          element.phone ?? ""
                                        ];

                                        _sendSMS(message, recipents);
                                      },
                                      child: Text('Invite'))
                                  : null,
                            ),
                          ),
                          // itemComparator: (item1, item2) =>
                          //     controller.seprator(item2, item2), // optional
                          useStickyGroupSeparators: false, // optional
                          floatingHeader: false,
                          order: GroupedListOrder.ASC, // optional
                        );

                        return ListView.builder(
                          itemCount:
                              controller.rxMyContactModel.value.data?.length,
                          clipBehavior: Clip.none,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: AppSize.s30.w,
                                  vertical: AppSize.s5.h),
                              child: ListTile(
                                onTap: () {
                                  Get.toNamed(AppRoutes.profile);
                                },
                                tileColor: ColorManager.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s10.r)),
                                leading: CircleAvatar(
                                  radius: AppSize.s28,
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: 12, top: 18, bottom: 12, right: 16),
                                horizontalTitleGap: 8,
                                title: Text(
                                  '${controller.rxMyContactModel.value?.data?[index].userData?.name ?? ''}',
                                  style: getBoldStyle(
                                      color: ColorManager.goodMorning,
                                      fontSize: FontSize.s16.sp),
                                ),
                                subtitle: Text(
                                  '${controller.rxMyContactModel.value?.data?[index].phone ?? ''}',
                                  style: getBoldStyle(
                                      color: ColorManager.goodMorning,
                                      fontSize: FontSize.s16.sp),
                                ),
                              ),
                            );
                          },
                        );

                      case RequestStatus.ERROR:
                        return Center(
                          child: Text('NO Data'),
                        );
                        break;
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }
}
