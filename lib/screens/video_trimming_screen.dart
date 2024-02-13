// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:svdomain/data/video-related/trimming.dart';
// import 'package:svdomain/screens/trimmed_videos.dart';
// import 'package:svdomain/widgets/dialog-box.dart/name_trimmed.dart';
// import 'package:svdomain/widgets/helping-widgets/video-trimming/loading.dart';
// import 'package:svdomain/widgets/helping-widgets/video-trimming/save_button.dart';
// import 'package:svdomain/widgets/helping-widgets/video-trimming/video.dart';
// import 'package:svdomain/widgets/snackbars/top_snackbar.dart';
// import 'package:video_trimmer/video_trimmer.dart';

// class TrimmerView extends ConsumerStatefulWidget {
//   const TrimmerView({super.key, required this.file});
//   final String file;

//   @override
//   ConsumerState<TrimmerView> createState() => _VideoTrimmmerState();
// }

// class _VideoTrimmmerState extends ConsumerState<TrimmerView> {
//   final Trimmer _trimmer = Trimmer();
//   final TextEditingController _nameContoller = TextEditingController();
//   double _startValue = 0.0;
//   double _endValue = 0.0;

//   bool _isPlaying = false;
//   bool _progressVisibility = false;
//   void _loadVideo() {
//     _trimmer.loadVideo(videoFile: File(widget.file));
//   }

//   @override
//   void dispose() {
//     _trimmer.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();

//     _loadVideo();
//   }

//   String filePath = '';
//   Future<String?> _saveVideo(String name) async {
//     setState(() {
//       _progressVisibility = true;
//     });

//     String? value;
//     await _trimmer
//         .saveTrimmedVideo(
//             startValue: _startValue,
//             endValue: _endValue,
//             onSave: ((outputPath) {
//               TrimVideo.addVideo(File(outputPath!), name).then((value) {
//                 TopSnackBar.showCustomSnackBarSuccess(
//                     context, 'Video Trimmed Successfully');
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (ctx) => const TrimmedVideoScreen()));
//               });
//             }))
//         .then((value) {});

//     return value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _progressVisibility
//           ? const LoadingTrimming()
//           : Center(
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TrimmingVideo(
//                       trimmer: _trimmer,
//                     ),
//                     SizedBox(
//                       child: Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: TrimViewer(
//                             trimmer: _trimmer,
//                             viewerHeight: 50.0,
//                             viewerWidth: MediaQuery.of(context).size.width,
//                             durationStyle: DurationStyle.FORMAT_MM_SS,
//                             maxVideoLength: Duration(
//                                 seconds: _trimmer.videoPlayerController!.value
//                                     .duration.inSeconds),
//                             editorProperties: const TrimEditorProperties(
//                                 borderPaintColor: Colors.yellow,
//                                 borderRadius: 5,
//                                 borderWidth: 4,
//                                 circlePaintColor: Colors.white),
//                             areaProperties: TrimAreaProperties.edgeBlur(
//                                 thumbnailQuality: 10),
//                             onChangeStart: (value) => _startValue = value,
//                             onChangeEnd: (value) => _endValue = value,
//                             onChangePlaybackState: (value) =>
//                                 setState(() => _isPlaying = value),
//                           )),
//                     ),
//                     TextButton(
//                         onPressed: () async {
//                           final playbackState =
//                               await _trimmer.videoPlaybackControl(
//                                   startValue: _startValue, endValue: _endValue);
//                           setState(() {
//                             _isPlaying = playbackState;
//                           });
//                         },
//                         child: _isPlaying
//                             ? const Icon(Icons.pause)
//                             : const Icon(Icons.play_arrow)),
//                     SaveButton(
//                         progressVisibilily: _progressVisibility,
//                         saveVideo: () {
//                           showDialog(
//                               context: context,
//                               builder: (ctx) => TrimmedVideoName(
//                                   nameController: _nameContoller,
//                                   addName: (String name) {
//                                     _saveVideo(name);
//                                   }));
//                         })
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
