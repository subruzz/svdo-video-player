import 'package:flutter/material.dart';
import 'package:svdomain/data/video-related/video_duration.dart';

class MainVideoDuration extends StatelessWidget {
  const MainVideoDuration({super.key, required this.videoPath});
  final String videoPath;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: VideoDuration.getTime(videoPath),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else {
          return Positioned(
            left: 5,
            bottom: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.8),
                  borderRadius: BorderRadius.circular(7)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  snapshot.data ?? '0',
           
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
