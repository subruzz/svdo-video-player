// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:svdomain/data/video-related/video_details.dart';
// import 'package:svdomain/screens/video_playing_screen.dart';
// import 'package:svdomain/widgets/dialog/trim_video_alert.dart';
// import 'package:svdomain/widgets/video-info/video_metadata.dart';

// class TrimmedVideoScreen extends ConsumerStatefulWidget {
//   const TrimmedVideoScreen({super.key});

//   @override
//   ConsumerState<TrimmedVideoScreen> createState() => _TrimmedVideoScreenState();
// }

// class _TrimmedVideoScreenState extends ConsumerState<TrimmedVideoScreen> {
//   bool isVideoFile(String file) {
//     final String extension = file.split('.').last.toLowerCase();
//     return (extension == 'mp4' ||
//             extension == 'mov' ||
//             extension == 'avi' ||
//             extension == 'mkv') &&
//         !file.split('/').last.startsWith('.trashed');
//   }

//   Future<List<String>> getVideos() async {
//     List<String> trimmedPath = [];
//     final Directory trimmedVideoDir = Directory(
//         '/storage/emulated/0/Android/data/com.example.svdomain/files/trimmedVideos');
//     if (trimmedVideoDir.existsSync()) {
//       trimmedVideoDir.listSync().forEach((element) {
//         if (isVideoFile(element.path) && element.existsSync()) {
//           trimmedPath.add(element.path);
//         }
//       });
//     }
//     return trimmedPath;
//   }

//   Future<void> removeImage(File file) async {
//     showDialog(
//         context: context,
//         builder: (ctx) => TrimVideoAlert(delteFile: () async {
//               await file.delete();
//               setState(() {});
//             }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Trimmed Videos'),
//           centerTitle: true,
//         ),
//         body: FutureBuilder(
//           future: getVideos(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               return snapshot.data!.isEmpty
//                   ? const Center(
//                       child: Text('No Trimmed Videos Found'),
//                     )
//                   : ListView.builder(
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (ctx, index) => Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ListTile(
//                           onLongPress: () {
//                             removeImage(File(snapshot.data![index]));
//                           },
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (ctx) => VideoPlayingScreen(
//                                     singleVideo: snapshot.data![index],
//                                     index: index,
//                                     videoTitle:
//                                         VideoDetailsGenerate.getVideoName(
//                                       snapshot.data![index],
//                                     ),
//                                   ),
//                                 ));
//                           },
//                           leading: MainVideoMetaData(
//                               videoPath: snapshot.data![index],
//                               allVideos: snapshot.data!,
//                               width: 100,
//                               index: index),
//                           title: Text(
//                             VideoDetailsGenerate.getVideoName(
//                               snapshot.data![index],
//                             ),
//                             style: Theme.of(context).textTheme.labelLarge,
//                           ),
//                         ),
//                       ),
//                     );
//             }
//           },
//         ));
//   }
// }
