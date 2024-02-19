import 'package:flutter/material.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';

class EachFolder extends StatelessWidget {
  const EachFolder({
    super.key,
    required this.onFolderClick,
    required this.folder,
  });

  final void Function() onFolderClick;
  final String folder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFolderClick,
      child: Row(
        children: [
          const Icon(
            Icons.folder_rounded,
            size: 50,
            color: AppColors.iconColors,
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: Text(
              folder,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          )
        ],
      ),
    );
  }
}
