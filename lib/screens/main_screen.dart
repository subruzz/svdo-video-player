import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:svdomain/data/video-related/get_videos.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';
import 'package:svdomain/widgets/bottom-nav-widgets/all_video_display.dart';
import 'package:svdomain/widgets/bottom-nav-widgets/folder_videos.dart';
import 'package:svdomain/widgets/bottom-nav-widgets/more_section.dart';
import 'package:svdomain/widgets/bottom-nav-widgets/playlist_screen.dart';
import 'package:svdomain/widgets/helping-widgets/top-items/main_screen_top.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({
    super.key,
  });
  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  // void checkPermission()async {
  //   PermissionStatus permissionStatus;
  //   final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   final androidInfo = await deviceInfo.androidInfo;
    
  //   if(permissionStatus.isDenied){
      
  //   }
  // }
  bool isLoading = true;
  IconData? _icon = Icons.search;
  IconData? _icon2 = Icons.sort;
  Widget currentWidget = const AllVideoDisplay();
  int _currentIndex = 0;
  void onTabTapped(int index) {
    _currentIndex = index;
    setState(() {
      switch (index) {
        case 0:
          {
            _icon = Icons.search;
            _icon2 = Icons.sort;
            currentWidget = const AllVideoDisplay();
          }
          break;
        case 1:
          {
            _icon = null;
            _icon2 = null;
            currentWidget = const FolderVideos();
          }
          break;
        case 2:
          {
            _icon = null;
            _icon2 = Icons.search;
            currentWidget = const PlayListScreen();
          }
          break;
        case 3:
          {
            _icon = null;
            _icon2 = Icons.settings;
            currentWidget = const MoreScreen();
          }
          break;
      }
    });
  }

  @override
  void initState() {
    // FetchVideos.getVideoPathsAsync(ref);
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Visibility(
        visible: !isLoading,
        child: ColoredBox(
          color: AppColors.bottomNavigationColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GNav(
              onTabChange: (index) {
                onTabTapped(index);
              },
              gap: 8,
              activeColor: AppColors.fontnButton,
              tabBackgroundColor: AppColors.bgColor,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.video_collection,
                  text: 'Videos',
                ),
                GButton(
                  icon: Icons.folder,
                  text: 'Folder',
                ),
                GButton(
                  icon: Icons.playlist_add_check_circle_sharp,
                  text: 'Playlists',
                ),
                GButton(
                  icon: Icons.more_horiz,
                  text: 'more',
                )
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Column(
            children: [
              MainScreenTopItems(
                icon1: _icon,
                icon2: _icon2,
                index: _currentIndex,
              ),
              const SizedBox(
                height: 30,
              ),
              isLoading
                  ? Lottie.asset('assets/images/Animation - 1705573184448.json')
                  : currentWidget
            ],
          ),
        ),
      ),
    );
  }
}
