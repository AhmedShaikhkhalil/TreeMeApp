import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../resources/values_manager.dart';

class CachedLottieAnimation extends StatelessWidget {
  final String animationUrl;

  const CachedLottieAnimation({super.key, required this.animationUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: DefaultCacheManager().getSingleFile(animationUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Icon(Icons.error);
        } else {
          return Lottie.asset(
            snapshot.data!.path,
            width: AppSize.s20.w,
            height: AppSize.s20.h,
            fit: BoxFit.cover,
          );
        }
      },
    );
  }
}
