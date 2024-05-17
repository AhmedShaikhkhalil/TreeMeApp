import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/resources/resource.dart';

import '../manager/create_media_controller.dart';
import 'package:audioplayers/audioplayers.dart' hide PlayerState;

class AddAudioScreen extends StatefulWidget {
  const AddAudioScreen({super.key});

  @override
  State<AddAudioScreen> createState() => _AddAudioScreenState();
}

class _AddAudioScreenState extends State<AddAudioScreen> {
  RxBool _isPlaying = false.obs;
  RxInt _currentIndex = (-1).obs;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateMediaController>(builder: (logic) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, AppSize.s80.h),
          child: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppSize.s36.r),
                    bottomRight: Radius.circular(AppSize.s36.r))),
            elevation: 0,
            backgroundColor: ColorManager.white,
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
            title: Text(
              'Add Audio',
              style: getBoldStyle(
                  color: ColorManager.goodMorning, fontSize: FontSize.s16.sp),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),
        ),
        body: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height - 300,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: logic.createEventController.rxEventAudiosModel.length,
            itemBuilder: (context, int index) => InkWell(
              onTap: () {
                _play(logic, index);

                // logic.setRxselectedAudio(
                //     logic.createEventController.rxEventAudiosModel[index]);
              },
              child: Obx(() {
                return Container(
                    // height: 50.0,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: _currentIndex.value == index
                            ? Border.all(color: Colors.red)
                            : null),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 42,
                                  width: 42,
                                  child: Image.network(
                                    logic.createEventController
                                        .rxEventAudiosModel[index].image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        logic.createEventController
                                            .rxEventAudiosModel[index].name!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: ColorManager.goodMorning),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        logic.createEventController
                                            .rxEventAudiosModel[index].length!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: ColorManager.goodMorning),
                                      ),
                                    ]),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                _play(logic, index);
                              },
                              child: (_isPlaying.value &&
                                      (_currentIndex.value == index))
                                  ? const Icon(Icons.pause)
                                  : SvgPicture.asset(
                                      ImageAssets.playVideo,
                                      width: 15,
                                      height: 15,
                                    ),
                            ),
                            if (_currentIndex.value == index)
                              InkWell(
                                onTap: () {
                                  logic.setRxselectedAudio(logic
                                      .createEventController
                                      .rxEventAudiosModel[index]);
                                  Get.back();
                                },
                                child: Container(
                                  height: 25.0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xffEA4477),
                                          Color(0xffFB84A7)
                                        ],
                                        tileMode: TileMode.decal,
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Use',
                                    style: TextStyle(color: ColorManager.white),
                                  ),
                                ),
                              ),
                          ],
                        )
                      ],
                    ));
              }),
            ),
          ),
        )),
      );
    });
  }

  _play(logic, index) async {
    _currentIndex.value = index;

    if (logic.downloadedAudio
        .contains(logic.createEventController.rxEventAudiosModel[index])) {
      _isPlaying.value = true;

      await logic.player
          .play(DeviceFileSource(logic.downloadedAudio[index].localPath!))
          .then((value) {
        _isPlaying.value = false;
      });
    } else {
      _isPlaying.value = true;
      await logic.player
          .play(UrlSource(
              logic.createEventController.rxEventAudiosModel[index].audio!))
          .then((value) {
        _isPlaying.value = false;
      });
    }
  }
}
