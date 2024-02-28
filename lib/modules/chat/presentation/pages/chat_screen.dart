import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';

import '../../../../core/resources/resource.dart';

class ChatScreen extends StatelessWidget {
  final List<types.Message> messages = [
    types.TextMessage(
      author: types.User(
        id: 'user-id',
        firstName: 'John',
        lastName: 'Doe',
      ),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'message-id-1',
      text: 'Hello!',
    ),
    types.AudioMessage(
      name: 'John',
      size: 12,
      author: types.User(
        id: 'user-id',
        firstName: 'John',
        lastName: 'Doe',
      ),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'message-id-2',
      uri: 'https://example.com/audio.mp3',
      duration: const Duration(seconds: 30),
    ),
    types.VideoMessage(
      name: 'Doe',
      author: types.User(
        id: 'user-id',
        firstName: 'John',
        lastName: 'Doe',
      ),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'message-id-3',
      uri: 'https://example.com/video.mp4',
      size: 500,
    ),
    types.ImageMessage(
      name: 'Doe',
      author: types.User(
        id: 'user-id',
        firstName: 'John',
        lastName: 'Doe',
      ),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'message-id-4',
      uri:
          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80',
      size: 1024,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 65.h),
            child: Container(
                decoration: BoxDecoration(
                  gradient: ColorManager().gradientFloating,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(36.r),
                    bottomLeft: Radius.circular(36.r),
                  ),
                ),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  leadingWidth: 75.w,
                  elevation: 0,
                  title: Column(
                    children: [
                      Text(
                        'Ahmed\'s birthday',
                        style: getBoldStyle(
                            color: ColorManager.white,
                            fontSize: FontSize.s16.sp),
                      ),
                      Text(
                        '24 Feb 2023',
                        style: getBoldStyle(
                            color: ColorManager.white,
                            fontSize: FontSize.s12.sp),
                      ),
                    ],
                  ),
                  centerTitle: true,
                  leading: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      margin: EdgeInsets.only(left: AppSize.s24.w),
                      width: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s12.r),
                          border: Border.all(
                              color: ColorManager.white.withOpacity(0.29),
                              width: AppSize.s1.w),
                          // color: Colors.transparent,
                          gradient: LinearGradient(
                              colors: [
                                ColorManager.white.withOpacity(0.13),
                                ColorManager.white.withOpacity(0.51),
                              ],
                              tileMode: TileMode.decal,
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
                          boxShadow: [
                            BoxShadow(
                                color: ColorManager.black.withOpacity(0.03),
                                offset: Offset(0, 7),
                                blurRadius: 10)
                          ]),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  actions: [
                    Container(
                      // height: AppSize.s20.h,
                      margin: EdgeInsets.only(right: AppSize.s24.w),
                      width: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s12.r),
                          // color: ColorManager.white,
                          border: Border.all(
                              color: ColorManager.white.withOpacity(0.29),
                              width: AppSize.s1.w),
                          gradient: LinearGradient(
                              colors: [
                                ColorManager.white.withOpacity(0.13),
                                ColorManager.white.withOpacity(0.51),
                              ],
                              tileMode: TileMode.decal,
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
                          boxShadow: [
                            BoxShadow(
                                color: ColorManager.black.withOpacity(0.03),
                                offset: Offset(0, 7),
                                blurRadius: 10)
                          ]),
                      child: Icon(Icons.more_horiz),
                    )
                  ],
                ))),
        body: CustomScrollView(
          slivers: [
            // SliverAppBar(
            //   expandedHeight: 100.h,
            //   pinned: true,
            //   snap: true,
            //   floating: true,
            //   flexibleSpace: FlexibleSpaceBar(
            //     background: Container(
            //       decoration: BoxDecoration(
            //         gradient: ColorManager().gradientFloating,
            //         borderRadius: BorderRadius.only(
            //           bottomRight: Radius.circular(36.r),
            //           bottomLeft: Radius.circular(36.r),
            //         ),
            //       ),
            //     ),
            //   ),
            //   title: Column(
            //     children: [
            //       Text(
            //         'Ahmed\'s birthday',
            //         style: getBoldStyle(
            //             color: ColorManager.white, fontSize: FontSize.s16.sp),
            //       ),
            //       Text(
            //         '24 Feb 2023',
            //         style: getBoldStyle(
            //             color: ColorManager.white, fontSize: FontSize.s12.sp),
            //       ),
            //     ],
            //   ),
            //   centerTitle: true,
            //   elevation: 0,
            //   backgroundColor: Colors.transparent,
            //   actions: [
            //     Container(
            //       // height: AppSize.s20.h,
            //       margin: EdgeInsets.only(right: AppSize.s24.w),
            //       width: 50.w,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(AppSize.s12.r),
            //           // color: ColorManager.white,
            //           border: Border.all(
            //               color: ColorManager.white.withOpacity(0.29),
            //               width: AppSize.s1.w),
            //           gradient: LinearGradient(
            //               colors: [
            //                 ColorManager.white.withOpacity(0.13),
            //                 ColorManager.white.withOpacity(0.51),
            //               ],
            //               tileMode: TileMode.decal,
            //               begin: Alignment.bottomRight,
            //               end: Alignment.topLeft),
            //           boxShadow: [
            //             BoxShadow(
            //                 color: ColorManager.black.withOpacity(0.03),
            //                 offset: Offset(0, 7),
            //                 blurRadius: 10)
            //           ]),
            //       child: Icon(Icons.more_horiz),
            //     )
            //   ],
            //   leading: GestureDetector(
            //     onTap: () => Get.back(),
            //     child: Container(
            //       margin: EdgeInsets.only(left: AppSize.s24.w),
            //       width: 50.w,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(AppSize.s12.r),
            //           border: Border.all(
            //               color: ColorManager.white.withOpacity(0.29),
            //               width: AppSize.s1.w),
            //           // color: Colors.transparent,
            //           gradient: LinearGradient(
            //               colors: [
            //                 ColorManager.white.withOpacity(0.13),
            //                 ColorManager.white.withOpacity(0.51),
            //               ],
            //               tileMode: TileMode.decal,
            //               begin: Alignment.bottomRight,
            //               end: Alignment.topLeft),
            //           boxShadow: [
            //             BoxShadow(
            //                 color: ColorManager.black.withOpacity(0.03),
            //                 offset: Offset(0, 7),
            //                 blurRadius: 10)
            //           ]),
            //       child: Icon(Icons.arrow_back),
            //     ),
            //   ),
            //   leadingWidth: 75.w,
            // ),
            SliverFillRemaining(
              child: Chat(
                messages: messages,
                theme: DefaultChatTheme(
                    backgroundColor: ColorManager.chatBackGround,
                    inputBackgroundColor: Color(0xffF7F7F7),
                    primaryColor: Colors.blue,
                    inputContainerDecoration: BoxDecoration(color: Colors.red)),
                inputOptions: InputOptions(),
                onSendPressed: (text) {
                  final message = types.TextMessage(
                    author: types.User(
                      id: 'user-id',
                      firstName: 'John',
                      lastName: 'Doe',
                    ),
                    createdAt: DateTime.now().millisecondsSinceEpoch,
                    id: 'message-id-${messages.length + 1}',
                    text: text.text,
                  );
// Add the new message to the list of messages
                  messages.add(message);
                },
                user: types.User(
                  id: 'user-id',
                  firstName: 'John',
                  lastName: 'Doe',
                ),

// Specify how to build each type of message
                textMessageBuilder: (p0,
                    {required messageWidth, required showName}) {
                  return TextMessage(
                      emojiEnlargementBehavior: EmojiEnlargementBehavior.multi,
                      hideBackgroundOnEmojiMessages: false,
                      onPreviewDataFetched: (p0, p1) {},
                      options: TextMessageOptions(isTextSelectable: true),
                      message: p0,
                      showName: showName,
                      usePreviewData: false);
                },
                imageMessageBuilder: (message, {required messageWidth}) {
                  return ImageMessage(
                    message: message,
                    messageWidth: messageWidth,
                  );
                },

// messageBuilder: (message, index) {
//   if (message.type == types.MessageType.text) {
//     return TextMessage(
//       message: message,
//       showAvatar: true,
//       showUsername: true,
//     );
//   } else if (message.type == types.MessageType.audio) {
//     return AudioMessage(
//       message: message,
//       audioHeight: 40,
//       audioWidth: MediaQuery
//           .of(context)
//           .size
//           .width * 0.7,
//       audioBorderRadius: BorderRadius.circular(20),
//       audioDurationTextStyle: TextStyle(fontSize: 12),
//       audioDurationBackgroundColor: Colors.grey,
//       audioDurationPadding: EdgeInsets.symmetric(
//           horizontal: 6, vertical: 4),
//       audioPlayButtonColor: Colors.blue,
//       audioPauseButtonColor: Colors.red,
//     );
//   } else if (message.type == types.MessageType.video) {} else
//   if (message.type == types.MessageType.video) {
//     return VideoMessage(
//       message: message,
//       borderRadius: BorderRadius.circular(16),
//       onTap: () => print('Tapped video message'),
//       onLongPress: () => print('Long pressed video message'),
//     );
//   } else if (message.type == types.MessageType.image) {
//     return ImageMessage(
//       message: message,
//       borderRadius: BorderRadius.circular(16),
//       onTap: () => print('Tapped image message'),
//       onLongPress: () => print('Long pressed image message'),
//     );
//   }
//   return SizedBox();
// },
              ),
            )
            // SliverPersistentHeader(delegate: delegate)
          ],
        ));
  }
}
// Chat(
// messages: messages,
// theme: DefaultChatTheme(
// backgroundColor: Colors.black87,
// inputBackgroundColor: Colors.black87,
// primaryColor: Colors.blue,
// inputContainerDecoration: BoxDecoration(
//
// )
//
// ),
// onSendPressed: (text) {
// final message = types.TextMessage(
// author: types.User(
// id: 'user-id',
// firstName: 'John',
// lastName: 'Doe',
// ),
// createdAt: DateTime.now().millisecondsSinceEpoch,
// id: 'message-id-${messages.length + 1}',
// text: text.text,
// );
// // Add the new message to the list of messages
// messages.add(message);
// },
// user: types.User(
// id: 'user-id',
// firstName: 'John',
// lastName: 'Doe',
// ),
//
// // Specify how to build each type of message
// textMessageBuilder: (p0, {required messageWidth, required showName}) {
// return TextMessage(
// emojiEnlargementBehavior: EmojiEnlargementBehavior.multi,
// hideBackgroundOnEmojiMessages: false,
// onPreviewDataFetched: (p0, p1) {},
// options: TextMessageOptions(isTextSelectable: true),
// message: p0,
// showName: showName,
// usePreviewData: false);
// },
// imageMessageBuilder: (message, {required messageWidth}) {
// return ImageMessage(
// message: message,
// messageWidth: messageWidth,
// );
//
// },
//
//
// // messageBuilder: (message, index) {
// //   if (message.type == types.MessageType.text) {
// //     return TextMessage(
// //       message: message,
// //       showAvatar: true,
// //       showUsername: true,
// //     );
// //   } else if (message.type == types.MessageType.audio) {
// //     return AudioMessage(
// //       message: message,
// //       audioHeight: 40,
// //       audioWidth: MediaQuery
// //           .of(context)
// //           .size
// //           .width * 0.7,
// //       audioBorderRadius: BorderRadius.circular(20),
// //       audioDurationTextStyle: TextStyle(fontSize: 12),
// //       audioDurationBackgroundColor: Colors.grey,
// //       audioDurationPadding: EdgeInsets.symmetric(
// //           horizontal: 6, vertical: 4),
// //       audioPlayButtonColor: Colors.blue,
// //       audioPauseButtonColor: Colors.red,
// //     );
// //   } else if (message.type == types.MessageType.video) {} else
// //   if (message.type == types.MessageType.video) {
// //     return VideoMessage(
// //       message: message,
// //       borderRadius: BorderRadius.circular(16),
// //       onTap: () => print('Tapped video message'),
// //       onLongPress: () => print('Long pressed video message'),
// //     );
// //   } else if (message.type == types.MessageType.image) {
// //     return ImageMessage(
// //       message: message,
// //       borderRadius: BorderRadius.circular(16),
// //       onTap: () => print('Tapped image message'),
// //       onLongPress: () => print('Long pressed image message'),
// //     );
// //   }
// //   return SizedBox();
// // },
// ),
