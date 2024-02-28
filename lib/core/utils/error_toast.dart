import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treeme/core/resources/styles_manager.dart';

void errorToast(String text) {
  log(text);
  Get.snackbar("", "",
      duration: Duration(seconds: 2),
      titleText: const SizedBox(),
      messageText: Row(
        children: [
          Expanded(
              child: Text(
            text,
            style: getRegularStyle(color: Colors.white),
          )),
          Icon(
            Icons.error,
            color: Colors.white,
          )
        ],
      ),
      snackStyle: SnackStyle.GROUNDED,
      margin: EdgeInsets.zero,
      backgroundColor: Colors.redAccent);
}

void successToast(String text, {String? title}) {
  Get.snackbar(title ?? "", '',
      duration: Duration(seconds: 2),
      titleText: const SizedBox(),
      messageText: Row(
        children: [
          Expanded(
              child: Text(
            text,
            style: getRegularStyle(color: Colors.white),
          )),
          Icon(
            Icons.check_circle,
            color: Colors.white,
          )
        ],
      ),
      snackStyle: SnackStyle.GROUNDED,
      margin: EdgeInsets.zero,
      backgroundColor: Colors.green);
  // Fluttertoast.showToast(
  //   msg: text,
  //   toastLength: Toast.LENGTH_SHORT,
  //   gravity: ToastGravity.BOTTOM,
  //   timeInSecForIosWeb: 2,
  //   backgroundColor: Colors.green[300],
  //   textColor: Colors.white,
  //   fontSize: 16.0,
  // );
}
