// import 'dart:io';

// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:flutter/material.dart';

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

//   late VideoPlayerController _controller;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: _controller.value.isInitialized
//               ? VideoPlayer(_controller)
//               :const  CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
