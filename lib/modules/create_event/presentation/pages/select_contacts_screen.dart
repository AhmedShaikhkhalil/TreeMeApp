import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treeme/core/resources/assets_manager.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/resources/font_manager.dart';
import 'package:treeme/core/resources/styles_manager.dart';
import 'package:treeme/core/resources/values_manager.dart';
import 'package:treeme/core/routes/app_routes.dart';
import 'package:treeme/core/widgets/custom_elevated_button_widget.dart';

import '../../../../core/config/apis/config_api.dart';
import '../../../../core/helpers/constants.dart';
import '../../../contacts/data/models/my_contact_model.dart';
import '../manager/create_event_controller.dart';

class SelectContactsScreen extends GetView<CreateEventController> {
  const SelectContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.chatBackGround,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              clipBehavior: Clip.none,
              slivers: [
                SliverAppBar(
                    expandedHeight: AppSize.s90.h,
                    backgroundColor: ColorManager.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppSize.s36.r),
                          bottomRight: Radius.circular(AppSize.s36.r)),
                    ),
                    elevation: 4,
                    // toolbarHeight: 40.h,

                    centerTitle: true,
                    flexibleSpace: Center(
                      child: Text(
                        'Select your\n Contacts',
                        style: getBoldStyle(
                            color: ColorManager.goodMorning,
                            fontSize: FontSize.s16.sp),
                      ),
                    ),
                    leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: AppSize.s12.w),
                        // width: 50.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s12.r),
                            border: Border.all(
                                color: ColorManager.white.withOpacity(0.29),
                                width: AppSize.s1.w),
                            // color: Colors.transparent,
                            gradient: LinearGradient(
                                colors: [
                                  ColorManager.white.withOpacity(0.51),
                                  ColorManager.white.withOpacity(0.13),
                                ],
                                stops: [
                                  0.3,
                                  2
                                ],
                                tileMode: TileMode.decal,
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x1A21407C),
                                  offset: Offset(0, 3),
                                  blurRadius: 10)
                            ]),
                        child: Icon(
                          Icons.arrow_back,
                          color: ColorManager.goodMorning,
                        ),
                      ),
                    ),
                    leadingWidth: 75.w,
                    pinned: false,
                    snap: true,
                    floating: true),
                SliverFillRemaining(
                  hasScrollBody: true,
                  // fillOverscroll: true,
                  child: Obx(() {
                    switch (
                        controller.contactController.rxRequestStatus.value) {
                      case RequestStatus.LOADING:
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );

                      case RequestStatus.SUCESS:
                        return GroupedListView<Data, String>(
                          elements: controller.contactController
                                  .rxMyContactModel.value.data ??
                              [],
                          groupBy: (element) => element.status ?? '',

                          groupSeparatorBuilder: (String groupByValue) =>
                              controller.contactController
                                  .groupSeparatorBuilder(groupByValue),
                          itemBuilder: (context, Data element) => Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: AppSize.s30.w,
                                vertical: AppSize.s5.h),
                            child: ListTile(
                              // onTap: () {
                              //   if (element.userData != null) {
                              //     Get.toNamed(AppRoutes.profile);
                              //   }
                              // },
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
                                  : Obx(() {
                                      return Checkbox(
                                        checkColor: Colors.white,
                                        overlayColor: MaterialStateProperty.all(
                                            Color(0xffD9D9D9)),
                                        value: element.isCheck.value,
                                        activeColor: Color(0xffFB84A7),
                                        shape: CircleBorder(),
                                        onChanged: (bool? value) {
                                          controller.isCheck(element);
                                        },
                                      );
                                    }),
                            ),
                          ),
                          // itemComparator: (item1, item2) =>
                          //     controller.seprator(item2, item2), // optional
                          useStickyGroupSeparators: false,
                          // optional
                          floatingHeader: false,
                          order: GroupedListOrder.ASC, // optional
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
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.s30.w, vertical: AppSize.s30.h),
            child: CustomElevatedButton(
              title: 'NEXT',
              onPressed: () async {
                // controller.getRoom();
                Get.toNamed(AppRoutes.createMedia);

                // controller.createNewEvent();
              },
            ),
          )
        ],
      ),
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
// trailing: Checkbox(
//   checkColor: Colors.white,
//   overlayColor: MaterialStateProperty.all(
//       Color(0xffD9D9D9)),
//   value: logic.isChecked.value,
//   activeColor: Color(0xffFB84A7),
//   shape: CircleBorder(),
//   onChanged: (bool? value) {
//     logic.isCheck();
//   },
// ),
