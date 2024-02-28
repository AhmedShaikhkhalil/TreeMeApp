

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:treeme/core/helpers/date_format_extensions.dart';

import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../domain/model/stream_pin_masssage_model.dart';
class PinMassageWidget extends StatefulWidget {
  const PinMassageWidget({super.key, required this.id});
  final  String id ;

  @override
  _PinMassageWidgetState createState() => _PinMassageWidgetState();
}

class _PinMassageWidgetState extends State<PinMassageWidget> {
  final MessageStreamService _streamService = MessageStreamService();

  @override
  void initState() {
    super.initState();
    _streamService.startListeningToMessages(widget.id);
  }

  @override
  void dispose() {
    _streamService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: _streamService.messageListStream,
      builder: (context, snapshot) {
       try {
         if (snapshot.hasError) {
           return Text('Error: ${snapshot.error}');
         }

         if (!snapshot.hasData) {
           return CircularProgressIndicator();
         }

         List<String> latestUpdatedAt = snapshot.data!;

         return ClipRRect(
             borderRadius: BorderRadius.only(bottomRight: Radius.circular(16),bottomLeft: Radius.circular(16)),
             child: Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.only(bottomRight: Radius.circular(16),bottomLeft: Radius.circular(16))
             ),
             child: ListView.builder(
                 shrinkWrap: true,
                 itemCount: latestUpdatedAt.length,
                 padding: EdgeInsets.zero,
                 itemBuilder: (context, index) {
                   return CachedNetworkImage(

                    imageUrl:           latestUpdatedAt[index],
                       placeholder: (context, url) =>LinearProgressIndicator(
                         minHeight: 2,
                       ),


                   );
                 }
             ),
           ),
         );
       }catch (e){
         print('$e');
         return CircularProgressIndicator();
       }
      },
    );
  }
}
