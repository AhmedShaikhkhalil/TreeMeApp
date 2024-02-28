import 'package:flutter/material.dart';

class ShowBottomSheetInput {
  ShowBottomSheetInput(
    this.bottomsheet, {
    this.backgroundColor,
    this.elevation,
    this.persistent = true,
    this.shape,
    this.clipBehavior,
    this.barrierColor,
    this.ignoreSafeArea,
    this.isScrollControlled = false,
    this.useRootNavigator = false,
    this.isDismissible = true,
    this.enableDrag = true,
    this.settings,
    this.enterBottomSheetDuration,
    this.exitBottomSheetDuration,
  });

  final Widget bottomsheet;
  final Color? backgroundColor;
  final double? elevation;
  final bool persistent;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final Color? barrierColor;
  final bool? ignoreSafeArea;
  final bool isScrollControlled;
  final bool useRootNavigator;
  final bool isDismissible;
  final bool enableDrag;
  final RouteSettings? settings;
  final Duration? enterBottomSheetDuration;
  final Duration? exitBottomSheetDuration;
}
