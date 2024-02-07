import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PlaylistItemCheck extends StatefulWidget {
  const PlaylistItemCheck(
      {super.key, required this.title, required this.onCheck});
  final String title;
  final void Function(bool value, String title) onCheck;
  @override
  State<PlaylistItemCheck> createState() => _PlaylistItemCheckState();
}

class _PlaylistItemCheckState extends State<PlaylistItemCheck> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        secondary: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Lottie.asset('assets/images/Animation - 1705728223899.json',
              width: 50, fit: BoxFit.cover),
        ),
      
        title: Text(widget.title),
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
          widget.onCheck(isChecked, widget.title);
        });
  }
}
