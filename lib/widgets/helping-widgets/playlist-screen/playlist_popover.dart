import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';

class PlaylistPopover{
  static void showPopOver(BuildContext context, final void Function() deletePlaylist,final void Function() renamePlaylist){
    showPopover(
          backgroundColor: AppColors.secondaryColor,
          direction: PopoverDirection.top,
          arrowHeight: 10,
          arrowWidth: 20,
          height: 100,
          width: 170,
          arrowDxOffset: -60,
          context: context,
          bodyBuilder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  deletePlaylist();
                  Navigator.pop(context);
                }, // Handle tap actions here
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  color: Colors.white30,
                  child: Text(
                    'Delete PlayList',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  renamePlaylist();
                }, // Handle tap actions here
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  color: Colors.black26,
                  child: // Button's onPressed handler (optional)
                      Text(
                    'Rename PlayList',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              )
            ],
          ),
          onPop: () => print('Popover was popped!'),
        );
  }
}