import 'package:flutter/material.dart';

class TrimVideoAlert extends StatelessWidget {
  const TrimVideoAlert({super.key, required this.delteFile});
  final Function() delteFile;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
            IconButton(
                onPressed: () async {
                  try {
                    delteFile();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    return;
                  }
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                )),
          ],
        )
      ],
      title: Text(
        'Are you sure you want to delete?',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
