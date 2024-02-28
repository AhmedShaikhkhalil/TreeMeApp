import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treeme/core/bindings/home_bindings.dart';
import 'package:treeme/core/bindings/my_contact_bindings.dart';
import 'package:treeme/core/bindings/my_profile_bindings.dart';
import 'package:treeme/modules/contacts/presentation/pages/contacts_screen.dart';

import '../../../../core/bindings/my_calendar_bindings.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../../../my_calendar/presentation/pages/my_calendar_screen.dart';
import '../../../my_profile/presentation/pages/my_profile_screen.dart';

class NavBarController extends GetxController with GetSingleTickerProviderStateMixin {
  RxInt tabIndex = 0.obs;
  var isPressed = false.obs;
  // late Animation<double> borderRadiusAnimation;
  // late AnimationController borderRadiusAnimationController;
  // late CurvedAnimation borderRadiusCurve;

  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // borderRadiusAnimationController = AnimationController(
    //   duration: Duration(milliseconds: 500),
    //   vsync: this,
    // );
    // borderRadiusCurve = CurvedAnimation(
    //   parent: borderRadiusAnimationController,
    //   curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    // );
    // borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
    //   borderRadiusCurve,
    // );
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        // update();
      });

    animationController.repeat();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  // Color changeColor(int index) {
  //   if (tabIndex.value == index) {
  //     return mainColor;
  //   } else {
  //     return unselectedIconColor;
  //   }
  // }

  void changePage(int index) {
    print(tabIndex.value);
    if (tabIndex.value != index) {
      print(index);
      tabIndex.value = index;
      print(tabIndex.value);
      Get.offNamedUntil(
        pages[index],
        (page) => page.settings.name == '/home',
        id: 1,
      );
      // Get.keys[1]!.currentState!.pushNamed(pages[index]);
      // // Get.toNamed(
      // //   pages[index],
      // //   id: 1,
      // // );
      update(['ss']);
    }
  }

  // String getTitle(int index) {
  //   switch (index) {
  //     case 0:
  //       return AppStrings.appName;
  //     case 1:
  //       return AppStrings.notification;
  //     case 2:
  //       return AppStrings.myReports;
  //     case 3:
  //       return AppStrings.services;
  //     case 4:
  //       return AppStrings.myOrders;
  //     default:
  //       return '';
  //   }
  // }
// late final  List<SvgPicture> _svgIcons = [
//     SvgPicture.asset(
//       ImageAssets.homeIcon,
//       width: 24,
//       height: 24,
//     ),
//     SvgPicture.asset(
//       ImageAssets.calendarIcon,
//       width: 24,
//       height: 24,
//     ),
//     SvgPicture.asset(
//       ImageAssets.contactIcon,
//       width: 24,
//       height: 24,
//     ),
//     SvgPicture.asset(
//       ImageAssets.profileIcon,
//       width: 24,
//       height: 24,
//     ),
//   ];
//  late List<IconData> _icons = _svgIcons.map((icon) {
//     final pictureRecorder = PictureRecorder();
//     final canvas = Canvas(pictureRecorder);
//     icon.paint(canvas, Rect.zero);
//     final picture = pictureRecorder.endRecording();
//     final image = picture.toImage(24, 24);
//     final bytes = image.toByteData(format: ImageByteFormat.png);
//     return IconData(0xe900, fontFamily: 'CustomIcons', fontPackage: null);
//   }).toList();
//   IconData _getIcon(int index) {
//     switch (index) {
//       case 0:
//         return IconData(0xe900, fontFamily: 'CustomIcons');
//       case 1:
//         return IconData(0xe901, fontFamily: 'CustomIcons');
//       case 2:
//         return IconData(0xe902, fontFamily: 'CustomIcons');
//       default:
//         throw Exception("Invalid index");
//     }
//   }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return GetPageRoute(
          settings: settings,
          // curve: Curves.easeInCirc,
          transitionDuration: const Duration(milliseconds: 200),
          transition: Transition.downToUp,

          page: () => const HomeScreen(),
          binding: HomeBinding(),

          // binding: BrowseBinding(),
        );
      case '/my_calendar':
        return GetPageRoute(
          settings: settings,
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 200),
          page: () => MyCalendarScreen(),
          binding: MyCalendarBindings(),
        );
      case '/contacts':
        return GetPageRoute(
          settings: settings,
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 200),
          page: () => ContactsScreen(),
          binding: MyContactBinding(),
        );
      case '/my_profile':
        return GetPageRoute(
            settings: settings,
            transition: Transition.leftToRight,
            transitionDuration: const Duration(milliseconds: 200),
            page: () => MyProfileScreen(),
            binding: MyProfileBinding());
      case '/MyOrders':
        return GetPageRoute(
          settings: settings,
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 200),
          page: () => Container(
            color: Colors.amber,
          ),
        );
      // binding: CartBinding());
      default:
        return GetPageRoute(
            settings: settings,
            transition: Transition.leftToRight,
            page: () => Container(
                  child: const Text('NO Page'),
                ));
    }
  }

  final pages = <String>[
    '/home',
    '/my_calendar',
    '/contacts',
    '/my_profile',
    '/MyOrders',
  ];
}
