import 'package:animate_do/animate_do.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:treeme/core/helpers/custom_icons_icons.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/resources/values_manager.dart';
import 'package:treeme/core/routes/app_routes.dart';

import '../manager/nav_bar_controller.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return GetBuilder<NavBarController>(
        assignId: true,
        id: 'ss',
        builder: (controller) {
          return Scaffold(
              extendBody: true,
              // backgroundColor: Colors.transparent,
              body: Navigator(
                key: Get.nestedKey(1),
                initialRoute: '/home',
                onGenerateRoute: controller.onGenerateRoute,
              ), //destination screen
              floatingActionButton: showFab
                  ? FloatingActionButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.typeWithTheme);
                      },
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      highlightElevation: 0,
                      focusElevation: 0,
                      hoverElevation: 0,
                      splashColor: Colors.white.withOpacity(0.5),
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Container(
                        height: 64.h,
                        width: 64.h,
                        decoration: BoxDecoration(
                            gradient: ColorManager().gradientFloating,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff4ED2F7).withOpacity(0.33),
                                  offset: Offset(0, 24),
                                  blurRadius: 24)
                            ]),
                        child: Swing(
                          infinite: true,
                          // turns: controller.animation,
                          child: Icon(
                            Icons.add,
                            size: AppSize.s30.h,
                          ),
                        ),
                      ),
                    )
                  : null,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: AnimatedBottomNavigationBar(
                  icons: const [
                    CustomIcons.home_icon,
                    CustomIcons.calendar_icon,
                    CustomIcons.contact_icon,
                    CustomIcons.profile_icon,
                  ],
                  activeColor: ColorManager.activeIcon,
                  inactiveColor: ColorManager.inactiveIcon,
                  activeIndex: controller.tabIndex.value,
                  gapLocation: GapLocation.center,
                  notchSmoothness: NotchSmoothness.softEdge,
                  notchMargin: 7,
                  // notchAndCornersAnimation: controller.borderRadiusAnimation,
                  height: AppSize.s60.h,
                  leftCornerRadius: 32,
                  rightCornerRadius: 32,
                  onTap: (index) {
                    // log(controller.tabIndex.value.toString());
                    controller.changePage(index);
                  }

                  //other params
                  ));
        });
  }
}
