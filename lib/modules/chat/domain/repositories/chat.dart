import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' hide InputOptions;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_platform_interface.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:treeme/core/config/apis/config_api.dart';
import 'package:treeme/core/helpers/constants.dart';
import 'package:treeme/core/resources/resource.dart';
import 'package:treeme/core/utils/services/storage.dart';
import 'package:treeme/modules/chat/presentation/widgets/input_custom_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/netwrok/web_connection.dart';
import '../../presentation/widgets/pin_massage_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
    required this.newRoom,
    this.color,
    this.fcmUser,
    this.urlPinMassage,
    this.havePinMassage,
  });

  final types.Room room;
  final bool newRoom;
  final bool? havePinMassage;
  final String? color;
  final String? urlPinMassage;
  final List<String>? fcmUser;

  @override
  State<ChatPage> createState() {
    return _ChatPageState();
  }
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;

  // late types.Room room;
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();

  bool isRecorderReady = false;
  bool showPinMassage = false;
  String _filePath = '';
  String? filePath2;
  Duration durationAudio = Duration.zero;
  File? audioFile;

  Future record() async {
    if (!isRecorderReady) return;
    Directory directory = await getApplicationDocumentsDirectory();
    String filepath = directory.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.wav';
    _filePath = filepath;
    print(filepath.toString() + '7878787878787878787878');
    await recorder.startRecorder(
      toFile: filepath,
      codec: Codec.pcm16WAV,
    );
  }

  Future stop() async {
    if (!isRecorderReady) return;
    await recorder.stopRecorder();
    // await FirebaseStorage.instance.ref('TreeMe/ voice');
    //     .ref('upload-voice-firebase')
    //     .child(
    //     _filePath.substring(_filePath.lastIndexOf('/'), _filePath.length))
    //     .putFile(File(_filePath));
    final reference = await FirebaseStorage.instance.ref('TreeMe/ voice').child(
        _filePath.substring(_filePath.lastIndexOf('/'), _filePath.length));
    final name =
        _filePath.substring(_filePath.lastIndexOf('/'), _filePath.length);
    await reference.putFile(File(_filePath));
    final size = File(_filePath).lengthSync();
    final uri = await reference.getDownloadURL();
    final message = types.PartialAudio(
      duration: durationAudio,
      uri: uri,
      size: size,
      mimeType: lookupMimeType(_filePath),
      name: name,
    );
    sendMessageAudio(message, widget.room.id);
    // final uri = await reference.getDownloadURL();
    // _uploadRecordingToFirestore(filePath2!);
    // Provider.of<ConsultationViewModel>(context, listen: false).setIsStopRecording(true);
  }

  // void _uploadRecordingToFirestore(String filePath) async {
  //   final audioBytes = io.File(filePath).readAsBytesSync();
  //   final audioBase64 = base64Encode(audioBytes);
  //   print(audioBase64.length);
  //   audioFile = File(filePath);
  //   // final name = audioFile!.files.single.name;
  //   // final filePath = audioFile.files.single.path!;
  //   // final file = File(filePath);
  //   // final file = File(result.path);
  //   // final size = file.lengthSync();
  //   // final bytes = await result.readAsBytes();
  //   // final image = await decodeImageFromList(bytes);
  //   // final name = result.name;
  //   print('${audioFile?.path}');
  //   try {
  //     final reference = FirebaseStorage.instance.ref('TreeMe/ voice');
  //     await reference.putFile(io.File(filePath));
  //     final uri = await reference.getDownloadURL();
  //     final message = types.PartialAudio(
  //       duration:recorder. ,
  //       waveForm: ,
  //       uri: ,
  //       mimeType: lookupMimeType(filePath),
  //       name: 'voice',
  //     );
  //
  //     sendMessageAudio(, widget.room.id);
  //   }catch(e){
  //     print('$e');
  //   }
  // }
  Future<void> sendNotification(
    String fcmToken,
    String body,
  ) async {
    Response data = await Get.find<WebServiceConnections>().postFirebaseRequest(
        useMyPath: true,
        data: {
          'message': {
            // 'token': 'Bearer ya29.c.c0ASRK0GbA4VIWzEhTphCnhHzuDnkCeWfUJMnTQTeM8mymEkDlyKoZwDLRxJ0uBpWE3eNH2yfKle3vN0JaPrJaTu9RAnWQU2d1yefRzrWzRHwJ9_F8tY1azX_h0JX19IAY2El_D5QNTiCtDPomHXEY0VmtG5Gvs1_eYBNDSmvUS0HbbE1s1iStoUzLaYvnqDEI_6_opiGV_QnbWicAxpc-kQma1bJdmipyG1JWO_xCbY84az81ZFB4ZE7qlnJvt-YCtcF0hnDHI0SOzgvz5gg40C4pJmdzRIWRC16pgJVdekri9yaYCar_GdwXVsqod6e0BMNm_dWguCIotzYSWiswm_j5Yj22MnvLLC50xyY0wvgQsWnljI9vvY8tKAT387Ameuy2JgykhjdlF_Qe6qfBgY6gJVRFfmrQJFj4Xqmt9kIQVYXjVWisl_JjF2iw8UWd2ar8a6M31u7By8MIvbkgxUjvxYicZjdYSkUYWmyXfymXrpd1jFZMhl0Rs4qq67kSIrcFdVOXYiFJIM86zzJn5aklRye0-hsR0h-90fRrM8UYbJn-59hWORg98c1byUB1FOqOkkkO8_wqRvh_1Swa8aJXV0anRc5Rdn5FU6nWn3zzBOJVQ43_4zZktbhhm0Yhah0ud2_n_tbJhu_VjOlt26gW7iVl7iXfrs1zIfJhQF80z7xSn8RswQlkitu8dj8Yt_jndyUtnFJw8q9Rd1SweWQ1WopgIyzJMmubUviQ2Y0uyvwn-UmSndF8Q7foSz1O4rxkjvhskYFR_6QoUUmMxkhY8M41fqZnz3BZ69kbQU3zxax6zunv0nQvjii1zI0F5-SggwaI92QbQx2x06BIo9OmBFdB6rmet1tR298Bifya-yhZipqna01IbVIx7IezaaUVV8__byduq6ZRMMwFfRWIitovo82w4MU0gWX7ZzcaugW46Sv5o_XWyfVcda0lbkRpv4vBF-ghtidSWgdhj6ua9zz-kXXnScSQh755mOp2_5hbu2plUZ2',
           // 'token': 'd-tnab5Odkzel58wW8Vs6H:APA91bG78vB5L6R1iP8Ou1PSK5ys_jEMfQMAbk_d6W__saahvpGcWlE3r7Ou-uCdXNdumKKSJoujFiuOqh2Nsvvky4vxyod5YXi2ys8GqA8aNYf5seVDeE8bvQGyjTel6-HuEBHfIAyE',
            'token': fcmToken,
            'notification': {
              'body': body,
              'title': AppConfig.firstName,
            }
          }
        },
        // path: 'https://fcm.googleapis.com/fcm/send');
        path:
            'https://fcm.googleapis.com/v1/projects/treeme-chat/messages:send');

    print(data.data.toString());
  }

  /**
      Future<void> sendNotification(
      String fcmToken,
      String body,
      ) async {
      Response data = await Get.find<WebServiceConnections>().postFirebaseRequest(
      useMyPath: true,
      data: {
      "to": fcmToken,
      "notification": {"body": body, "title": AppConfig.firstName},
      },
      // path: 'https://fcm.googleapis.com/fcm/send');
      path: 'https://fcm.googleapis.com/v1/projects/treeme-chat/messages:send');

      print(data.data.toString());
      }
   **/

  initRecorder() async {
    final status = await Permission.microphone.request();
    final status2 = await Permission.storage.request();
    if (status != PermissionStatus.granted &&
        status2 != PermissionStatus.granted) {
      throw 'microphone permission not granted';
    }

    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 100),
    );
    record();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.havePinMassage == true) {
      setState(() {});
    }
    sendPinMassage();
    // FirebaseChatCore.instance.sendMessage(
    //   'Hello',
    //   widget.room.id,
    // );
  }

  void sendPinMassage() async {
    if (widget.newRoom && widget.urlPinMassage != null) {
      File result = File('${widget.urlPinMassage}');

      if (result != null) {
        _setAttachmentUploading(true);
        final size = result.lengthSync();
        // final bytes = await result.readAsBytes();
        // final image = await decodeImageFromList(bytes);

        final videoFile = File(widget.urlPinMassage!);
        VideoPlayerController controller =
            VideoPlayerController.file(videoFile);
        final name = result.uri.pathSegments.last;

        UploadTask uploadTask;

        try {
          final reference =
              FirebaseStorage.instance.ref().child('TreeMe').child('/$name');
          uploadTask = reference.putData(await result.readAsBytes());
          final uri = await (await uploadTask).ref.getDownloadURL();

          final message = types.PartialVideo(
            height: controller.value.size.height,
            name: name,
            size: size,
            uri: uri,
            width: controller.value.size.width,
          );

          sendMessage(message, widget.room.id, true);
          _setAttachmentUploading(false);
        } finally {
          _setAttachmentUploading(false);
        }
      }
    }
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
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
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendMessageAudio(dynamic partialMessage, String roomId) async {
    if (FirebaseAuth.instance.currentUser == null) return;
    print('ssss$partialMessage');
    types.Message? message;

    if (partialMessage is types.PartialAudio) {
      message = types.AudioMessage.fromPartial(
          author: types.User(id: FirebaseAuth.instance.currentUser!.uid),
          id: '',
          partialAudio: partialMessage,
          showStatus: true,
          status: types.Status.delivered);
    }

    if (message != null) {
      final messageMap = message.toJson();
      messageMap.removeWhere((key, value) => key == 'author' || key == 'id');
      messageMap['authorId'] = FirebaseAuth.instance.currentUser!.uid;
      messageMap['createdAt'] = FieldValue.serverTimestamp();
      messageMap['updatedAt'] = FieldValue.serverTimestamp();

      await FirebaseChatCore.instance
          .getFirebaseFirestore()
          .collection(
              '${FirebaseChatCore.instance.config.roomsCollectionName}/$roomId/messages')
          .add(messageMap);

      await FirebaseChatCore.instance
          .getFirebaseFirestore()
          .collection(FirebaseChatCore.instance.config.roomsCollectionName)
          .doc(roomId)
          .update({'updatedAt': FieldValue.serverTimestamp()});
    }
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      _setAttachmentUploading(true);
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);
      UploadTask uploadTask;
      try {
        final reference =
            FirebaseStorage.instance.ref().child('TreeMe').child('/$name');
        uploadTask = reference.putData(await file.readAsBytes());
        final uri = await (await uploadTask).ref.getDownloadURL();

        final message = types.PartialFile(
          mimeType: lookupMimeType(filePath),
          name: name,
          size: result.files.single.size,
          uri: uri,
        );

        sendMessage(message, widget.room.id, null);
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      UploadTask uploadTask;
      try {
        final reference =
            FirebaseStorage.instance.ref().child('TreeMe').child('/$name');
        uploadTask = reference.putData(await file.readAsBytes());
        final uri = await (await uploadTask).ref.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        sendMessage(message, widget.room.id, null);
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );
        }
      }

      await OpenFilex.open(localPath);
    }
    if (message is types.AudioMessage) {
      print('saasa$message');
      var localPath = message.uri;

      if (message.uri.startsWith('https')) {
        try {
          final updatedMessage = message.copyWith();
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir${message.name}';
          print('localPath$localPath');
          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
          // await audioPlayer.setReleaseMode(ReleaseMode.loop);
        } finally {
          final updatedMessage = message.copyWith();
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );
        }
      }
      print(localPath);
      // await audioPlayer.setSourceDeviceFile(
      //   localPath,
      // );
      // audioPlayer.play(DeviceFileSource(localPath));
      // await audioPlayer.setSourceDeviceFile(
      //   localPath,
      // );
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    print('sssssssss');
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void updateMessage(types.Message message, String roomId) async {
    if (FirebaseAuth.instance.currentUser == null) return;
    if (message.author.id != FirebaseAuth.instance.currentUser!.uid) return;

    final messageMap = message.toJson();
    messageMap.removeWhere(
      (key, value) => key == 'author' || key == 'createdAt' || key == 'id',
    );
    messageMap['authorId'] = message.author.id;
    messageMap['updatedAt'] = FieldValue.serverTimestamp();

    await FirebaseChatCore.instance
        .getFirebaseFirestore()
        .collection(
            '${FirebaseChatCore.instance..config.roomsCollectionName}/$roomId/messages')
        .doc(message.id)
        .update(messageMap);
  }

  void sendMessage(dynamic partialMessage, String roomId, bool? isPin) async {

    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.currentUser?.reload();
    }
    if (FirebaseAuth.instance.currentUser == null) {return;}

    types.Message? message;

    if (partialMessage is types.PartialCustom) {
      message = types.CustomMessage.fromPartial(
          author: types.User(id: FirebaseAuth.instance.currentUser!.uid),
          id: '',
          partialCustom: partialMessage,
          showStatus: true,
          status: types.Status.sent);
    } else if (partialMessage is types.PartialFile) {
      message = types.FileMessage.fromPartial(
          author: types.User(id: FirebaseAuth.instance.currentUser!.uid),
          id: '',
          partialFile: partialMessage,
          showStatus: true,
          status: types.Status.sent);
    } else if (partialMessage is types.PartialImage) {
      message = types.ImageMessage.fromPartial(
          author: types.User(id: FirebaseAuth.instance.currentUser!.uid),
          id: '',
          remoteId: isPin != null ? 'Pin' : '',
          partialImage: partialMessage,
          showStatus: true,
          status: types.Status.sent);
    } else if (partialMessage is types.PartialText) {
      message = types.TextMessage.fromPartial(
          author: types.User(id: FirebaseAuth.instance.currentUser!.uid),
          id: '',
          partialText: partialMessage,
          showStatus: true,
          status: types.Status.sent);
    }
    print('room Collection' +
        FirebaseChatCore.instance.config.roomsCollectionName);
    print(roomId);
    if (message != null) {
      final messageMap = message.toJson();
      messageMap.removeWhere((key, value) => key == 'author' || key == 'id');
      messageMap['authorId'] = FirebaseAuth.instance.currentUser!.uid;
      messageMap['createdAt'] = FieldValue.serverTimestamp();
      messageMap['updatedAt'] = FieldValue.serverTimestamp();
      await FirebaseChatCore.instance
          .getFirebaseFirestore()
          .collection(
              '${FirebaseChatCore.instance.config.roomsCollectionName}/$roomId/messages')
          .add(messageMap);

      await FirebaseChatCore.instance
          .getFirebaseFirestore()
          .collection(FirebaseChatCore.instance.config.roomsCollectionName)
          .doc(roomId)
          .update({'updatedAt': FieldValue.serverTimestamp()});
    }
  }

  static Status _parseStatus(String statusString) {
    return Status.values.firstWhere(
      (status) => status.toString() == 'Status.$statusString',
      orElse: () => Status
          .sent, // Default value if the string doesn't match any enum value
    );
  }

  void _handleSendPressed(types.PartialText message) {

    List<String> testFcm =
    ['Bearer ya29.c.c0ASRK0GZV_gscQbu_YcXKQrF8C9gN3ZmI8xcnHDCI-Cp3SJzIXKwTerix7KP-WK-ADPBJr0l05O0ufrmhyGaOyLuAboqo2SnkodA5yOXVh05PqgsoXwZK1c4MIS1rrUHTMOpdV0S-SgPjxvlA4gpPWs8Xkn0L7xChPX9uKlaEW4ly74LhsOo7mEk_7Hll1rSQNotREjpnE3PopyaNoIvymQuJAOxX7rvpt3sGFBZnJBmCtikhleguSDhxyAUtdGdTlh9QMVfngvn_EjAI2h93_6nufwam4K1TdL44LMY9yGFRzB_eNiN6IOLbeK4e-IMe83g4BOSKW1YNahSijkPbXMqCzO6hnim0HcXNOaeDir0ZfAmZhaZrKneigQE387PZUv0O1aV437o5zbVhyOiR_lMk_z_prfnkUY5Wk_WxQFx8YsIuYV-dtjXzfsR9bmUnal1-W0qX42OjVbVfSuw3nFrS3VFZvgI0rFdJiMvdqOXZ21BZkhs0l80ji5wmWawZ6WS8RO946xs4Sc65qYg9ucgX3fbowJ0Rhb9knWiJWFtb4_wOZdUgu1OZI7jaWJxdRtz5VVl9dBy0oan41FUqoOkmMOJX-Jtdt19doOldOX-_xg4nUv3n-7IfgR5ZqRgQOlkphaYVrR610Sfphf1MW7kaXfJOyBqVU-SQmeogIYh_7fdhf4fy_MI_uMmSOUym5c-80oc0ZRb8pQdgvqh7ygh7118sFFcIjFnfSmu2O88OgyIQu5O_j5uZnbe5VtbnSJzhBO66BSlgtrpQxuzwsO56Zje7nukfyhn5aasRu6gjxnZaFIoo0nbfOIy8bo-oOqkq1o0J70M1i4evZvVIY_oIZOvjpvwMOpUaU_wd8q4OmOZ0F_k6Up24dOd3bZS9vMiXlBsa14flcY4dca2gnXcxeSncVw0da5WxtwXQ01axqJM63YXUxb900Vc84lb057nx9WyMaBmgyMw1J9OM2sQJZx4eg6B0yv0k85YjVzegyjfzlhFFQB1',
      'Bearer ya29.c.c0ASRK0GZV_gscQbu_YcXKQrF8C9gN3ZmI8xcnHDCI-Cp3SJzIXKwTerix7KP-WK-ADPBJr0l05O0ufrmhyGaOyLuAboqo2SnkodA5yOXVh05PqgsoXwZK1c4MIS1rrUHTMOpdV0S-SgPjxvlA4gpPWs8Xkn0L7xChPX9uKlaEW4ly74LhsOo7mEk_7Hll1rSQNotREjpnE3PopyaNoIvymQuJAOxX7rvpt3sGFBZnJBmCtikhleguSDhxyAUtdGdTlh9QMVfngvn_EjAI2h93_6nufwam4K1TdL44LMY9yGFRzB_eNiN6IOLbeK4e-IMe83g4BOSKW1YNahSijkPbXMqCzO6hnim0HcXNOaeDir0ZfAmZhaZrKneigQE387PZUv0O1aV437o5zbVhyOiR_lMk_z_prfnkUY5Wk_WxQFx8YsIuYV-dtjXzfsR9bmUnal1-W0qX42OjVbVfSuw3nFrS3VFZvgI0rFdJiMvdqOXZ21BZkhs0l80ji5wmWawZ6WS8RO946xs4Sc65qYg9ucgX3fbowJ0Rhb9knWiJWFtb4_wOZdUgu1OZI7jaWJxdRtz5VVl9dBy0oan41FUqoOkmMOJX-Jtdt19doOldOX-_xg4nUv3n-7IfgR5ZqRgQOlkphaYVrR610Sfphf1MW7kaXfJOyBqVU-SQmeogIYh_7fdhf4fy_MI_uMmSOUym5c-80oc0ZRb8pQdgvqh7ygh7118sFFcIjFnfSmu2O88OgyIQu5O_j5uZnbe5VtbnSJzhBO66BSlgtrpQxuzwsO56Zje7nukfyhn5aasRu6gjxnZaFIoo0nbfOIy8bo-oOqkq1o0J70M1i4evZvVIY_oIZOvjpvwMOpUaU_wd8q4OmOZ0F_k6Up24dOd3bZS9vMiXlBsa14flcY4dca2gnXcxeSncVw0da5WxtwXQ01axqJM63YXUxb900Vc84lb057nx9WyMaBmgyMw1J9OM2sQJZx4eg6B0yv0k85YjVzegyjfzlhFFQB1',
      'Bearer ya29.c.c0ASRK0GZV_gscQbu_YcXKQrF8C9gN3ZmI8xcnHDCI-Cp3SJzIXKwTerix7KP-WK-ADPBJr0l05O0ufrmhyGaOyLuAboqo2SnkodA5yOXVh05PqgsoXwZK1c4MIS1rrUHTMOpdV0S-SgPjxvlA4gpPWs8Xkn0L7xChPX9uKlaEW4ly74LhsOo7mEk_7Hll1rSQNotREjpnE3PopyaNoIvymQuJAOxX7rvpt3sGFBZnJBmCtikhleguSDhxyAUtdGdTlh9QMVfngvn_EjAI2h93_6nufwam4K1TdL44LMY9yGFRzB_eNiN6IOLbeK4e-IMe83g4BOSKW1YNahSijkPbXMqCzO6hnim0HcXNOaeDir0ZfAmZhaZrKneigQE387PZUv0O1aV437o5zbVhyOiR_lMk_z_prfnkUY5Wk_WxQFx8YsIuYV-dtjXzfsR9bmUnal1-W0qX42OjVbVfSuw3nFrS3VFZvgI0rFdJiMvdqOXZ21BZkhs0l80ji5wmWawZ6WS8RO946xs4Sc65qYg9ucgX3fbowJ0Rhb9knWiJWFtb4_wOZdUgu1OZI7jaWJxdRtz5VVl9dBy0oan41FUqoOkmMOJX-Jtdt19doOldOX-_xg4nUv3n-7IfgR5ZqRgQOlkphaYVrR610Sfphf1MW7kaXfJOyBqVU-SQmeogIYh_7fdhf4fy_MI_uMmSOUym5c-80oc0ZRb8pQdgvqh7ygh7118sFFcIjFnfSmu2O88OgyIQu5O_j5uZnbe5VtbnSJzhBO66BSlgtrpQxuzwsO56Zje7nukfyhn5aasRu6gjxnZaFIoo0nbfOIy8bo-oOqkq1o0J70M1i4evZvVIY_oIZOvjpvwMOpUaU_wd8q4OmOZ0F_k6Up24dOd3bZS9vMiXlBsa14flcY4dca2gnXcxeSncVw0da5WxtwXQ01axqJM63YXUxb900Vc84lb057nx9WyMaBmgyMw1J9OM2sQJZx4eg6B0yv0k85YjVzegyjfzlhFFQB1',

    ];
      //'d-tnab5Odkzel58wW8Vs6H:APA91bG78vB5L6R1iP8Ou1PSK5ys_jEMfQMAbk_d6W__saahvpGcWlE3r7Ou-uCdXNdumKKSJoujFiuOqh2Nsvvky4vxyod5YXi2ys8GqA8aNYf5seVDeE8bvQGyjTel6-HuEBHfIAyE',
    // ['d-tnab5Odkzel58wW8Vs6H:APA91bG78vB5L6R1iP8Ou1PSK5ys_jEMfQMAbk_d6W__saahvpGcWlE3r7Ou-uCdXNdumKKSJoujFiuOqh2Nsvvky4vxyod5YXi2ys8GqA8aNYf5seVDeE8bvQGyjTel6-HuEBHfIAyE',
      // 'd-tnab5Odkzel58wW8Vs6H:APA91bG78vB5L6R1iP8Ou1PSK5ys_jEMfQMAbk_d6W__saahvpGcWlE3r7Ou-uCdXNdumKKSJoujFiuOqh2Nsvvky4vxyod5YXi2ys8GqA8aNYf5seVDeE8bvQGyjTel6-HuEBHfIAyE'];
     //'daJ9tGFlD0_ssUXFS5csrv:APA91bFv64ahS4qN44VcJHrDQ-nwSI9YRs3XakUTA0-yjWAO_1mNiR-23j6eD9f-Yvf96IoF0cI7LNu373-mkbjV9sR9zfOfRJQterPDyM5unZnvVk8tLA-c5MrFos_tJznobpoOUsgj',
     //'dKMLL6XBCEtrl0GF9wN-kD:APA91bG1cCI4_V-5vU1KfodW6J4RFcRMFHqYbIZpLRQhpJQ5Ae049lwDYHVI9gFT6DpFMk2e648qSAZHrJkyC1Nv6v_1fRqg1WrbusQ63elyPM96twJyYox4Y_qn9yBiRwRVkgbcVRFF'];
      // 'd-tnab5Odkzel58wW8Vs6H:APA91bG78vB5L6R1iP8Ou1PSK5ys_jEMfQMAbk_d6W__saahvpGcWlE3r7Ou-uCdXNdumKKSJoujFiuOqh2Nsvvky4vxyod5YXi2ys8GqA8aNYf5seVDeE8bvQGyjTel6-HuEBHfIAyE'];
      // 'fkvOuiFcQ0qPyKg-uemD8p:APA91bH4xTknxhmZIbytcLYQa95qrWD97EkRK2MucQwLN_Z1ZTDCAuUU4fFt7TiRw5sg5IqM75IJ8H6UC4u5Dl9G85HKLoYRNpNwUIeCIttd-gsbac5YmAD5rv-tBvRas0BJJ5m7Ynp8'];

    print('here fcm');
    print(widget.fcmUser.isNullOrBlank);
    print(message.text);

    sendMessage(message, widget.room.id, null);

    print(widget.fcmUser);

    if (widget.fcmUser != null) {
      print('first one');
      log(widget.fcmUser!.first);
      print('last one');
      log(widget.fcmUser!.last);

      // testFcm.forEach((element) {
      //   sendNotification(element ?? '', message.text);
      // });

      widget.fcmUser?.forEach((element) {
        sendNotification(element ?? '', message.text);
      });
    }
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  Widget _bubbleBuilder(
    Widget child, {
    required types.Message message,
    required nextMessageInGroup,
  }) =>
      Bubble(
        color: Storage().firebaseUID != message.author.id ||
                message.type == types.MessageType.image
            ? const Color(0xfff5f5f7)
            : message.type == types.MessageType.audio
                ? Colors.transparent
                : widget.color != null
                    ? widget.color!
                        .split(',')
                        .map((e) => HexColor.fromHex(e))
                        .toList()
                        .first
                    : ColorManager.mainColor,
        margin: nextMessageInGroup
            ? const BubbleEdges.symmetric(horizontal: 6)
            : null,
        nip: nextMessageInGroup
            ? BubbleNip.no
            : Storage().firebaseUID != message.author.id
                ? BubbleNip.leftBottom
                : BubbleNip.rightBottom,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: widget.color != null
            ? widget.color!
                .split(',')
                .map((e) => HexColor.fromHex(e))
                .toList()
                .first
            : ColorManager.mainColor,
        title: Text(widget.room.name ?? 'Chat'),

        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         print(FirebaseChatCore.instance.messages(widget.room).toString());
        //       },
        //       icon: Icon(Icons.wallet))
        // ],
      ),
      body: StreamBuilder<types.Room>(
        initialData: widget.room,
        stream: FirebaseChatCore.instance.room(widget.room.id),
        builder: (context, snapshot) {
          print('inside chat');
          log(snapshot.data.toString());
          try {
            return Stack(
              children: [
                StreamBuilder<List<types.Message>>(
                  initialData: const <types.Message>[],
                  stream: FirebaseChatCore.instance.messages(widget.room),
                  builder: (context, snapshot) {
                    print('inside 2');
                    print(FirebaseChatCore.instance.messages(widget.room).length);
                    print(snapshot.data);
                    print(snapshot.hasData);
                    print(snapshot.hasError);
                    print(snapshot.error);
                    return Chat(
                      // audioMessageBuilder: (p0, {messageWidth}) {
                      //   return Lottie.network('${p0}',
                      //       animate: true, delegates: LottieDelegates());
                      // },

                      isAttachmentUploading: _isAttachmentUploading,
                      messages: snapshot.data ?? [],
                      onAttachmentPressed: _handleAtachmentPressed,
                      onMessageTap: _handleMessageTap,

                      showUserAvatars: true,
                      onMessageVisibilityChanged: (p0, visible) {
                        log('author ${visible.toString()}');
                        log('author ${p0.author.id.toString()}');
                        log('firebaseUID ${Storage().firebaseUID.toString()}');
                        if (!visible) {
                          final updatedMessage = p0.copyWith(
                              author: p0.author,
                              id: p0.id,
                              showStatus: true,
                              status: types.Status.seen);
                          FirebaseChatCore.instance
                              .updateMessage(updatedMessage, widget.room.id);
                        }
                      },

                      // listBottomWidget: Container(
                      //   color: Colors.redAccent,
                      // ),
                      // customBottomWidget: Container(
                      //     // color: Colors.red,
                      //     // height: 20,
                      //     ),
                      theme: DefaultChatTheme(
                          attachmentButtonIcon: recorder.isRecording
                              ? StreamBuilder<RecordingDisposition>(
                                  stream: recorder.onProgress,
                                  builder: (context, snapshot) {
                                    final duration = snapshot.hasData
                                        ? snapshot.data!.duration
                                        : Duration.zero;
                                    String towDidits(int n) =>
                                        n.toString().padLeft(0);
                                    final towDiditsMinutes = towDidits(
                                        duration.inMinutes.remainder(60));
                                    final towDiditsSecond = towDidits(
                                        duration.inSeconds.remainder(60));
                                    durationAudio = snapshot.data!.duration;
                                    if (duration.inMinutes == 1) {
                                      stop();
                                      setState(() {});
                                      durationAudio = snapshot.data!.duration;
                                    }

                                    return Text(
                                      '$towDiditsMinutes:$towDiditsSecond',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: ColorManager.mainColor,
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: widget.color == null
                                            ? [
                                                ColorManager.mainColor,
                                                ColorManager.gradiantSplash
                                              ]
                                            : widget.color!
                                                .split(',')
                                                .map((e) => HexColor.fromHex(e))
                                                .toList(),
                                        tileMode: TileMode.decal,
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      shape: BoxShape.circle),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                          inputContainerDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: const Color(0xffF7F7F7),
                          // attachmentButtonMargin: EdgeInsets.zero,
                          inputTextColor: Colors.black,
                          sendButtonMargin: EdgeInsets.zero,
                          sendButtonIcon:
                              SvgPicture.asset(ImageAssets.sendButton),
                          inputTextDecoration: InputDecoration(
                              hintText: 'Type Your massage',
                              enabled: true,
                              hintStyle: getBoldStyle(
                                  color: const Color(0xff8D96A5)))),
                      l10n: const ChatL10nEn(
                        inputPlaceholder: 'Type Your massage',
                        unreadMessagesLabel: "Unread messages",
                      ),

                      customBottomWidget: InputCustomWidget(
                          customWidget: IconButton(
                            constraints: const BoxConstraints(
                              minHeight: 24,
                              minWidth: 24,
                            ),
                            icon: Icon(
                              recorder.isRecording ? Icons.stop : Icons.mic,
                              color: widget.color != null
                                  ? widget.color!
                                      .split(',')
                                      .map((e) => HexColor.fromHex(e))
                                      .toList()
                                      .first
                                  : ColorManager.mainColor,
                            ),
                            onPressed: () async {
                              if (recorder.isRecording) {
                                await stop();
                              } else {
                                await initRecorder();
                              }
                              setState(() {});
                            },
                            splashRadius: 24,
                          ),
                          options: const InputOptions(
                              enableSuggestions: true,
                              sendButtonVisibilityMode:
                                  SendButtonVisibilityMode.editing),
                          onSendPressed: _handleSendPressed,
                          onAttachmentPressed: _handleAtachmentPressed),
                      showUserNames: true,
                      typingIndicatorOptions: const TypingIndicatorOptions(),
                      // disableImageGallery: true,
                      bubbleBuilder: _bubbleBuilder,
                      onPreviewDataFetched: _handlePreviewDataFetched,
                      onSendPressed: _handleSendPressed,
                      audioMessageBuilder: (p0, {required messageWidth}) {
                        // var audioPlayer = AudioPlayer();
                        // return Message(emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
                        //   hideBackgroundOnEmojiMessages: true, message: AudioMessage(author: p0.author, duration: p0.duration, id: p0.id, name: p0.name, size: p0.size, uri:p0.uri), messageWidth: messageWidth, roundBorder: null, showAvatar: null, showName: null, showStatus: null, showUserAvatars: null, textMessageOptions: null, usePreviewData: null,);

                        return audioWidget(
                          p0: p0,
                        );
                        // Lottie.asset(
                        //   'ssss',
                        // );
                      },

                      user: types.User(
                        id: Storage().firebaseUID ?? '',
                        imageUrl: AppConfig.avatar == null
                            ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                            : API.imageUrl(AppConfig.avatar!),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Visibility(
                    visible: widget.havePinMassage == true,
                    child: Visibility(
                      visible: showPinMassage,
                      replacement: AnimatedContainer(
                        height: 50,
                        decoration: BoxDecoration(
                            color: widget.color != null
                                ? widget.color!
                                    .split(',')
                                    .map((e) => HexColor.fromHex(e))
                                    .toList()
                                    .first
                                : ColorManager.mainColor,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(120),
                                bottomLeft: Radius.circular(120))),
                        duration: const Duration(
                            milliseconds: 250), // Animation speed
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showPinMassage = !showPinMassage;
                              });
                            },
                            child: Image.asset(
                              'assets/images/play_image.png',
                              color: Colors.white,
                              scale: 4,
                            )),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PinMassageWidget(
                            id: widget.room.id,
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showPinMassage = !showPinMassage;
                                });
                              },
                              child: Container(
                                  height: 50.h,
                                  width: 50.h,
                                  margin: const EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.color != null
                                        ? widget.color!
                                            .split(',')
                                            .map((e) => HexColor.fromHex(e))
                                            .toList()
                                            .first
                                        : ColorManager.mainColor,
                                  ),
                                  child: const Icon(Icons.arrow_upward)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } catch (e) {
            print(e.toString());
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<List<types.Message>> messages(
    types.Room room, {
    List<Object?>? endAt,
    List<Object?>? endBefore,
    int? limit,
    List<Object?>? startAfter,
    List<Object?>? startAt,
  }) {
    Query<Map<String, dynamic>> query = FirebaseChatCore.instance
        .getFirebaseFirestore()
        .collection('${'EventApp'}/${room.id}/messages')
        .orderBy('createdAt', descending: true);
    if (endAt != null) {
      query = query.endAt(endAt);
    }

    if (endBefore != null) {
      query = query.endBefore(endBefore);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    if (startAfter != null) {
      query = query.startAfter(startAfter);
    }

    if (startAt != null) {
      query = query.startAt(startAt);
    }

    return query.snapshots().map(
          (snapshot) => snapshot.docs.fold<List<types.Message>>(
            [],
            (previousValue, doc) {
              final data = doc.data();
              final author = room.users.firstWhere(
                (u) => u.id == data['authorId'],
                orElse: () => types.User(id: data['authorId'] as String),
              );

              data['author'] = author.toJson();
              data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
              data['id'] = doc.id;
              data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

              return [...previousValue, types.Message.fromJson(data)];
            },
          ),
        );
  }
}

class audioWidget extends StatefulWidget {
  const audioWidget({
    super.key,
    required this.p0,
  });

  final types.AudioMessage p0;

  @override
  State<audioWidget> createState() => _audioWidgetState();
}

class _audioWidgetState extends State<audioWidget>
    with SingleTickerProviderStateMixin {
  final audioPlayer = AudioPlayer();
  late final AnimationController _controller;
  bool isPlaying = false;
  bool paused = false;
  bool completed = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // Set a small initial duration
    );
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String towDidits(int n) => n.toString().padLeft(0);
    final towDiditsMinutes =
        towDidits(widget.p0.duration.inMinutes.remainder(60));
    final towDiditsSecond =
        towDidits(widget.p0.duration.inSeconds.remainder(60));
    return Container(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Lottie.network(
            'https://assets2.lottiefiles.com/packages/lf20_vatpKHGdo4.json',
            controller: _controller,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                      // _controller.stop();
                    } else {
                      await audioPlayer.play(UrlSource(widget.p0.uri));
                      // _controller.forward();
                    }
                    if (mounted) {
                      setState(() {
                        audioPlayer.onPlayerStateChanged.listen((state) {
                          if (mounted) {
                            setState(() {
                              isPlaying = state == PlayerState.playing;
                              paused = state == PlayerState.paused;
                              completed = state == PlayerState.completed;
                            });
                          }
                        });
                        audioPlayer.onDurationChanged.listen((newDuration) {
                          if (mounted) {
                            setState(() {
                              duration = newDuration;
                            });
                            _controller.duration = newDuration;
                          }
                        });
                        audioPlayer.onPositionChanged.listen((newPostion) {
                          if (mounted) {
                            setState(() {
                              position = newPostion;
                            });
                          }
                        });
                      });
                    }
                  },
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow_sharp,
                  ),
                ),
                Text(
                  isPlaying || paused
                      ? '${position.inMinutes}:${position.inSeconds}'
                      : '$towDiditsMinutes:$towDiditsSecond',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: ColorManager.mainColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
