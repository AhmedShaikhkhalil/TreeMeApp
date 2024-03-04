import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/routes/app_routes.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../manager/create_event_controller.dart';
import '../widgets/type_theme_widgets.dart';

class TypeWiththemeScreen extends GetView<CreateEventController> {
  const TypeWiththemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.chatBackGround,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            expandedHeight: AppSize.s265.h,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: ColorManager().gradientFloating,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(125, 35),
                    bottomLeft: Radius.elliptical(125, 35),
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(ImageAssets.intersectCorner),
                    ),
                    // BackgroundArcs(Colors.white),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageAssets.magicHat),
                          SizedBox(
                            height: AppSize.s16.h,
                          ),
                          Text(
                            AppStrings.chooseYourEvent,
                            style: getBoldStyle(
                                color: ColorManager.chatBackGround,
                                fontSize: FontSize.s20.sp),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,

            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                margin: EdgeInsets.only(left: AppSize.s24.w),
                width: 50.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s12.r),
                    border: Border.all(
                        color: ColorManager.white.withOpacity(0.29), width: AppSize.s1.w),
                    // color: Colors.transparent,
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
            leadingWidth: 75.w,
          ),
          SliverToBoxAdapter(child: Obx(() {
            switch (controller.rxRequestStatus.value) {
              case RequestStatus.LOADING:
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              case RequestStatus.SUCESS:
                return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: AppSize.s30.h, bottom: AppSize.s20.h),
                  itemCount: controller.rxEventTypeModel.value.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.eventTypeID.value =
                            controller.rxEventTypeModel.value.data![index].id.toString();
                        print(controller.eventTypeID.value);
                        print(controller.eventTime.value);
                        print(controller.eventDate.value);
                        Get.toNamed(
                          AppRoutes.createEvent,
                        );
                      },
                      child: TypeThemeWidgets(
                        eventTypeModel: controller.rxEventTypeModel.value.data![index],
                      ),
                    );
                  },
                );

              case RequestStatus.ERROR:
                return Center(
                  child: Text('NO Data'),
                );
            }
          }))
        ]));
  }
}
