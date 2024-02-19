import 'package:flutter/material.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';

class MoreItems extends StatelessWidget {
  const MoreItems(
      {super.key,
      required this.icon,
      required this.title,
      required this.onClick});
  final String title;
  final IconData? icon;
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        contentPadding:const EdgeInsets.all(0) ,
         onTap: onClick,
        leading: Icon(
          icon,
          size: 30,
          color: AppColors.iconColors,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: title != 'Share'
            ? const Icon(
                Icons.keyboard_arrow_right,
                size: 35,
                color: AppColors.iconColors,
              )
            : const SizedBox(),
      ),
    );
    
  }
}
