import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/provider/playlists-providers/search_playlist_provider.dart';
import 'package:svdomain/provider/video-providers/serach_video_provider.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';

class TextfieldForSearch extends StatelessWidget {
  const TextfieldForSearch(
      {super.key,
      required this.focusNode,
      required this.ref,
      required this.text,
      required this.index});
  final FocusNode focusNode;
  final WidgetRef ref;
  final int index;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: AppColors.secondaryColor,
        focusNode: focusNode,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.secondaryBg,
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.secondaryColor, width: 1),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.secondaryColor, width: 1),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 30,
          ),
          label: Text(
            text,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        onChanged: (value) => index == 0
            ? ref.read(searchVideoProvider.notifier).runFilter(value)
            : ref.read(searchPlaylistProvider.notifier).runFilter(value));
  }
}
