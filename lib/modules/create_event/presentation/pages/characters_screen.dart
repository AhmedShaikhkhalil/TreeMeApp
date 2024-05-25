import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/resources/font_manager.dart';
import 'package:treeme/core/resources/styles_manager.dart';
import 'package:treeme/core/resources/values_manager.dart';
import 'package:treeme/core/widgets/custom_elevated_button_widget.dart';

import '../../../../core/helpers/constants.dart';
import '../manager/create_event_controller.dart';

class SelectCharacterScreen extends GetView<CreateEventController> {
  const SelectCharacterScreen({Key? key}) : super(key: key);

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
                    centerTitle: true,
                    flexibleSpace: Center(
                      child: Text(
                        'Select Character',
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s12.r),
                            border: Border.all(
                                color: ColorManager.white.withOpacity(0.29),
                                width: AppSize.s1.w),
                            gradient: LinearGradient(
                                colors: [
                                  ColorManager.white.withOpacity(0.51),
                                  ColorManager.white.withOpacity(0.13),
                                ],
                                stops: const [
                                  0.3,
                                  2
                                ],
                                tileMode: TileMode.decal,
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0x1A21407C),
                                  offset: Offset(0, 3),
                                  blurRadius: 10)
                            ]),
                        child: const Icon(
                          Icons.arrow_back,
                          color: ColorManager.goodMorning,
                        ),
                      ),
                    ),
                    leadingWidth: 75.w,
                    pinned: false,
                    snap: true,
                    floating: true,
                  ),
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: Builder(builder: (context) {
                      switch (
                          controller.contactController.rxRequestStatus.value) {
                        case RequestStatus.LOADING:
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        case RequestStatus.SUCESS:
                          return GridView.builder(
                            padding: const EdgeInsets.all(20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20.0,
                                    mainAxisSpacing: 20,
                                    mainAxisExtent: 232),
                            itemCount: controller.rxEventCharactersModel.length,
                            itemBuilder: (context, int index) => InkWell(
                              onTap: () {
                                controller.selectCharacter(
                                    controller.rxEventCharactersModel[index]);
                              },
                              child: Obx(() {
                                return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(24),
                                        border: controller.isSelected(controller
                                                .rxEventCharactersModel[index])
                                            ? Border.all(color: Colors.red)
                                            : null),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        SizedBox(
                                          height: 160,
                                          width: AppSize.s265,
                                          child: Image.network(
                                            controller
                                                .rxEventCharactersModel[index]
                                                .image!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, left: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    '\$${controller.rxEventCharactersModel[index].price!}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorManager
                                                            .moveSmoothColor),
                                                  ),
                                                  Text(
                                                    controller
                                                        .rxEventCharactersModel[
                                                            index]
                                                        .title!,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color: ColorManager
                                                            .goodMorning),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                    color: ColorManager
                                                        .moveSmoothColor,
                                                    shape: BoxShape.circle),
                                                child: IconButton(
                                                    onPressed: () {},
                                                    color: ColorManager.white,
                                                    icon:
                                                        const Icon(Icons.add)),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ));
                              }),
                            ),
                          );

                        case RequestStatus.ERROR:
                          return const Center(
                            child: Text('NO Data'),
                          );
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
                onPressed: () => controller.validateSelectCharacter(),
              ),
            )
          ],
        ));
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }
}
