

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treeme/core/resources/assets_manager.dart';

import '../../../home/presentation/pages/dummy_model.dart';

class ProfileController extends GetxController with GetSingleTickerProviderStateMixin{
  late TabController tabController;


  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);

  }

  List<Tab> tabs = [
    Tab(text: 'Media',),
    Tab(text: 'Events',)
  ];

  RxList<ProfileModelOption> list = <ProfileModelOption>[
    ProfileModelOption(ImageAssets.messageIcon,'Message'),
    ProfileModelOption(ImageAssets.notificationIcon ,'Mute'),
    ProfileModelOption(ImageAssets.qrIcon ,'Scan QR'),

  ].obs;
  List<CardBTH> eventList = [
    CardBTH('Ahmed', Color(0xff46D1F7),
        [Color(0xff46D1F7), Color(0xffBAECFB)], 'assets/images/darticon.png'),
    CardBTH('Ali', Color(0xffFEAA46), [Color(0xffFEAA46), Color(0xffFBD4A4)],
        'assets/images/cannon.png'),
    CardBTH(
        'Mohammed',
        Color(0xffEA4477),
        [Color(0xffEA4477), Color(0xffFB84A7)],
        'assets/images/cotton candy.png'),
    CardBTH('Ahmed', Color(0xff46D1F7),
        [Color(0xff46D1F7), Color(0xffBAECFB)], 'assets/images/darticon.png'),
    CardBTH('Ali', Color(0xffFEAA46), [Color(0xffFEAA46), Color(0xffFBD4A4)],
        'assets/images/cannon.png'),
    CardBTH(
        'Mohammed',
        Color(0xffEA4477),
        [Color(0xffEA4477), Color(0xffFB84A7)],
        'assets/images/cotton candy.png'),
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
}


class ProfileModelOption{
  final String? icon;
  final String? title;

  ProfileModelOption(this.icon, this.title);
}