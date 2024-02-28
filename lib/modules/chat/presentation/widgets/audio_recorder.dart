import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:mohamy/constants/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({Key? key}) : super(key: key);

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  String? filePath;
  String? filePath2;
  Future record() async {
    if (!isRecorderReady) return;
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    filePath2 = '$appDocumentsPath/demoFile.wav';
    print(filePath2.toString() + '7878787878787878787878');
    await recorder.startRecorder(
      toFile: filePath2,
      codec: Codec.pcm16WAV,
    );
  }

  Future stop() async {
    if (!isRecorderReady) return;
    await recorder.stopRecorder();
    // Provider.of<ConsultationViewModel>(context, listen: false).audioFile =io.File(filePath2!);
    // Provider.of<ConsultationViewModel>(context, listen: false).setIsStopRecording(true);
  }

  initRecorder() async {
    final status = await Permission.microphone.request();
    final status2 = await Permission.storage.request();
    if (status != PermissionStatus.granted && status2 != PermissionStatus.granted) {
      throw 'microphone permission not granted';
    }

    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 100),
    );
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          InkWell(
            child: Card(
              color: Colors.blue,
              shape: const CircleBorder(),
              elevation: 5,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      recorder.isRecording ? Icons.stop_circle : Icons.mic,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                    StreamBuilder<RecordingDisposition>(
                      stream: recorder.onProgress,
                      builder: (context, snapshot) {
                        final duration =
                            snapshot.hasData ? snapshot.data!.duration : Duration.zero;
                        String towDidits(int n) => n.toString().padLeft(0);
                        final towDiditsMinutes =
                            towDidits(duration.inMinutes.remainder(60));
                        final towDiditsSecond =
                            towDidits(duration.inSeconds.remainder(60));
                        if (duration.inMinutes == 2) {
                          stop();
                          setState(() {});
                        }

                        return Text(
                          '$towDiditsMinutes:$towDiditsSecond',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            onTap: () async {
              if (recorder.isRecording) {
                await stop();
              } else {
                await record();
              }
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}
