import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:treeme/modules/chat/domain/repositories/chat.dart';
import 'package:treeme/modules/contacts/data/data_sources/my_contact_data_source.dart';
import 'package:treeme/modules/contacts/data/models/contact_chat.dart';
import 'package:treeme/modules/contacts/data/models/my_contact_model.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/page_loading_dialog/page_loading_dialog.dart';
import '../../../../core/netwrok/failure.dart';
import '../../../../core/utils/error_toast.dart';
import '../../data/models/search_contact.dart';

class MyContactController extends GetxController {
  final IMyContactsDataSource _contactsDataSource;
  final requestStatus = RequestStatus.LOADING.obs;

  MyContactController(this._contactsDataSource, this.pageLoading);
  final IPageLoadingDialog pageLoading;
  final TextEditingController searchController = TextEditingController();
  // final _myContactModel = MyContactModel().obs;
  // Rx<MyContactModel?> get myContactModel => _myContactModel;
  final rxRequestStatus = RequestStatus.LOADING.obs;
  final rxRequestStatusSearch = RequestStatus.LOADING.obs;
  void setRxRequestStatus(RequestStatus _value) => rxRequestStatus.value = _value;
  void setRxRequestStatusSearch(RequestStatus _value) =>
      rxRequestStatusSearch.value = _value;

  final Rx<MyContactModel> rxMyContactModel = MyContactModel().obs;
  final Rx<SearchContact> rxMySearchContact = SearchContact().obs;
  void setRxGlobalSummary(MyContactModel value) => rxMyContactModel.value = value;
  void setRxSearch(SearchContact value) => rxMySearchContact.value = value;
  RxList<Data> contact = <Data>[].obs;
  RxBool isTyping = false.obs;
  @override
  void onInit() {
    super.onInit();
    getMyContact();
  }

  void isSearch() {
    print(isTyping.toString());
    isTyping.toggle();
    print(isTyping.toString());
  }

  Future<void> getMyContact() async {
    setRxRequestStatus(RequestStatus.LOADING);

    final Either<Failure, MyContactModel> myContact =
        await _contactsDataSource.getMyContact();
    myContact.fold((l) {
      setRxRequestStatus(RequestStatus.ERROR);

      log(l.message.toString());
      log(l.code.toString());
      // errorToast(l.message);
    }, (r) {
      log(r.toString());
      // r = _myContactModel.value;
      // r.data = contact.value;
      setRxGlobalSummary(r);
      setRxRequestStatus(RequestStatus.SUCESS);

      update();
      // print(_myContactModel.toString());
    });
  }

  Future<void> searchContact(String query) async {
    isTyping.value = true;
    setRxRequestStatusSearch(RequestStatus.LOADING);
    Either<Failure, SearchContact> searchContact =
        await _contactsDataSource.searchContact(query);
    searchContact.fold((l) {
      setRxRequestStatusSearch(RequestStatus.ERROR);

      log(l.message.toString());
      log(l.code.toString());
      // errorToast(l.message);
    }, (r) {
      log(r.toString());
      // r = _myContactModel.value;
      // r.data = contact.value;
      setRxSearch(r);
      setRxRequestStatusSearch(RequestStatus.SUCESS);

      update();
      // print(_myContactModel.toString());
    });
  }

  Future<void> sendMessage(String id,String image) async {
    final Either<Failure, ContactChat> message =
        await _contactsDataSource.createChatContact(id);
    message.fold((l) => errorToast(l.message), (r) {
      goToChat(r,image);
    });
  }

  Future<void> goToChat(ContactChat chat,String image) async {
    FirebaseChatCore.instance
        .setConfig(FirebaseChatCoreConfig(null, 'Conversation', 'Users'));
    Get.to(ChatPage(
        newRoom: true,
        room: Room(
            id: chat.documentId ?? '',
            type: RoomType.direct,
            users: [User(id: chat.firebaseUid ?? '',imageUrl: image)])));
  }

  Widget groupSeparatorBuilder(String status) {
    if (status == 'found') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Contact in Treeme'),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Invite to Treeme'),
      );
    }
  }

  int seprator(Data d1, Data d2) {
    switch (d1.status) {
      case 'found':
        return 1;
      case 'not found':
        return 2;
      default:
        return 2;
    }
  }
}
