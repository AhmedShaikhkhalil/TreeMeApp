
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController{
  List<types.Message> messages = [];
  final user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  void addMessage(types.Message message) {

      messages.insert(0, message);
      update();

  }
  void handleAttachmentPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) =>
          SafeArea(
            child: SizedBox(
              height: 144,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleImageSelection();
                    },
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Photo'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // _handleFileSelection();
                    },
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('File'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: user,
        createdAt: DateTime
            .now()
            .millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      addMessage(message);
    }
  }
  void handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime
          .now()
          .millisecondsSinceEpoch,
      id: const Uuid().v4(),

      text: message.text,
    );

    addMessage(textMessage);
  }
  // void _handleMessageTap(BuildContext _, types.Message message) async {
  //   if (message is types.FileMessage) {
  //     var localPath = message.uri;
  //
  //     if (message.uri.startsWith('http')) {
  //       try {
  //         final index =
  //         messages.indexWhere((element) => element.id == message.id);
  //         final updatedMessage =
  //         (messages[index] as types.FileMessage).copyWith(
  //           isLoading: true,
  //         );
  //
  //
  //           messages[index] = updatedMessage;
  //
  //
  //         final client = http.Client();
  //         final request = await client.get(Uri.parse(message.uri));
  //         final bytes = request.bodyBytes;
  //         final documentsDir = (await getApplicationDocumentsDirectory()).path;
  //         localPath = '$documentsDir/${message.name}';
  //
  //         if (!File(localPath).existsSync()) {
  //           final file = File(localPath);
  //           await file.writeAsBytes(bytes);
  //         }
  //       } finally {
  //         final index =
  //         _messages.indexWhere((element) => element.id == message.id);
  //         final updatedMessage =
  //         (_messages[index] as types.FileMessage).copyWith(
  //           isLoading: null,
  //         );
  //
  //         setState(() {
  //           _messages[index] = updatedMessage;
  //         });
  //       }
  //     }
  //
  //     await OpenFile.open(localPath);
  //   }
  // }
}