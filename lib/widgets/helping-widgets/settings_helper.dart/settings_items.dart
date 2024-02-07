import 'package:flutter/material.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.title,
      required this.isEnabled,
      required this.onEnable});
  final String title;
  final bool isEnabled;
  final void Function(bool value) onEnable;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      inactiveTrackColor: AppColors.bgColor,
      inactiveThumbColor: AppColors.secondaryColor,
      activeTrackColor: AppColors.secondaryColor,
      value: isEnabled,
      onChanged: (isChecked) {
        onEnable(isChecked);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      activeColor: AppColors.bgColor,
    );
  }
}
