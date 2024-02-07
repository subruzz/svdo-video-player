import 'package:flutter/material.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';

class AddToPlaylistButton extends StatelessWidget {
  const AddToPlaylistButton(
      {super.key, required this.addToPlaylist, required this.text});
  final void Function() addToPlaylist;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: text == 'Done'
              ? AppColors.secondaryColor
              : AppColors.fontnButton),
      onPressed: addToPlaylist,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: text == 'Done' ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
