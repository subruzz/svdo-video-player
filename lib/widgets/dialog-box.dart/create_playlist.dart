import 'package:flutter/material.dart';
import 'package:svdomain/widgets/snackbars/top_snackbar.dart';

class AddPlaylistDialog extends StatelessWidget {
  const AddPlaylistDialog(
      {super.key, required this.nameController, required this.createPlaylist});
  final TextEditingController nameController;
  final void Function() createPlaylist;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Add playlist'),
      actions: [
        TextField(
          controller: nameController,
        ),
        TextButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                createPlaylist();
              } else {
                TopSnackBar.showCustomSnackBarError(
                    context, 'PlayList Name Is Empty. Please Add A Name');
             
              }
            },
            child: const Text('Create'))
      ],
    );
  }
}
