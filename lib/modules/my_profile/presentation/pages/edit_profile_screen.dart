import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:treeme/core/resources/assets_manager.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/resources/font_manager.dart';
import 'package:treeme/core/resources/styles_manager.dart';
import 'package:treeme/core/resources/values_manager.dart';
import 'package:treeme/core/utils/services/storage.dart';
import 'package:treeme/core/utils/svg_provider.dart';
import 'package:treeme/core/widgets/custom_elevated_button_widget.dart';
import 'package:treeme/core/widgets/custom_textField_with_label.dart';
import 'package:treeme/modules/my_profile/presentation/manager/my_profile_controller.dart';

import '../../../../core/config/apis/config_api.dart';
import '../../../../core/helpers/constants.dart';

class EditProfileScreen extends GetView<MyProfileController> {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
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
                  'Edit Profile',
                  style: getBoldStyle(
                      color: ColorManager.chatBackGround, fontSize: FontSize.s16.sp),
                ),
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
                    child: Icon(
                      Icons.arrow_back,
                      color: ColorManager.white,
                    ),
                  ),
                ),
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
                    color: ColorManager.chatBackGround,
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
                        child: Padding(
                      padding: const EdgeInsets.all(AppSize.s15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomTextFieldWithLabel(
                              label: 'Name',
                              hint: 'Name',
                              controller: controller.nameController,
                            ),
                            SizedBox(
                              height: AppSize.s24.h,
                            ),
                            CustomTextFieldWithLabel(
                              label: 'Age',
                              hint: 'Age',
                              controller: controller.ageController,
                            ),
                            SizedBox(
                              height: AppSize.s120.h,
                            ),
                            CustomElevatedButton(
                              title: 'Submit',
                              onPressed: () {
                                controller.updateProfile();
                                Get.back();
                              },
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              )),
          Positioned(
            top: 135.h,
            right: 137.w,
            child: GestureDetector(
              onTap: () {
                controller.pickImageDriverLicence();
              },
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
                        image: controller.havePickImage == true
                            ? FileImage(
                                File(controller.filePickImage!.path),
                              )
                            : AppConfig.avatar != null || Storage().avatar != null
                                ? CachedNetworkImageProvider(API.imageUrl(AppConfig
                                        .avatar ??
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
            ),
          ),
        ],
      );
    }));
  }
}
