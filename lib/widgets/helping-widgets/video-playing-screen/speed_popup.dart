import 'package:flutter/material.dart';

class SpeedSelect extends StatelessWidget {
  const SpeedSelect({super.key, required this.setPlaybackSpeed});
  final void Function(double value) setPlaybackSpeed;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
      initialValue: null,
      onSelected: (double value) {},
      itemBuilder: (BuildContext context) => <PopupMenuEntry<double>>[
        PopupMenuItem<double>(
          onTap: () {
            setPlaybackSpeed(.5);
          },
          value: 0.5,
          child: const Text('0.5x'),
        ),
        PopupMenuItem<double>(
          onTap: () {
            setPlaybackSpeed(1);
          },
          value: 1,
          child: const Text('1x'),
        ),
        PopupMenuItem<double>(
          value: 1.5,
          onTap: () {
            setPlaybackSpeed(1.5);
          },
          child: const Text('1.5x'),
        ),
        PopupMenuItem<double>(
          onTap: () {
            setPlaybackSpeed(2);
          },
          value: 2,
          child: const Text('2x'),
        ),
      ],
      child: const Icon(
        (Icons.settings),
        color: Colors.grey,
      ),
    );
  }
}
