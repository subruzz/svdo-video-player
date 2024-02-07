import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/provider/recently_watched_provider.dart';
import 'package:svdomain/widgets/snackbars/top_snackbar.dart';

class ChoiceDialog extends ConsumerWidget {
  const ChoiceDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onPressed: () {
                  ref.read(recentlyWatchedProvider.notifier).clearRecent();
                    TopSnackBar.showCustomSnackBarInfo(
        context, 'Recnently Watched Has Been Cleared');
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                )),
          ],
        )
      ],
      title: Text('Are you sure you want to clear Recents?',
      textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium),
    );
  }
}
