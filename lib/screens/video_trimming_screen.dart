// import 'dart:io';

// import 'package:flutter/material.dart';

// class TrimmerView extends StatefulWidget {
//   const TrimmerView({super.key, required this.file});
//   final String file;

//   @override
//   State<TrimmerView> createState() => _VideoTrimmmerState();
// }

// class _VideoTrimmmerState extends State<TrimmerView> {
//   final Trimmer _trimmer = Trimmer();

//   double _startValue = 0.0;
//   double _endValue = 0.0;

//   bool _isPlaying = false;
//   bool _progressVisibility = false;
//   void _loadVideo() {
//     _trimmer.loadVideo(videoFile: File(widget.file));
//   }

//   @override
//   void initState() {
//     super.initState();

//     _loadVideo();
//   }

//   Future<String?> _saveVideo() async {
//     setState(() {
//       _progressVisibility = true;
//     });

//     String? _value;

//     await _trimmer
//         .saveTrimmedVideo(
//             startValue: _startValue,
//             endValue: _endValue,
//             onSave: ((outputPath) {
//               setState(() {
//                 _progressVisibility = false;
//                 // _value = value;
//               });

//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (ctx) => Preview(outputVideoPath: outputPath)));
//             }))
//         .then((value) {});

//     return _value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Visibility(
//                   visible: _progressVisibility,
//                   child: const LinearProgressIndicator(
//                     backgroundColor: Colors.red,
//                   )),
//               ElevatedButton(
//                   onPressed: _progressVisibility
//                       ? null
//                       : () async {
//                           _saveVideo().then((value) {
//                             final snackBar =
//                                 SnackBar(content: Text('video trimmed $value'));
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackBar);
//                           });
//                         },
//                   child: const Text('save')),
//               Container(
//                 child: Padding(
//                     padding: EdgeInsets.all(10),
//                     child: TrimViewer(
//                       trimmer: _trimmer,
//                       viewerHeight: 50.0,
//                       viewerWidth: MediaQuery.of(context).size.width,
//                       durationStyle: DurationStyle.FORMAT_MM_SS,
//                       maxVideoLength: Duration(
//                           seconds: _trimmer
//                               .videoPlayerController!.value.duration.inSeconds),
//                       editorProperties: const TrimEditorProperties(
//                           borderPaintColor: Colors.yellow,
//                           borderRadius: 5,
//                           borderWidth: 4,
//                           circlePaintColor: Colors.white),
//                       areaProperties:
//                           TrimAreaProperties.edgeBlur(thumbnailQuality: 10),
//                       onChangeStart: (value) => _startValue = value,
//                       onChangeEnd: (value) => _endValue = value,
//                       onChangePlaybackState: (value) =>
//                           setState(() => _isPlaying = value),
//                     )),
//               ),
//               TextButton(
//                   onPressed: () async {
//                     final playbackState = await _trimmer.videoPlaybackControl(
//                         startValue: _startValue, endValue: _endValue);
//                     setState(() {
//                       _isPlaying = playbackState;
//                     });
//                   },
//                   child: _isPlaying
//                       ? const Icon(Icons.pause)
//                       : const Icon(Icons.play_arrow))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
