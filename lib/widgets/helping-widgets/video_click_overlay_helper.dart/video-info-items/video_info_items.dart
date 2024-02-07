import 'package:flutter/material.dart';

class VideoInformationItems extends StatelessWidget {
  const VideoInformationItems(
      {super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
