import 'dart:io';

import 'package:flutter/material.dart';
import 'package:svdomain/data/video-related/video_thumbnail.dart';

class MainVideoThumbnail extends StatelessWidget {
  const MainVideoThumbnail(
      {super.key, required this.videoPath, required this.width,this.height});
  final double width;
  final String videoPath;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: VideoThumbnail.loadThumbnail(videoPath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              width: 200,
              height: 100,
            );
          } else {
            return Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: snapshot.data != null
                        ? Image.file(
                            File(snapshot.data!),
                            width: width,
                            height: height??100,
                            fit: BoxFit.cover,
                          )
                        :  Image.asset('assets/images/applogo.png',width: 200,
                        height: 100,)),
              ],
            );
          }
        });
  }
}
