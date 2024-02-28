// import 'dart:io';
//
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:treeme/core/resources/resource.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoPlayerWidget extends StatefulWidget {
//   final String videoFilePath;
//   const VideoPlayerWidget({Key? key, required this.videoFilePath})
//       : super(key: key);
//
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController videoPlayerController;
//   late ChewieController chewieController;
//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController =
//         VideoPlayerController.file(File(widget.videoFilePath));
//     videoPlayerController.initialize();
//     chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       autoPlay: true,
//       looping: true,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: AppSize.s261.h, child: Chewie(controller: chewieController));
//   }
// }
