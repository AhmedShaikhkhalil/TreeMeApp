import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/page_loading.dart';

abstract class IPageLoadingDialog {
  PageLoadingDialogStatus showLoadingDialog();
}

class PageLoadingDialog implements IPageLoadingDialog {
  @override
  PageLoadingDialogStatus showLoadingDialog() {
    final Future<void> future = Get.dialog<void>(
      WillPopScope(
        child: const PageLoading(),
        onWillPop: () async => false,
      ),
      barrierDismissible: false,
    );

    return PageLoadingDialogStatus(future);
  }
}

class PageLoadingDialogStatus {
  PageLoadingDialogStatus(this._future) {
    _future.whenComplete(() => _isCompleted = true);
  }

  final Future<void> _future;
  bool _isCompleted = false;
  bool get isLoading => !_isCompleted;
  void hide() {
    if (_isCompleted) {
      return;
    }
    _isCompleted = true;
    Get.back<void>();
  }
}
