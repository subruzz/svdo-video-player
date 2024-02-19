import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/data/models/liked_video.dart';
import 'package:svdomain/data/models/recently_watched.dart';
import 'package:svdomain/data/video-related/video-playing/video_playing.dart';
import 'package:svdomain/provider/liked_videos_provider.dart';
import 'package:svdomain/provider/recently_watched_provider.dart';
import 'package:svdomain/provider/theme-providers/settings_provider.dart';
import 'package:svdomain/screens/add_to_playlist.dart';
import 'package:svdomain/widgets/helping-widgets/video-playing-screen/video.dart';
import 'package:svdomain/widgets/helping-widgets/video-playing-screen/video_controller.dart';
import 'package:svdomain/widgets/helping-widgets/video-playing-screen/video_progress.dart';
import 'package:svdomain/widgets/helping-widgets/video-playing-screen/video_title.dart';
import 'package:svdomain/widgets/snackbars/top_snackbar.dart';
import 'package:video_player/video_player.dart';
import 'package:volume_controller/volume_controller.dart';

class VideoPlayingScreen extends ConsumerStatefulWidget {
  const VideoPlayingScreen(
      {super.key,
      this.video,
      this.singleVideo,
      required this.index,
      required this.videoTitle});
  final List<String>? video;
  final int index;
  final String? singleVideo;
  final String videoTitle;
  @override
  ConsumerState<VideoPlayingScreen> createState() => _VideoPlayingScreenState();
}

class _VideoPlayingScreenState extends ConsumerState<VideoPlayingScreen>
    with WidgetsBindingObserver {
  String file = '';
  late int currentIndex;
  bool _isMuted = false;
  bool _isSeekLeft = false;
  bool _isSeekRight = false;

  late VideoPlayerController _controller;
  bool _showControls = true;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    currentIndex = widget.index;
    file = widget.singleVideo ?? widget.video![currentIndex];
    initiliazeVideoPlayer(file);
    super.initState();
  }

//to mute and unmute the video
  void _muteVideo() {
    setState(() {
      _isMuted = !_isMuted;
      _isMuted ? _controller.setVolume(0.0) : _controller.setVolume(1.0);
    });
  }

// to play next video
  void _playNextVideo() {
    setState(() {
      currentIndex--;
      initiliazeVideoPlayer(widget.video![currentIndex % widget.video!.length]);
    });
  }

//play previous video
  void _playPrevious() {
    setState(() {
      currentIndex++;
      initiliazeVideoPlayer(widget.video![currentIndex % widget.video!.length]);
    });
  }

  //initializing the video
  void initiliazeVideoPlayer(String file) {
    _controller = VideoPlayerController.file(File(file))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.play();
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _showControls = false;
          });
        });
      });
    VolumeController().listener((volume) {
      setState(() {
        _setVolumeValue = _controller.value.volume;
      });
    });

    VolumeController().getVolume().then((volume) => _setVolumeValue = volume);
  }

  //to add to recent
  void addRecent() {
    final isRecentEnabled = ref.watch(settingsProvider)[Filter.showRecents];

    if (isRecentEnabled != null && isRecentEnabled) {
      ref.read(recentlyWatchedProvider.notifier).addToRecent(
            RecentVideos(
              videoFile: file,
              recentTime: DateTime.now(),
              totalLength: _controller.value.duration.inSeconds.toDouble(),
              watchedLength: _controller.value.position.inSeconds.toDouble(),
            ),
          );
    }
  }
//set playback speed
void setPlaybackSpeed(double value){
  
}
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    VideoPlayingHelper.setAllOrientation();
    // _customVideoController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      addRecent();
    }
  }

//to play and pause
  void _playAndPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
    setState(() {
      _showControls = true;
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _showControls = false;
        });
      });
    });
  }

  void _onScreenTap() {
    setState(() {
      _showControls = !_showControls;
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          _showControls = false;
        });
      });
    });
  }

  void seekDuration(bool value, VideoPlayerController controller) {
    Duration currentPosition = controller.value.position;
    int offset = value ? 10 : -10;
    controller.seekTo(Duration(seconds: currentPosition.inSeconds + offset));
    setState(() {
      if (value) {
        _isSeekRight = true;
        _isSeekLeft = false;
      } else {
        _isSeekRight = false;
        _isSeekLeft = true;
      }
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        value ? _isSeekRight = false : _isSeekLeft = false;
      });
    });
  }

  void _adjustVolume(double deltaY) {
    final currentVolume = _controller.value.volume;
    final newVolume =
        currentVolume - deltaY * 0.005; // Adjust sensitivity as needed
    _controller.setVolume(newVolume.clamp(0.0, 1.0));
    setState(() {
      _setVolumeValue = currentVolume;
      VolumeController().setVolume(_setVolumeValue, showSystemUI: true);
    });
  }

  void _adjustVideoPosition(double deltaX) {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition +
        Duration(
            milliseconds:
                (deltaX * 200).toInt()); // Adjust sensitivity as needed
    _controller.seekTo(newPosition);
  }

  void addToLiked(String videoPath) {
    final isAlready = ref.read(likedVideosProvider.notifier).addtToLiked(
        LikedVideo(videoFile: videoPath, favoriteTime: DateTime.now()));
    isAlready
        ? TopSnackBar.showCustomSnackBarInfo(
            context, 'Video Already available in the Favorite collection')
        : TopSnackBar.showCustomSnackBarSuccess(
            context, 'Video Added To Favorite Collection');
  }

  bool _isshowDuration = false;
  double _setVolumeValue = 0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) {
        addRecent();
      },
      child: SafeArea(
        child: Scaffold(
          body: File(file).existsSync()
              ? OrientationBuilder(
                  builder: (context, orientation) {
                    final isPortrait = orientation == Orientation.portrait;
                    return GestureDetector(
                      onVerticalDragUpdate: (details) {
                        if (details.localPosition.dx >
                            MediaQuery.of(context).size.width / 2) {
                          double deltaY = details.delta.dy;

                          _adjustVolume(deltaY);
                        }
                      },
                      onTap: () {
                        _onScreenTap();
                      },
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _isshowDuration = true;
                        });
                        double deltaX = details.delta.dx;
                        _adjustVideoPosition(deltaX);
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() {
                            _isshowDuration = false;
                          });
                        });
                      },
                      child: Container(
                        color: Colors.black,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            if (isPortrait)
                              VideoTitle(
                                addToPlaylist: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => AddToPlayListScreen(
                                          videoPath: widget.singleVideo ??
                                              widget.video![currentIndex]),
                                    ),
                                  );
                                },
                                addToLiked: (file) {
                                  addToLiked(file);
                                },
                                file: file,
                              ),
                            _controller.value.isInitialized
                                ? VideoItem(
                                    videoHold: (double value) {
                                      _controller.setPlaybackSpeed(value);
                                      setState(() {
                                        _isshowDuration =
                                            value == 1 ? false : true;
                                      });
                                    },
                                    isShowDuration: _isshowDuration,
                                    isSeekLeft: _isSeekLeft,
                                    isSeekRight: _isSeekRight,
                                    seekDuration: (value) {
                                      seekDuration(value, _controller);
                                    },
                                    isPortrait: isPortrait,
                                    controller: _controller,
                                    showControls: _showControls,
                                    playAndPause: _playAndPause)
                                : Container(),
                            // : SizedBox(), //
                            if (_showControls)
                              Positioned(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: VideoProgressBar(
                                          controller: _controller,
                                        )),
                                    VideoControlls(
                                      seekDuration: (value) {
                                        seekDuration(value, _controller);
                                      },
                                      singleVideo: widget.singleVideo,
                                      controller: _controller,
                                      isMuted: _isMuted,
                                      isPortrait: isPortrait,
                                      muteVideo: _muteVideo,
                                      playAndPause: _playAndPause,
                                      playNextVideo: _playNextVideo,
                                      playPrevious: _playPrevious,
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('Video Not found'),
                ),
        ),
      ),
    );
  }
}
