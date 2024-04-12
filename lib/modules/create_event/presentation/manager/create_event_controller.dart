import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:treeme/core/routes/app_routes.dart';
import 'package:treeme/core/utils/error_toast.dart';
import 'package:treeme/core/utils/services/storage.dart';
import 'package:treeme/modules/contacts/presentation/manager/my_contact_controller.dart';
import 'package:treeme/modules/create_event/data/models/event_type_model.dart';

import '../../../../core/config/apis/config_api.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/netwrok/failure.dart';
import '../../../chat/domain/repositories/chat.dart';
import '../../../contacts/data/models/my_contact_model.dart';
import '../../data/data_sources/create_new_event_data_source.dart';
import '../../data/models/new_event_model.dart';

class CreateEventController extends GetxController {
  RxString chatID = ''.obs;

  RxBool isChecked = false.obs;
  final ICreateEventDataSource _createEventDataSource;
  final MyContactController contactController;
  RxString eventTime = ''.obs;
  RxString eventTypeID = ''.obs;
  RxString participants = '1,2'.obs;
  RxString urlMedia = ''.obs;
  RxInt OwnerID = 0.obs;
  RxBool eventTimeChange = false.obs;
  RxBool eventDateChange = false.obs;
  RxString eventDate = ''.obs;
  RxList<String> selsect = <String>[].obs;
  CreateEventController(this._createEventDataSource, this.contactController);
  final rxRequestStatus = RequestStatus.LOADING.obs;
  void setRxRequestStatus(RequestStatus value) => rxRequestStatus.value = value;

  final Rx<EventTypeModel> rxEventTypeModel = EventTypeModel().obs;
  void setRxEventType(EventTypeModel value) => rxEventTypeModel.value = value;

  final rxNewEventModelRequestStatus = RequestStatus.LOADING.obs;
  void setRxNewEventModelRequestStatus(RequestStatus value) =>
      rxRequestStatus.value = value;
  late final StreamSubscription myStream;

  final Rx<NewEventModel> rxNewEventModel = NewEventModel().obs;
  void setRxNewEventModel(NewEventModel _value) =>
      rxNewEventModel.value = _value;
  final TextEditingController titleTextEditingController =
      TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getTypeEvent();
  }

  Future<void> getTypeEvent() async {
    setRxRequestStatus(RequestStatus.LOADING);

    final Either<Failure, EventTypeModel> typeEvent =
        await _createEventDataSource.getTypeEvent();
    typeEvent.fold((l) {
      setRxRequestStatus(RequestStatus.ERROR);

      log(l.message.toString());
      log(l.code.toString());
      // errorToast(l.message);
    }, (r) {
      log(r.toString());
      // r = _myContactModel.value;
      // r.data = contact.value;
      setRxEventType(r);
      setRxRequestStatus(RequestStatus.SUCESS);
      update();
      // update(['myContact']);
      // print(_myContactModel.toString());
    });
  }

  Future<void> createNewEvent() async {
    setRxRequestStatus(RequestStatus.LOADING);
    final Either<Failure, NewEventModel> newEventApp =
        await _createEventDataSource.newEvent(
            titleTextEditingController.text.trim(),
            eventDate.value,
            eventTime.value,
            eventTypeID.value,
            AppConfig.userId ?? Storage().userId ?? '',
            participants.value);
    newEventApp.fold((l) {
      // setRxRequestStatus(RequestStatus.ERROR);
      errorToast(l.message);
    }, (r) async {
      successToast(r.message ?? '');
      chatID.value = r.documentId ?? '';

      // getRoom(r.documentId ?? '');
      // listUser(r.data!.userIds!);
      // Room room = await FirebaseChatCore.instance.createGroupRoom(
      //     name: r.data?.title ?? '',
      //     users: r.data!.participants!
      //         .where((element) => element.firebaseUid != null)
      //         .map((e) {
      //       print(e.firebaseUid.toString());
      //       return User(
      //           id: e.firebaseUid.toString(),
      //           firstName: e.name.toString(),
      //           imageUrl: e.avatar.toString());
      //     }).toList());
      // print(room.toString());

      // FirebaseFirestore.instance.to
      // var index = r.data!.participants!.indexOf;
      // print('index$index');
      // myStream = FirebaseChatCore.instance.rooms()
      // final room = await FirebaseChatCore.instance.createGroupRoom(
      //   name: r.data?.title ?? '',
      //   users: r.data!.userIds!
      //       .where((element) => element != null)
      //       .map((e) => User(id: e))
      //       .toList(),
      // );
      // FirebaseChatCore.instance.sendMessage(
      //     TextMessage(
      //       author: User(
      //         id: Storage().firebaseUID ?? '',
      //       ),
      //       createdAt: DateTime.now().millisecondsSinceEpoch,
      //       id: 'message-id-1',
      //       text: 'Hello!',
      //     ),
      //     r.documentId ?? '');
      // FirebaseChatCore.instance.getFirebaseFirestore().collection('${FirebaseChatCore.instance.config.roomsCollectionName}/${r.documentId}/').add;
      // FirebaseChatCore.instance
      //     .sendMessage(PartialText(text: 'Hello'), r.documentId ?? '');

      setRxNewEventModel(r);
      setRxNewEventModelRequestStatus(RequestStatus.SUCESS);
      Future.delayed(Duration(seconds: 2), () {
        FirebaseChatCore.instance
            .setConfig(FirebaseChatCoreConfig(null, 'EventApp', 'Users'));
        Get.offAll(
          // AppRoutes.navBar,
          ChatPage(
              newRoom: true,
              urlPinMassage: urlMedia.value,
              havePinMassage: true,
              room: Room(
                name: r.data!.title,
                id: r.documentId ?? '',
                type: RoomType.group,
                users: r.data!.userIds!.map((e) => User(id: e)).toList(),
              ),
              color: r.data?.eventColor),
          predicate: (route) => route.settings.name == AppRoutes.navBar,
        );
      });
    });
  }

  String imageUrl(List<Participants>? participants) {
    if (participants != null && participants.isNotEmpty == true) {
      for (var avatar in participants) {
        if (avatar != null) {
          return API.imageUrl(avatar.avatar);
        }
        return 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
      }
    }
    return 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
  }

  void isCheck(Data contactModel) {
    contactModel.isCheck.toggle();

    if (!selsect.value.contains(contactModel.userData?.id.toString()) &&
        contactModel.isCheck.value == true) {
      selsect.value.add(contactModel.userData!.id.toString());
    } else {
      selsect.value.removeWhere(
          (element) => element == contactModel.userData!.id.toString());
    }
    print(contactModel.userData?.id.toString());
    print(selsect.value.toString().replaceAll('[', '').replaceAll(']', ''));
    participants.value =
        selsect.value.toString().replaceAll('[', '').replaceAll(']', '');
    update();
    refresh();
  }

  // Room getRoom(String documentId){
  //   // User? firebaseUser = FirebaseAuth.instance.currentUser;
  //   // if (fu == null) return const Stream.empty();
  //   // final fu = firebaseUser;
  // final room =   FirebaseChatCore.instance.getFirebaseFirestore()
  //       .collection(FirebaseChatCore.instance.config.roomsCollectionName)
  //       .doc(documentId??'')
  //       .snapshots()
  //       .asyncMap(
  //         (doc) => processRoomDocument(
  //       doc,
  //           FirebaseAuth.instance.currentUser!,
  //           FirebaseChatCore.instance.getFirebaseFirestore(),
  //           FirebaseChatCore.instance.config.usersCollectionName,
  //     ),
  //   );
  //
  // }
  void isOwner(int value) {
    // contactModel.isCheck.toggle();
    // isChecked.toggle();
    OwnerID.value = value;
    refresh();
  }

  void onChangedGender(Object? v) {
    OwnerID.value = int.parse(v.toString());
    print(OwnerID.toString());
  }

  // void listUser(List<AllUsers>? users) {
  //   List<User> dwd = [];
  //   users?.forEach((element) {
  //     print(element.userType.toString());
  //     if (element.firebaseUid != null) {
  //       dwd.add(User(id: element.firebaseUid));
  //     }
  //   });
  //   var user = users?.where((element) => element.firebaseUid != null).map((e) {
  //     print(e.phone.toString());
  //     return User(
  //       id: e.firebaseUid.toString(),
  //     );
  //   }).toList();
  //   // print(user.toString());
  //   print('dwd ${dwd.toString()}');
  // }

  validate() {
    if (titleTextEditingController.text == '') {
      errorToast('Enter Title Event');
    } else if (eventDate.value == '') {
      errorToast('Enter Event Date');
    } else if (eventTime.value == '') {
      errorToast('Enter Event Time');
    } else {
      Get.toNamed(AppRoutes.selecetOwner);
    }
  }

  validateSelectOwner() {
    // if (OwnerID.value == 0) {
    //   errorToast('You Should Select the Owner ');
    // } else {
      Get.toNamed(AppRoutes.selectContactScreen);
    // }
  }

  // getRoom(String docs) async {
  //   final room = await FirebaseChatCore.instance.rooms();
  //   room.listen((event) {
  //     log(event.where((element) => element.id == docs).toString());
  //   });
  // }
  //
  // Stream<List<types.Room>> rooms({bool orderByUpdatedAt = false}) {
  //   final fu = FirebaseAuth.instance.currentUser;
  //
  //   if (fu == null) return const Stream.empty();
  //
  //   final collection = orderByUpdatedAt
  //       ? FirebaseChatCore.instance
  //           .getFirebaseFirestore()
  //           .collection(FirebaseChatCore.instance.config.roomsCollectionName)
  //           .where('userIds', arrayContains: fu.uid)
  //           .orderBy('updatedAt', descending: true)
  //       : FirebaseChatCore.instance
  //           .getFirebaseFirestore()
  //           .collection(FirebaseChatCore.instance.config.roomsCollectionName)
  //           .where('userIds', arrayContains: fu.uid);
  //
  //   return collection.snapshots().asyncMap(
  //         (query) => processRoomsQuery(
  //           fu,
  //           FirebaseChatCore.instance.getFirebaseFirestore(),
  //           query,
  //           FirebaseChatCore.instance.config.usersCollectionName,
  //         ),
  //       );
  // }
}
