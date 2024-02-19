import 'package:flutter/material.dart';
import 'package:svdomain/data/models/recently_watched.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';

class RecentProgress extends StatelessWidget {
  const RecentProgress({super.key, required this.recentVideo});
  final RecentVideos recentVideo;
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      minHeight: 5,
      backgroundColor: AppColors.iconColors,
      color: AppColors.secondaryColor,
      value: recentVideo.totalLength != 0
          ? recentVideo.watchedLength / recentVideo.totalLength
          : 0.0, // Or any default value you prefer
    );
  }
}
