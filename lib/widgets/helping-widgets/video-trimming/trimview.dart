// import 'package:flutter/material.dart';
// import 'package:video_trimmer/video_trimmer.dart';

// class TrimmingBar extends StatelessWidget {
//   const TrimmingBar({super.key,required this.endValue,required this.playAndPause,required this.startValue});
// final Trimmer trimmer;
// final double startValue;
// final double endValue;
// final Function(bool value) playAndPause;
//   @override
//   Widget build(BuildContext context) {
//     return     Container(
//                       child: Padding(
//                           padding: EdgeInsets.all(10),
//                           child: TrimViewer(
//                             trimmer: trimmer,
//                             viewerHeight: 50.0,
//                             viewerWidth: MediaQuery.of(context).size.width,
//                             durationStyle: DurationStyle.FORMAT_MM_SS,
//                             maxVideoLength: Duration(
//                                 seconds: trimmer.videoPlayerController!.value
//                                     .duration.inSeconds),
//                             editorProperties: const TrimEditorProperties(
//                                 borderPaintColor: Colors.yellow,
//                                 borderRadius: 5,
//                                 borderWidth: 4,
//                                 circlePaintColor: Colors.white),
//                             areaProperties: TrimAreaProperties.edgeBlur(
//                                 thumbnailQuality: 10),
//                             onChangeStart: (value) => startValue = value,
//                             onChangeEnd: (value) => endValue = value,
//                             onChangePlaybackState: (value) =>
//                                 setState(() => _isPlaying = value),
//                           )),
//                     );
//   }
// }