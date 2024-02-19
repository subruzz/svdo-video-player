import 'package:flutter/material.dart';
import 'package:svdomain/widgets/overlay-widgets/main-screen-overlay/video_click_overlay.dart';

class CreateOverlays {
  static void openVideoDetailsOverlay(
      int index, BuildContext context, List<String> allVideos) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return MainScreenOverlay(
          allvideos: allVideos,
          index: index,
        );
      },
    );
  }
}

