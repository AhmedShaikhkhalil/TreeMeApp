import 'dart:developer' as dev;
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:treeme/core/helpers/constants.dart';
import 'package:treeme/core/helpers/date_format_extensions.dart';
import 'package:treeme/core/resources/assets_manager.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/resources/values_manager.dart';
import 'package:treeme/core/routes/app_routes.dart';
import 'package:treeme/core/utils/services/storage.dart';
import 'package:treeme/modules/chat/domain/repositories/chat.dart';
import 'package:treeme/modules/home/presentation/manager/home_controller.dart';

import '../../../../core/config/apis/config_api.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/utils/svg_provider.dart';
import '../../../chat/presentation/pages/generate_token_new.dart';
import '../widgets/arc_widget.dart';
import '../widgets/counter_delivered_widget.dart';
import '../widgets/event_widget.dart';
import '../widgets/time_massage_widget.dart';
import 'dummy_model.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CardBTH> list = [
      CardBTH('Ahmed', Color(0xff46D1F7),
          [Color(0xff46D1F7), Color(0xffBAECFB)], 'assets/images/darticon.png'),
      CardBTH('Ali', Color(0xffFEAA46), [Color(0xffFEAA46), Color(0xffFBD4A4)],
          'assets/images/cannon.png'),
      CardBTH(
          'Mohammed',
          Color(0xffEA4477),
          [Color(0xffEA4477), Color(0xffFB84A7)],
          'assets/images/cotton candy.png'),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: GetBuilder<HomeController>(builder: (logic) {
        return Stack(
          children: [
            BackgroundArcs(Color(0xff46D1F7)),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.s25.w, vertical: AppSize.s4.h),
                    child: ListTile(
                      leading: Container(
                        height: AppSize.s50.h,
                        width: AppSize.s50.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.redAccent,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AppConfig.avatar != null ||
                                        Storage().avatar != null
                                    ? CachedNetworkImageProvider(API.imageUrl(
                                        AppConfig.avatar ??
                                            Storage().avatar ??
                                            'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.businessnetworks.com%2Fimage%2Fdefault-avatarpng&psig=AOvVaw3u97diAqPZhe1_v73AuGm_&ust=1690873615751000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCOjKsJuxuIADFQAAAAAdAAAAABAH'))
                                    : const Image(
                                            image: SvgProvider(
                                                ImageAssets.splashLogo))
                                        .image)),
                      ),
                      title: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(children: [
                            TextSpan(
                                text: AppStrings.goodMorning,
                                style: getRegularStyle(
                                    color: ColorManager.goodMorning,
                                    fontSize: FontSize.s16.sp),
                                children: [
                                  WidgetSpan(
                                      child: Lottie.network(
                                          'https://fonts.gstatic.com/s/e/notoemoji/latest/1f44b/lottie.json',
                                          height: AppSize.s20.h,
                                          width: AppSize.s20.w)),
                                ])
                          ])),
                      subtitle: Text('${AppConfig.firstName}',
                          style: getBoldStyle(
                              color: ColorManager.goodMorning,
                              fontSize: FontSize.s20.sp)),
                      trailing: GestureDetector(
                        onTap: () {
                          controller.getHome();
                        },
                        child: Container(
                          height: AppSize.s40.h,
                          width: AppSize.s40.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppSize.s12.r),
                              color: ColorManager.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF16434D).withOpacity(0.1),
                                    offset: Offset(0, 3),
                                    blurRadius: 13)
                              ]),
                          child: Icon(Icons.refresh),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s50.h,
                  ),
                  SizedBox(
                    height: 145.h,
                    child: Obx(() {
                      switch (controller.rxRequestStatus.value) {
                        case RequestStatus.LOADING:
                          return Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        case RequestStatus.SUCESS:
                          if (controller
                                      .rxMyHomeModel.value.eventData?.isEmpty ==
                                  true ||
                              controller.rxMyHomeModel.value.eventData ==
                                  null) {
                            return Center(
                              child: Text(
                                'No Event Data',
                                style: getBoldStyle(
                                    color: ColorManager.mainColor,
                                    fontSize: FontSize.s18),
                              ),
                            );
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              clipBehavior: Clip.none,
                              itemCount: controller
                                  .rxMyHomeModel.value.eventData?.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () {
                                    FirebaseChatCore.instance.setConfig(
                                        FirebaseChatCoreConfig(
                                            null, 'EventApp', 'Users'));
                                    Get.to(ChatPage(
                                      fcmUser: controller.fcmsTokens(controller
                                              .rxMyHomeModel
                                              .value
                                              .eventData![i]
                                              .avatars ??
                                          []),
                                      room: Room(
                                          name: controller.rxMyHomeModel.value
                                              .eventData![i].title,
                                          id: controller.rxMyHomeModel.value
                                                  .eventData![i].documentId ??
                                              '',
                                          type: RoomType.group,
                                          users: controller.rxMyHomeModel.value
                                              .eventData![i].userIds!
                                              .map((e) => User(
                                                  id: e,
                                                  imageUrl: controller.imageUrl(
                                                      controller
                                                          .rxMyHomeModel
                                                          .value
                                                          .eventData![i]
                                                          .avatars)))
                                              .toList()),
                                      newRoom: false,
                                      havePinMassage: true,
                                      color: controller.rxMyHomeModel.value
                                          .eventData![i].eventColor,
                                    ));
                                  },
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      EventWidget(
                                        cardBTH: controller
                                            .rxMyHomeModel.value.eventData![i],
                                      ),
                                      CounterNumberWidget(
                                        data: FirebaseChatCore.instance
                                            .getFirebaseFirestore()
                                            .collection(
                                                '${'EventApp'}/${controller.rxMyHomeModel.value.eventData?[i].documentId}/messages')
                                            .orderBy('updatedAt',
                                                descending: false)
                                            .snapshots(),
                                      )
                                      // Align(
                                      //   alignment: Alignment.topRight,
                                      //   child: Badge(
                                      //     // smallSize: 23,
                                      //     textStyle:
                                      //         getRegularStyle(color: ColorManager.white),
                                      //     textColor: Colors.white,
                                      //     isLabelVisible: true,
                                      //     // padding: EdgeInsets.all(5),
                                      //
                                      //     label: Text(
                                      //       '23',
                                      //       style: getRegularStyle(
                                      //           color: ColorManager.white),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                );
                              });
                          break;
                        case RequestStatus.ERROR:
                          return Center(
                            child: Text(
                              'NO Data',
                              style:
                                  getBoldStyle(color: ColorManager.mainColor),
                            ),
                          );
                      }
                    }),
                  ),
                  SizedBox(
                    height: AppSize.s33.h,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: AppSize.s30.w,
                          right: AppSize.s30.w,
                          top: AppSize.s36.h),
                      decoration: BoxDecoration(
                        color: ColorManager.chatBackGround,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(145, 35),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Chats',
                                style: getBoldStyle(
                                    color: ColorManager.goodMorning,
                                    fontSize: FontSize.s20.sp),
                              ),
                              // Container(
                              //   height: AppSize.s40.h,
                              //   padding: EdgeInsets.all(AppSize.s12.h),
                              //   width: AppSize.s40.w,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(AppSize.s12.r),
                              //       color: ColorManager.white,
                              //       boxShadow: [
                              //         BoxShadow(
                              //             color: Color(0xFF16434D).withOpacity(0.1),
                              //             offset: Offset(0, 3),
                              //             blurRadius: 13)
                              //       ]),
                              //   child: SvgPicture.asset(
                              //     ImageAssets.iconSearch,
                              //     height: AppSize.s16.h,
                              //     width: AppSize.s16.w,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: AppSize.s18.h,
                          ),
                          Expanded(
                            child: Obx(() {
                              switch (controller.rxRequestStatus.value) {
                                case RequestStatus.LOADING:
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                case RequestStatus.SUCESS:
                                  if (controller.rxMyHomeModel.value
                                              .conversationData?.isEmpty ==
                                          true ||
                                      controller.rxMyHomeModel.value
                                              .conversationData ==
                                          null) {
                                    print('hiooo');
                                    print(controller.rxMyHomeModel.value.conversationData?.isEmpty);
                                    print(controller.rxMyHomeModel.value
                                        .conversationData ==
                                        null);
                                    return Center(
                                      child: Text(
                                        'NO Data',
                                        style: getBoldStyle(
                                            color: ColorManager.mainColor),
                                      ),
                                    );
                                  }
                                  return RefreshIndicator(
                                    onRefresh: () {
                                      return controller.getHome();
                                    },
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      itemCount: controller.rxMyHomeModel.value
                                          .conversationData?.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              bottom: AppSize.s15.h),
                                          decoration: BoxDecoration(
                                              color: ColorManager.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSize.s10.r)),
                                          child: ZoomIn(
                                            child: StreamBuilder<
                                                    QuerySnapshot<
                                                        Map<String, dynamic>>>(
                                                // initialData: ,
                                                stream: FirebaseChatCore
                                                    .instance
                                                    .getFirebaseFirestore()
                                                    .collection(
                                                        '${'Conversation'}/${controller.rxMyHomeModel.value.conversationData?[index].conversationId}/messages')
                                                    .orderBy('updatedAt',
                                                        descending: false)
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.data == null) {
                                                    return CircularProgressIndicator();
                                                  }
                                                  if (snapshot.hasError) {
                                                    return Text(
                                                        'Error: ${snapshot.error}');
                                                  }

                                                  if (!snapshot.hasData) {
                                                    return CircularProgressIndicator();
                                                  }
                                                  // final List<
                                                  // //         QueryDocumentSnapshot<
                                                  // //             Map<String, dynamic>>>
                                                  // //     docs = snapshot.data!.docs;
                                                  // // print(snapshot.data);
                                                  // if (snapshot.data?.docs.last['type'] !=
                                                  //     'text') {}
                                                  // controller.showdeliverd(snapshot.data);
                                                  return ListTile(
                                                    onTap: () {
                                                      FirebaseChatCore.instance
                                                          .setConfig(
                                                              FirebaseChatCoreConfig(
                                                                  null,
                                                                  'Conversation',
                                                                  'Users'));
                                                      Get.to(ChatPage(
                                                        room: Room(
                                                          id: controller
                                                                  .rxMyHomeModel
                                                                  .value
                                                                  .conversationData![
                                                                      index]
                                                                  .conversationId ??
                                                              '',
                                                          type: RoomType.direct,
                                                          name: controller
                                                                  .rxMyHomeModel
                                                                  .value
                                                                  .conversationData?[
                                                                      index]
                                                                  .userData?[0]
                                                                  ?.name ??
                                                              '',
                                                          users: [
                                                            User(
                                                                id: controller
                                                                        .rxMyHomeModel
                                                                        .value
                                                                        .conversationData![
                                                                            index]
                                                                        .data
                                                                        ?.firebaseIds
                                                                        ?.receiver ??
                                                                    '',
                                                                imageUrl: controller
                                                                            .rxMyHomeModel
                                                                            .value
                                                                            .conversationData?[
                                                                                index]
                                                                            .userData?[
                                                                                0]
                                                                            .avatar ==
                                                                        null
                                                                    ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                                                                    : API
                                                                        .imageUrl(
                                                                        controller.rxMyHomeModel.value.conversationData?[index].userData?[0]?.avatar ??
                                                                            '',
                                                                      ))
                                                          ],
                                                        ),
                                                        newRoom: false,
                                                        fcmUser: [
                                                          controller
                                                                  .rxMyHomeModel
                                                                  .value
                                                                  .conversationData![
                                                                      index]
                                                                  .userData?[0]
                                                                  .fcmToken ??
                                                              ''
                                                        ],
                                                      ));
                                                    },
                                                    leading: Container(
                                                      height: AppSize.s50.h,
                                                      width: AppSize.s50.w,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              Colors.redAccent,
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: CachedNetworkImageProvider(controller
                                                                          .rxMyHomeModel
                                                                          .value
                                                                          .conversationData?[
                                                                              index]
                                                                          .userData?[
                                                                              0]
                                                                          .avatar ==
                                                                      null
                                                                  ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                                                                  : API.imageUrl(controller
                                                                          .rxMyHomeModel
                                                                          .value
                                                                          .conversationData?[
                                                                              index]
                                                                          .userData?[0]
                                                                          ?.avatar ??
                                                                      '')))),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 12,
                                                            top: 18,
                                                            bottom: 12,
                                                            right: 16),
                                                    horizontalTitleGap: 8,
                                                    title: Text(
                                                      controller
                                                              .rxMyHomeModel
                                                              .value
                                                              .conversationData?[
                                                                  index]
                                                              .userData?[0]
                                                              ?.name ??
                                                          '',
                                                      style: getBoldStyle(
                                                          color: ColorManager
                                                              .goodMorning,
                                                          fontSize:
                                                              FontSize.s16.sp),
                                                    ),
                                                    subtitle: Text(
                                                      '${snapshot.data?.docs.last['type'] != 'text' ? 'Media' : snapshot.data?.docs.last['text']}',
                                                      style: getBoldStyle(
                                                          color:
                                                              Color(0xffC3C2C9),
                                                          fontSize:
                                                              FontSize.s14.sp),
                                                    ),
                                                    trailing: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TimeMassageWidget(
                                                          data: FirebaseChatCore
                                                              .instance
                                                              .getFirebaseFirestore()
                                                              .collection(
                                                                  '${'Conversation'}/${controller.rxMyHomeModel.value.conversationData?[index].conversationId}/messages')
                                                              .orderBy(
                                                                  'updatedAt',
                                                                  descending:
                                                                      false)
                                                              .snapshots(),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        // controller.number.value == 0
                                                        //     ? SizedBox()
                                                        //     : Container(
                                                        //         height: AppSize.s16.h,
                                                        //         width: AppSize.s16.w,
                                                        //         alignment:
                                                        //             Alignment.center,
                                                        //         decoration: const BoxDecoration(
                                                        //             shape:
                                                        //                 BoxShape.circle,
                                                        //             gradient: LinearGradient(
                                                        //                 colors: [
                                                        //                   Color(
                                                        //                       0xffEA4477),
                                                        //                   Color(
                                                        //                       0xffFB84A7)
                                                        //                 ],
                                                        //                 tileMode: TileMode
                                                        //                     .clamp,
                                                        //                 begin: Alignment
                                                        //                     .bottomRight,
                                                        //                 stops: [0.0, 1.0],
                                                        //                 end: Alignment
                                                        //                     .topLeft)),
                                                        //         child: Text(
                                                        //           '${controller.number.value}',
                                                        //           style: getBoldStyle(
                                                        //               color: ColorManager
                                                        //                   .white,
                                                        //               fontSize: FontSize
                                                        //                   .s12.sp),
                                                        //         ),
                                                        //       )
                                                        CounterNumberWidget(
                                                          data: FirebaseChatCore
                                                              .instance
                                                              .getFirebaseFirestore()
                                                              .collection(
                                                                  '${'Conversation'}/${controller.rxMyHomeModel.value.conversationData?[index].conversationId}/messages')
                                                              .orderBy(
                                                                  'updatedAt',
                                                                  descending:
                                                                      false)
                                                              .snapshots(),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                case RequestStatus.ERROR:
                                  return Center(
                                    child: Text(
                                      'NO Data',
                                      style: getBoldStyle(color: Colors.black),
                                    ),
                                  );
                              }
                            }),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      })),
    );
  }
}

class QuadrantCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(centerX, centerY);

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    canvas.drawLine(Offset(centerX, 0), Offset(centerX, centerY), paint);
    canvas.drawLine(Offset(0, centerY), Offset(centerX, centerY), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class EllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromLTWH(250, -180, size.width, size.height);
    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
