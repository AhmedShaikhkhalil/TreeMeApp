// import 'dart:io';
//
// import 'package:audioplayers/audioplayers.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class MusicPlayerScreen extends StatefulWidget {
//   const MusicPlayerScreen({super.key});
//
//   @override
//   _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
// }
//
// class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
//   List<File> musicFiles = [];
//   List<FileSystemEntity> mp3Files = [];
//   bool isPlaying = false;
//   AudioPlayer audioPlayer = AudioPlayer();
//   PlayerState playerState = PlayerState.stopped;
//   AudioCache audioCache = AudioCache();
//   String? filePath;
//
//   @override
//   void initState() {
//     super.initState();
//     requestStoragePermission();
//     audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
//       setState(() {
//         playerState = state;
//       });
//     });
//   }
//
//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.audio,
//       allowMultiple: false,
//     );
//
//     if (result != null) {
//       setState(() {
//         filePath = result.files.single.path;
//         playerState = PlayerState.playing;
//       });
//     }
//   }
//
//   Future<void> play(String? filePath) async {
//     if (filePath != null) {
//       await audioPlayer.play(DeviceFileSource(filePath));
//     }
//   }
//
//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }
//
//   Future<void> requestStoragePermission() async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.mediaLibrary,
//       Permission.manageExternalStorage,
//       Permission.storage,
//     ].request();
//     print(statuses[Permission.location]);
//     print(statuses);
//     PermissionStatus status = await Permission.manageExternalStorage.request();
//
//     if (status.isGranted) {
//       // Permission granted, proceed with file listing
//       await getMusicFiles();
//       print(mp3Files.length);
//       // Use the mp3Files as needed
//     } else {
//       // Permission not granted, handle accordingly
//       // You may want to show a message or disable certain functionality
//     }
//   }
//
//   Future<List<File>> getMp3Files() async {
//     Directory appDocDirectory = Directory('/storage/emulated/0/snaptube');
//     Directory directory =
//         Directory('${appDocDirectory.path}/download/SnapTube Audio');
//     print(directory.path);
//     if (await directory.exists()) {
//       List<FileSystemEntity> files = directory.listSync(recursive: true);
//       List<File> musicFilesList = [];
//
//       for (FileSystemEntity file in files) {
//         if (file.path.endsWith('.mp3')) {
//           musicFilesList.add(File(file.path));
//         }
//       }
//
//       setState(() {
//         musicFiles = musicFilesList;
//       });
//     }
//
//     return musicFiles;
//   }
//
//   info() {
//     musicFiles.forEach((element) {
//       if (element.existsSync()) {
//         String path = element.path;
//         String fileName = element.path.split('/').last;
//         int fileSize = element.lengthSync();
//         DateTime lastModified = element.lastModifiedSync();
//
//         print('File path: $path');
//         print('File name: $fileName');
//         print('File size: $fileSize bytes');
//         print('Last modified: $lastModified');
//       } else {
//         print('File does not exist');
//       }
//     });
//   }
//
//   Future<void> getMusicFiles() async {
//     await Permission.manageExternalStorage.request();
//
//     List<Directory>? externalStorageDirectories =
//         await getExternalStorageDirectories();
//     if (externalStorageDirectories != null) {
//       for (Directory directory in externalStorageDirectories) {
//         print('External Storage Path: ${directory.path}');
//       }
//     }
//
//     Directory storageDirectory =
//         Directory('/storage/emulated/0/snaptube/download/SnapTube Audio');
//     print(storageDirectory?.path);
//     if (storageDirectory != null) {
//       List<FileSystemEntity> files = storageDirectory.listSync(recursive: true);
//       List<File> musicFilesList = [];
//
//       for (FileSystemEntity file in files) {
//         if (file.path.endsWith('.mp3')) {
//           musicFilesList.add(File(file.path));
//         }
//       }
//
//       setState(() {
//         musicFiles = musicFilesList;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Music Player'),
//         ),
//         body: Column(
//           children: [
//             TextButton(
//                 onPressed: () {
//                   info();
//                 },
//                 child: Text('set audio')),
//             // Expanded(
//             //   child: ListView.builder(
//             //     shrinkWrap: true,
//             //     itemCount: musicFiles.length,
//             //     itemBuilder: (context, index) {
//             //       File file = musicFiles[index];
//             //       return ListTile(
//             //         onTap: () {
//             //           play(file.path);
//             //         },
//             //         title: Text(file.path.split('/').last.toString()),
//             //       );
//             //     },
//             //   ),
//             // ),
//             if (playerState == PlayerState.playing)
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     playerState = PlayerState.stopped;
//                   });
//                   audioPlayer.stop();
//                 },
//                 child: Text('Stop'),
//               ),
//           ],
//         ));
//   }
// }
