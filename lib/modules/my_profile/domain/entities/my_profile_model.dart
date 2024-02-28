import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class MyProfileModel extends Equatable {
  final Widget? icon;
  final String? title;
  final Widget? trailing;
  final void Function()? onTap;

  const MyProfileModel(this.icon, this.title, this.trailing, this.onTap);

  @override
  // TODO: implement props
  List<Object?> get props => [icon, title, trailing];
}
