// import 'dart:io';

// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:svdomain/widgets/helping-widgets/video-playing-screen/video_progress.dart';
// import 'package:path/path.dart' as p;

// class Preview extends StatefulWidget {
//   const Preview({super.key, this.outputVideoPath});
//   final String? outputVideoPath;
//   @override
//   State<Preview> createState() => _PreviewState();
// }

// class _PreviewState extends State<Preview> {
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(File(widget.outputVideoPath!))
//       ..initialize().then((value) {
//         setState(() {});
//         _controller.play();
//       });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   Future<String?> createExternalFolder() async {
//     try {
//       Directory? externalDir = await getExternalStorageDirectory();
//       if (externalDir != null) {
//         String externalPath = externalDir.path;
//         String folderName = 'trimmedVideos';
//         String folderPath = '$externalPath/$folderName';

//         // Create the folder if it doesn't exist
//         if (!await Directory(folderPath).exists()) {
//           await Directory(folderPath).create(recursive: true);
//         }

//         return folderPath;
//       } else {
//         print('External storage directory is null.');
//         return null;
//       }
//     } catch (error) {
//       // Handle error
//       print('Error creating folder: $error');
//       return null;
//     }
//   }

//   Future<void> addVideo(
//     File file,
//   ) async {
//     try {
//       String? folderPath = await createExternalFolder();
//       String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//       String videoName = 'video_$timestamp${p.extension(file.path)}';
//       String videoPath = '$folderPath/$videoName';
//       await file.copy(videoPath);
//       print('after adding video is $videoPath');
//       // Read the image file
//       // List<int> imageBytes = await file.readAsBytes();

// // Save the image with the original bytes
//       // File(imagePath).writeAsBytesSync(imageBytes);
//       setState(() {});
//     } catch (err) {}
//   }

//   late VideoPlayerController _controller;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: _controller.value.isInitialized
//                     ? VideoPlayer(_controller)
//                     : const CircularProgressIndicator(),
//               ),
//               VideoProgressBar(controller: _controller)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
