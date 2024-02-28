


import 'package:get/get.dart';
import 'package:treeme/modules/chat/presentation/manager/chat_controller.dart';

class ChatBindings implements Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => ChatController());

  }

}