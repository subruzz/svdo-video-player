import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/provider/video-providers/video_provider.dart';
import 'package:svdomain/screens/search_playlist.dart';
import 'package:svdomain/screens/search_video.dart';
import 'package:svdomain/screens/settings_screen.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';
import 'package:svdomain/util-classes/styling/app_item_size.dart';

class MainScreenTopItems extends ConsumerWidget {
  const MainScreenTopItems(
      {super.key,
      required this.icon1,
      required this.icon2,
      required this.index});
  final IconData? icon1;
  final IconData? icon2;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSortedByName = ref.watch(sortByNameProvider);

    bool isSortedBySize = ref.watch(sortBySizeProvider);
    return Row(
      children: [
        Image.asset(
          'assets/images/applogo.png',
          width: 120,
          color: AppColors.imageColor,
        ),
        const Spacer(),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => SearchVideoScreen(
                      index: index,
                    ),
                  ),
                );
              },
              icon: Icon(
                icon1,
                size: AppSizes.appBarIconSize,
              ),
            ),
            index == 0
                ? PopupMenuButton(
                    child: Icon(
                      Icons.sort,
                      size: AppSizes.appBarIconSize,
                    ),
                    onSelected: (value) {
                      if (value == 'byName') {
                        ref
                            .read(videoPathsProvider.notifier)
                            .sortByName(isSortedByName);
                        ref.read(sortByNameProvider.notifier).state =
                            !isSortedByName;
                      }
                      if (value == 'bySize') {
                        ref
                            .read(videoPathsProvider.notifier)
                            .sortBySize(isSortedBySize);
                      }
                      ref.read(sortBySizeProvider.notifier).state =
                          !isSortedBySize;
                    },
                    itemBuilder: (BuildContext ctx) {
                      return [
                        PopupMenuItem(
                          value: 'byName',
                          child: Text('Name ${isSortedByName ? 'A-Z' : 'Z-A'}'),
                        ),
                        PopupMenuItem(
                          value: 'bySize',
                          child: Text('Size ${isSortedBySize ? 'S-L' : 'L-S'}'),
                        ),
                      ];
                    },
                  )
                : IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => index == 2
                              ? SearchPlaylist(
                                  index: index,
                                )
                              : const SettingScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      icon2,
                      size: AppSizes.appBarIconSize,
                    ),
                  ),
          ],
        )
      ],
    );
  }
}
