import 'package:flutter/material.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';

class MainScreenOverlayitems extends StatelessWidget {
  const MainScreenOverlayitems(
      {super.key,
      required this.icon,
      required this.title,
      required this.itemClick});
  final String title;
  final IconData icon;
  final void Function() itemClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: itemClick,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.iconColors,
            size: 35,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.fontnButton),
          )
        ],
      ),
    );
  }
}
