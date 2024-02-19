import 'package:flutter/material.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';

class AddToPlayListSearch extends StatelessWidget {
  const AddToPlayListSearch({super.key, required this.runFilter});
  final void Function(String value) runFilter;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.secondaryColor,
      // focusNode: _searchFocusNode,
      style: Theme.of(context).textTheme.labelSmall,
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
          'Search Playlist...',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      onChanged: (value) => runFilter(value),
    );
  }
}
