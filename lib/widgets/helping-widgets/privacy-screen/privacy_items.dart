import 'package:flutter/material.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';

class PrivacyItems extends StatelessWidget {
  const PrivacyItems({super.key, required this.content, required this.heading});
  final String heading;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          heading,
          softWrap: true,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          content,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: AppColors.fontnButton),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
