import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:treeme/core/helpers/constants.dart';
import 'package:treeme/core/resources/assets_manager.dart';
import 'package:treeme/core/resources/color_manager.dart';
import 'package:treeme/core/routes/app_routes.dart';
import 'package:treeme/core/utils/services/storage.dart';
import 'package:treeme/modules/my_profile/domain/entities/my_profile_model.dart';

import '../../../../core/netwrok/failure.dart';
import '../../../../core/utils/error_toast.dart';
import '../../../../core/utils/image_picker/i_image_file.dart';
import '../../../../core/utils/image_picker/i_image_picker.dart';
import '../../../../core/utils/image_picker/image_picker_input.dart';
import '../../../../core/utils/image_picker/image_source.dart';
import '../../data/data_sources/edit_profile_data_source.dart';
import '../../data/models/update_profile_model.dart';
import '../widgets/custom_switch_widget.dart';

class MyProfileController extends GetxController {
  RxBool notificationSwitch = true.obs;
  RxList<MyProfileModel> listProfile = <MyProfileModel>[].obs;
  final IImagePicker _iImagePicker;
  final IEditProfileDataSource _editProfileDataSource;

  MyProfileController(this._iImagePicker, this._editProfileDataSource);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    nameController.text = AppConfig.firstName ?? '';
    listProfile = [
      MyProfileModel(
          SvgPicture.asset(
            ImageAssets.editProfile,
            width: 40.w,
            height: 42.h,
            fit: BoxFit.cover,
          ),
          'Edit Profile',
          Icon(
            Icons.arrow_forward,
            color: ColorManager.goodMorning,
          ), () {
        Get.toNamed(AppRoutes.editProfile);
      }),
      MyProfileModel(
          SvgPicture.asset(
            ImageAssets.settingsProfile,
            width: 40.w,
            height: 42.h,
            fit: BoxFit.cover,
          ),
          'Settings',
          Icon(
            Icons.arrow_forward,
            color: ColorManager.goodMorning,
          ),
          null),
      MyProfileModel(
          SvgPicture.asset(
            ImageAssets.notificationProfile,
            width: 40.w,
            height: 42.h,
            fit: BoxFit.cover,
          ),
          'Notifications',
          switchNotification(),
          null),
      MyProfileModel(
        SvgPicture.asset(
          ImageAssets.logoutProfile,
          width: 40.w,
          height: 42.h,
          fit: BoxFit.cover,
        ),
        'Logout',
        null,
        () {
          Storage().erase();
          Get.offAllNamed(AppRoutes.login);
        },
      ),
      MyProfileModel(
        null,
        'Delete Account',
        null,
        () async {},
      ),
    ].obs;
  }

  Widget switchNotification() {
    return Obx(() {
      return CustomSwitch(
        onChanged: (bool value) {
          notificationSwitch.toggle();
          // value = notificationSwitch.value;
          print(notificationSwitch);
        },
        value: notificationSwitch.value,
      );
    });
  }

  final _havePickImage = Rx<bool?>(null);
  bool? get havePickImage => _havePickImage.value;
  set havePickImage(bool? newValue) => _havePickImage.value = newValue;

  final _filePickImage = Rx<IImageFile?>(null);
  IImageFile? get filePickImage => _filePickImage.value;
  set filePickImage(IImageFile? newValue) => _filePickImage.value = newValue;

  Future<void> pickImageDriverLicence() async {
    try {
      final IImageFile? pickedFile = await _iImagePicker.pickImage(
        input: const ImagePickerInput(
          source: ImageSource.gallery,
        ),
      );
      if (pickedFile != null) {
        filePickImage = pickedFile;
        havePickImage = true;
      }
    } catch (e, ex) {
      debugPrint(ex.toString());
    }
  }

  Future<void> updateProfile() async {
    final Either<Failure, UpdateProfileModel> update =
        await _editProfileDataSource.updateProfile(
            AppConfig.userId ?? Storage().userId ?? '',
            _filePickImage.value,
            ageController.text.trim(),
            nameController.text.trim());
    update.fold((l) => errorToast(l.message), (r) {
      successToast(r.message ?? 'update Profile Successfully');
      Storage().fistName = r.name;
      Storage().avatar = r.avatar;
      AppConfig.firstName = r.name;
      AppConfig.avatar = r.avatar;
    });
  }
}
