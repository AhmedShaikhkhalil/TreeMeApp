import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart' hide PlayerState;
import 'package:chewie/chewie.dart';
import 'package:easy_audio_trimmer/easy_audio_trimmer.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/log.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:ffmpeg_kit_flutter/session.dart';
import 'package:ffmpeg_kit_flutter/statistics.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:helpers/helpers.dart' show OpacityTransition;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:stack_board/stack_board.dart';
import 'package:treeme/core/helpers/audio_trimm/src/trimmer.dart';
import 'package:treeme/modules/create_media/domain/entities/image_overlay.dart';
import 'package:uuid/uuid.dart';
import 'package:video_editor/video_editor.dart';
import 'package:video_player/video_player.dart';

import '../../domain/entities/text_overlay.dart';

class CreateMediaController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static CreateMediaController get to => Get.find();

  StackBoardController boardController = StackBoardController();
  late AnimationController animationController;
  List<double> audioData = [];
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.stopped;
  PlayerState playerState2 = PlayerState.stopped;
  late final PlayerController playerController;
  late final PlayerController playerController2;
  VideoEditorController? videoEditorController;
  RxList<Uint8List> videoFrames = <Uint8List>[].obs;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  RxBool pause = false.obs;
  RxBool deleteText = false.obs;
  RxList<TextOverlay> textOverlays = <TextOverlay>[].obs;
  RxList<ImageOverly> imageOverlays = <ImageOverly>[].obs;
  String text = '';
  double fontSize = 24.0;
  Color textColor = Colors.white;

  bool selectedText = false;
  // String _filePath;
  String? filePath;
  bool _isPlaying = false;
  final FFmpegKit _ffmpeg = FFmpegKit();
  String videoFilePath = '';
  String imageFilePath = '';
  String audioFilePath = '';
  String? outputFilePath = '';
  bool isProcessing = false;
  String? addTextResult = '';
  RxDouble posVideo = 0.0.obs;
  double xPosition = 50.0;
  double yPosition = 50.0;
  var uuid = const Uuid();
  TextEditingController textController = TextEditingController();
  final Trimmer trimmer = Trimmer();
  double startValueAudio = 0.0;
  double endValueAudio = 0.0;

  // bool _isPlaying = false;
  bool progressVisibility = false;
  bool isLoadingAudio = false;
  Duration durationAudio = const Duration(seconds: 0);
  int idCounter = 0;
  @override
  void onInit() {
    super.onInit();
    videoPlayerController?.dispose();
    chewieController?.dispose();
    playerController = PlayerController();
    playerController2 = PlayerController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    // Simulating audio data for visualization
    for (int i = 0; i < 30; i++) {
      audioData.add((i + 1) / 30);
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
  }

  void addTextOverlay(TextOverlay textOverlay) {
    textOverlays.add(textOverlay);
    boardController.add(StackBoardItem(
      child: Text(
        textOverlay.text,
        style: TextStyle(
          color: textOverlay.textColor,
        ),
      ),
      caseStyle: CaseStyle(iconSize: 30),
      // onDel: () {
      //   // print('deleted');
      //   // return Future.value(textOverlays.remove(textOverlay));
      // },
    ));
    textOverlays.refresh();
    update();
  }

  void findOverlay(int id) {}
  void addImageOverlay(ImageOverly imageOverlay) {
    imageOverlays.add(imageOverlay);
    boardController.add(StackBoardItem(
      id: imageOverlay.id,
      child: Image.file(
        File(imageOverlay.selectedImage ?? ''),
        scale: 2,
        fit: BoxFit.fill,
        width: imageOverlay.size.width + 100,
        height: imageOverlay.size.height + 100,
      ),
      // onDel: () {
      //   print('deleted');
      //   return Future.value(imageOverlays.remove(imageOverlay));
      // },
    ));
    update();
  }

  void removeTextOverlay(int index) {
    textOverlays.removeAt(index);
    update();
  }

  void removeImageOverlay(int index) {
    imageOverlays.removeAt(index);
    update();
  }

  void showTextOverlayDialog(BuildContext context) {
    Get.defaultDialog(
      title: 'Add Text Overlay',
      content: GetBuilder<CreateMediaController>(builder: (logic) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => text = value,
                decoration: const InputDecoration(labelText: 'Text'),
              ),
              const SizedBox(height: 10),
              Slider(
                value: fontSize,
                min: 10,
                max: 50,
                onChanged: (value) {
                  fontSize = value;
                  print(value);
                  update();
                },
              ),
              const SizedBox(height: 10),
              // ListTile(
              //   title: Text('Font Family'),
              //   trailing: DropdownButton<String>(
              //     value: fontFamily,
              //     items: [
              //       GoogleFonts.openSans().fontFamily,
              //       GoogleFonts.roboto().fontFamily,
              //       GoogleFonts.lato().fontFamily,
              //     ].map((font) {
              //       return DropdownMenuItem<String>(
              //         value: font,
              //         child: Text(font.toString()),
              //       );
              //     }).toList(),
              //     onChanged: (value) => fontFamily = value!,
              //   ),
              // ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text('Text Color'),
                trailing: CircleAvatar(
                  backgroundColor: textColor,
                  radius: 15,
                ),
                onTap: () {
                  showColorPicker(context, textColor);
                  update();
                },
              ),
            ],
          ),
        );
      }),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text('Cancel'),
      ),
      confirm: TextButton(
        onPressed: () {
          Get.back();
          TextOverlay textOverlay = TextOverlay(
            text: text,
            id: idCounter,
            fontSize: fontSize,
            textColor: textColor,
            fontFamily: 'Comfortaa',
          );
          addTextOverlay(textOverlay);
        },
        child: const Text('Add'),
      ),
    );
    // showDialog(
    //   context: Get.context!,
    //   builder: (context) {
    //     return GetBuilder(builder: (logic) {
    //       return AlertDialog(
    //         title: Text('Add Text Overlay'),
    //         content: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             TextField(
    //               onChanged: (value) => text = value,
    //               decoration: InputDecoration(labelText: 'Text'),
    //             ),
    //             SizedBox(height: 10),
    //             Slider(
    //               value: fontSize,
    //               min: 10,
    //               max: 50,
    //               onChanged: (value) {
    //                 fontSize = value;
    //                 print(value);
    //                 update();
    //               },
    //             ),
    //             SizedBox(height: 10),
    //             // ListTile(
    //             //   title: Text('Font Family'),
    //             //   trailing: DropdownButton<String>(
    //             //     value: fontFamily,
    //             //     items: [
    //             //       GoogleFonts.openSans().fontFamily,
    //             //       GoogleFonts.roboto().fontFamily,
    //             //       GoogleFonts.lato().fontFamily,
    //             //     ].map((font) {
    //             //       return DropdownMenuItem<String>(
    //             //         value: font,
    //             //         child: Text(font.toString()),
    //             //       );
    //             //     }).toList(),
    //             //     onChanged: (value) => fontFamily = value!,
    //             //   ),
    //             // ),
    //             SizedBox(height: 10),
    //             ListTile(
    //               title: Text('Text Color'),
    //               trailing: CircleAvatar(
    //                 backgroundColor: textColor,
    //                 radius: 15,
    //               ),
    //               onTap: () {
    //                 showColorPicker(context, textColor);
    //               },
    //             ),
    //           ],
    //         ),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Get.back();
    //               TextOverlay textOverlay = TextOverlay(
    //                 text: text,
    //                 fontSize: fontSize,
    //                 textColor: textColor,
    //                 fontFamily: 'Comfortaa',
    //               );
    //               addTextOverlay(textOverlay);
    //             },
    //             child: Text('Add'),
    //           ),
    //           TextButton(
    //             onPressed: () => Get.back(),
    //             child: Text('Cancel'),
    //           ),
    //         ],
    //       );
    //     });
    //   },
    // );
  }

  void showColorPicker(BuildContext context, Color currentColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ColorPicker(
                pickerColor: currentColor,
                onColorChanged: (color) {
                  setState(() {
                    currentColor = color;
                    textColor = color;
                  });
                },
                showLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            );
          }),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Get.back();
                // Perform any additional logic with the selected color
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> initializeBord() async {}

  Future<void> initializeVideoEditing(File file, BuildContext context) async {
    videoEditorController = VideoEditorController.file(file,
        minDuration: const Duration(seconds: 1),
        maxDuration: const Duration(seconds: 10));
    isProcessing = false;
    videoEditorController
        ?.initialize(aspectRatio: 9 / 16)
        .then((_) => update())
        .catchError(
      (error) {
        // handle minumum duration bigger than video duration error
        Navigator.pop(context);
      },
    );
    isProcessing = true;
    update();
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null) {
      filePath = result.files.single.path;
      print(filePath);
      isLoadingAudio = true;
      await trimmer.loadAudio(audioFile: File(result.files.single.path ?? ''));
      isLoadingAudio = false;
      progressVisibility = true;
      audioPlayer.setSourceDeviceFile(result.files.single.path ?? '');
      // playerController.preparePlayer(
      //   path: filePath ?? '',
      //   shouldExtractWaveform: true,
      //   noOfSamples: 100,
      //   volume: 1.0,
      // );
      final duration = await audioPlayer.getDuration();
      durationAudio = duration!;
      // print(duration); // Get duration of audio player
      update();
    }
  }

  void playandPause() async {
    playerController.playerState == PlayerState.playing
        ? await pauseplayer()
        : await playplayer();
  }

  Future<void> pauseplayer() async {
    pause.toggle();
    update();
    return await playerController2.pausePlayer();
  }

  Future<void> playplayer() async {
    pause.toggle();
    update();
    return await playerController2.startPlayer(finishMode: FinishMode.loop);
  }

  Future<void> pausePlayer() async {
    pause.value = !pause.value;
    update();
  }

  Future<void> pickFileVideo(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      videoFilePath = result.files.single.path!;
      audioFilePath = '';
      videoFrames.value = [];
      await initializeVideoEditing(File(videoFilePath), context);
      // Future.wait([
      //   _extractFrames(videoFilePath),
      //   _separateAudioFromVideo(videoFilePath)
      // ]);
      // await _extractFrames(videoFilePath);
      // await _separateAudioFromVideo(videoFilePath);
      update();
    }
  }

  Future<void> _extractFrames(String videoFilePath) async {
    Directory tempDir = await getTemporaryDirectory();
    String outputDir = tempDir.path;

    String outputPattern = path.join(outputDir, 'frame-%03d.bmp');
    print(outputPattern);
    if (videoFilePath != null) {
      await FFmpegKit.executeAsync(
          '-i "$videoFilePath" -vf fps=2/40 "$outputPattern"',
          (Session session) async {
        session.getReturnCode().then((returnCode) {
          _loadFramesFromDirectory(outputDir);
          update();
        });
      }, (Log log) {
        // print(log.getMessage());
        //
      }, (Statistics statistics) {
        print(statistics.getVideoFps());
        // CALLED WHEN SESSION GENERATES STATISTICS
      });
      // await FFmpegKit.executeAsync(
      // ,
      // ).then((session) {
      //   print(session.getAllLogs().toString());
      //   session.getReturnCode().then((returnCode) {
      //     print(returnCode?.getValue());
      //     if (returnCode != null && returnCode == ReturnCode.success) {
      //
      //     } else {}
      //   });
      // });
    }
  }

  void _loadFramesFromDirectory(String directory) {
    Directory framesDir = Directory(directory);
    print('=>>${framesDir}');
    List<File> frameFiles = framesDir
        .listSync()
        .where((file) => file is File && file.path.endsWith('.bmp'))
        .map((file) => File(file.path))
        .toList();
    print(frameFiles.toString());
    List<Uint8List> frames = [];

    for (var frameFile in frameFiles) {
      Uint8List frameBytes = frameFile.readAsBytesSync();
      frames.add(frameBytes);
    }

    videoFrames.value = frames;
    update();
    refresh();
  }

  Future<void> _separateAudioFromVideo(String videoFilePath) async {
    String outputAudioFilePath =
        videoFilePath.replaceAll(RegExp(r'\.[^.]+$'), '.aac');
    print(videoFilePath);
    print(outputAudioFilePath);
    // FFmpegKitConfig.enableStatisticsCallback(null);
    await FFmpegKit.executeAsync(
        '-i "$videoFilePath" -vn -acodec copy "$outputAudioFilePath"',
        (Session session) async {
      session.getReturnCode().then((returnCode) {
        print('=>>>${outputAudioFilePath}');
        audioFilePath = outputAudioFilePath;
        playerController2.preparePlayer(
          path: outputAudioFilePath ?? '',
          shouldExtractWaveform: true,
          noOfSamples: 100,
          volume: 1.0,
        );
        update();
      });
    }, (Log log) {
      print(log.getMessage());
    }, (Statistics statistics) {
      print(statistics.getVideoFps());
      // CALLED WHEN SESSION GENERATES STATISTICS
    });
    //     .then((session) {
    //   if (session != null) {
    //     session.getReturnCode().then((returnCode) {
    //       if (returnCode != null && returnCode == ReturnCode.success) {
    //         audioFilePath = outputAudioFilePath;
    //
    //         playerController2.preparePlayer(
    //           path: audioFilePath ?? '',
    //           shouldExtractWaveform: true,
    //           noOfSamples: 100,
    //           volume: 1.0,
    //         );
    //         update();
    //       } else {
    //         print('Handle failure or unexpected returnCode value');
    //       }
    //     });
    //   } else {
    //     FFmpegKitConfig.getLastCompletedSession().then((output) async {
    //       if (output != null) {
    //         String? errorMessage = await output.getOutput();
    //         print('FFmpeg execution failed: $errorMessage');
    //       } else {
    //         print('FFmpeg execution failed: Unknown error');
    //       }
    //     });
    //   }
    // });

    // await FFmpegKit.executeAsync(
    //         '-i "$videoFilePath" -vn -acodec copy "$outputAudioFilePath"')
    //     .then((session) {
    //   print(session.getCommand());
    //   session.getReturnCode().then((value) {
    //     print('=>>>${value?.getValue()}');
    //     if (value!.isValueSuccess()) {
    //
    //
    //     }
    //   });
    // });

    // session.getReturnCode().then((value) {
    //   if (valu) {
    //
    //   });
    // print(returnCode.toString());
    // if (returnCode) {
    //
    // }
    update();
    refresh();
  }

  void seekLine(String videoPath, int lineIndex) {
    final ffmpegCommand =
        '-ss ${lineIndex.toString()} -i $videoPath -c copy -avoid_negative_ts 1 output.mp4';

    FFmpegKitConfig.enableLogCallback((log) {
      print(log.getMessage());
    });

    FFmpegKit.executeAsync(ffmpegCommand).then((executeCallback) {
      if (executeCallback.getReturnCode() == ReturnCode.success) {
        // Seek operation successful
        print('Seek completed');
      } else {
        // Seek operation failed
        print('Seek failed');
      }
    });
  }

  void playandPause2() async {
    // videoPlayerController = VideoPlayerController.file(File(videoFilePath));
    // await videoPlayerController.initialize();
    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   autoPlay: true,
    //   looping: true,
    // );
    // videoEditorController?.v();
  }

  Future<void> addTextToVideo() async {
    isProcessing = true;
    addTextResult = null;
    outputFilePath = null;

    try {
      final inputVideoPath = videoFilePath;
      Directory tempDir = await getTemporaryDirectory();
      String outputDir = tempDir.path;

      String outputVideoPath = path.join(outputDir, 'out.mp4');
      const text = 'Mohammedd';

      final command =
          '-i $inputVideoPath  drawtext=text=$text:x=$xPosition:y=$yPosition:fontcolor=white --enable-libfreetype -c:a copy -y  $outputVideoPath';

      await FFmpegKit.executeAsync(command, (Session session) async {
        session.getReturnCode().then((returnCode) async {
          if (returnCode == 0) {
            videoFilePath = outputVideoPath;
            addTextResult = 'Text added successfully!';
            print(returnCode);
            await Gal.putVideo(outputVideoPath).then((value) {});
          } else {
            addTextResult =
                'Failed to add text to video. Return Code: $returnCode';
          }
          update();
        });
      }, (Log log) {
        print(log.getMessage());
      }, (Statistics statistics) {
        print(statistics.getVideoFps());
        // CALLED WHEN SESSION GENERATES STATISTICS
      });
    } catch (e) {
      addTextResult = 'Error: $e';
    }

    isProcessing = false;
    update();
  }

  Future<void> pickFileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      imageFilePath = result.files.single.path!;
      addImageOverlay(ImageOverly(
          imageFilePath, 50, 50, 1, const Offset(0, 0), 1, false, idCounter++));

      // Future.wait([initializeVideoPlayer()]);
      // await _extractFrames(videoFilePath);
      // await _separateAudioFromVideo(videoFilePath);
      update();
    }
  }

  Future<void> initializeVideoPlayer() async {
    String inputVideoPath = videoFilePath;
    String inputImagePath = imageFilePath;

    Directory tempDir = await getApplicationDocumentsDirectory();
    String outputDir = tempDir.path;
    ImageOverly selectedImage = imageOverlays[0];
    String outputVideoPath = path.join(outputDir, 'putout1.mp4');
    print('offset ${selectedImage.imagePositionX}:y=${selectedImage.position}');
    if (await File(inputVideoPath).exists()) {
      //:x=${selectedImage.imagePositionX}:y=${selectedImage.imagePositionY}
      // String ffmpegCommand =
      //     "-i $inputVideoPath -i $inputImagePath  -filter_complex 'overlay=10:main_h-overlay_h-10,scale=200x200'       -codec:a copy -y $outputVideoPath";
      print('${selectedImage.position}   ${selectedImage.size} ');

      String ffmpegCommand =
          "-i $inputVideoPath -i $inputImagePath -filter_complex \"[1:v]scale=${selectedImage.size.width}:${selectedImage.size.height} [ovrl]; [0:v][ovrl]overlay=${selectedImage.position.dx}:${selectedImage.position.dy}:enable='between(t,1,${selectedImage.endRange})'\" -codec:a copy -y $outputVideoPath";
      await FFmpegKit.executeAsync(ffmpegCommand, (Session session) async {
        session.getReturnCode().then(
          (returnCode) async {
            // if (returnCode == ReturnCode.success) {
            print(returnCode);
            await Gal.putVideo(outputVideoPath).then((value) {});

            videoPlayerController =
                VideoPlayerController.file(File(outputVideoPath));
            await videoPlayerController!.initialize();

            chewieController = ChewieController(
              videoPlayerController: videoPlayerController!,
              // autoPlay: true,
              looping: true,
            );
            update();

            // } else {
            //   addTextResult =
            //       'Failed to add text to video. Return Code: $returnCode';
            // }
          },
        );
      }, (Log log) {
        print(log.getMessage());
      }, (Statistics statistics) {
        print(statistics.getVideoFps());
        // CALLED WHEN SESSION GENERATES STATISTICS
      });
    }
  }

  Future<void> createVideoFromimages() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String outputDir = tempDir.path;
    String outputVideoPath = path.join(outputDir, 'putout3.mp4');

    //   String baseCommand = "ffmpeg";

    //   // Initialize filter complex string
    //   String filterComplex = "-filter_complex \"";

    //   // Iterate over image overlays to build the filter complex part
    //   for (int i = 0; i < imageOverlays.length; i++) {
    //     ImageOverly overlay = imageOverlays[i];
    //     // Assuming each image will be displayed for 5 seconds
    //     String imageInput =
    //         "-loop 1 -t 5 -i ${overlay.selectedImage} ";
    //     baseCommand += " $imageInput";

    //     // If there's text to overlay, add it to the filter complex
    //     // if (overlay.text.isNotEmpty) {
    //     //   filterComplex +=
    //     //       "[${i}:v]drawtext=text='${overlay.text}':x=${overlay.positionX}:y=${overlay.positionY}:fontsize=24:fontcolor=white,";
    //     // }
    //         filterComplex += "fps=25[${i}v]; "; // Ensure consistent frame rate for concat

    //   }
    //  String concatInputs = imageOverlays.asMap().keys.map((i) => "[${i}v]").join("");
    // filterComplex += "$concatInputs concat=n=${imageOverlays.length}:v=1:a=0 [v]\" -map \"[v]\"";

    //   // String ffmpegCommand =
    //   //     "ffmpeg -framerate 1/5 -i  image%d.jpg -c:v libx264 -r 30 -pix_fmt yuv420p slideshow.mp4";

    //     String finalCommand = "$baseCommand  $filterComplex -c:v libx264 -pix_fmt yuv420p -r 30 $outputVideoPath";

// Start directly with FFmpeg options, no need for "ffmpeg" at the start
    String inputFiles = "";
    String filterComplex = "-filter_complex \"";

    String targetResolution = "1600:1200";
    String targetSar = "1";
    // Generate input file options and filter chains for each image
    for (int i = 0; i < imageOverlays.length; i++) {
      inputFiles += "-loop 1 -t 5 -i '${imageOverlays[i].selectedImage}' ";
      // Apply scale, setsar, and text overlay if needed
      String filters = "[${i}:v]scale=$targetResolution,setsar=$targetSar";
      // Apply text overlay if needed
      // if (imageOverlays[i].text.isNotEmpty) {
      //   filterComplex +=
      //       "[${i}:v]drawtext=text='${imageOverlays[i].text.replace("'", "\\'")}':x=${imageOverlays[i].positionX}:y=${imageOverlays[i].positionY}:fontsize=24:fontcolor=white,";
      // }
      filterComplex +=
          "$filters[v$i]; "; // Append processed video stream to filter chain
      // Ensure consistent frame rate for concat
    }

    // Concatenate all processed video streams
    String concatInputs =
        imageOverlays.asMap().keys.map((i) => "[${i}v]").join("");
    filterComplex +=
        "$concatInputs concat=n=${imageOverlays.length}:v=1:a=0 [v]\" -map \"[v]\"";

    // Assemble the complete command without the "ffmpeg" at the start
    String finalCommand =
        "$inputFiles $filterComplex -c:v mpeg4 -pix_fmt yuv420p -r 30 $outputVideoPath";

    await FFmpegKit.executeAsync(finalCommand, (Session session) async {
      session.getReturnCode().then(
        (returnCode) async {
          // if (returnCode == ReturnCode.success) {
          print(returnCode);
          await Gal.putVideo(outputVideoPath).then((value) {});

          videoPlayerController =
              VideoPlayerController.file(File(outputVideoPath));
          await videoPlayerController!.initialize();

          chewieController = ChewieController(
            videoPlayerController: videoPlayerController!,
            // autoPlay: true,
            looping: true,
          );
          update();
          // } else {
          //   addTextResult =
          //       'Failed to add text to video. Return Code: $returnCode';
          // }
        },
      );
    }, (Log log) {
      print(log.getMessage());
    }, (Statistics statistics) {
      print(statistics.getVideoFps());
      // CALLED WHEN SESSION GENERATES STATISTICS
    });
  }

  List<Widget> trimSlider(BuildContext context) {
    return [
      AnimatedBuilder(
        animation: Listenable.merge([
          videoEditorController,
          videoEditorController?.video,
        ]),
        builder: (_, __) {
          final duration = videoEditorController?.videoDuration.inSeconds;
          final pos = videoEditorController!.trimPosition * duration!;
          // final width =
          posVideo.value = pos;
          print(videoEditorController?.videoDuration);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60 / 4),
            child: Row(children: [
              // Text(formatter(Duration(seconds: pos.toInt()))),
              // const Expanded(child: SizedBox()),
              OpacityTransition(
                visible: videoEditorController!.isTrimming,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(formatter(videoEditorController!.startTrim)),
                  const SizedBox(width: 10),
                  Text(formatter(videoEditorController!.endTrim)),
                ]),
              ),
            ]),
          );
        },
      ),
      Container(
        width: Get.width,
        margin: const EdgeInsets.symmetric(vertical: 60 / 4),
        child: TrimSlider(
          controller: videoEditorController!,
          height: 60,
          horizontalMargin: 0,
          child: TrimTimeline(
            controller: videoEditorController!,
            padding: const EdgeInsets.only(top: 10),
          ),
        ),
      )
    ];
  }

  String formatter(Duration duration) => [
        duration.inHours.remainder(24).toString().padLeft(1, '0'),
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        duration.inSeconds.remainder(60).toString().padLeft(2, '0')
      ].join(":");
  int indexText(int index) {
    return index;
  }

  void selectedTexts(TextOverlay index) {
    index.isSelected = !index.isSelected;
    update();
  }

  void selectedImage(ImageOverly index) {
    index.isSelected = !index.isSelected;
    update();
  }

  void udpateOffset(int? id, Offset offset) {}
}
// import 'package:get/get.dart';

// class CreateMediaController extends GetxController{

// }
