import 'package:flutter/material.dart';
import 'package:svdomain/widgets/snackbars/top_snackbar.dart';

class TrimmedVideoName extends StatelessWidget {
  const TrimmedVideoName(
      {super.key, required this.nameController, required this.addName});
  final TextEditingController nameController;
  final void Function(String name) addName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Add Name'),
      actions: [
        TextField(
          controller: nameController,
        ),
        TextButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                addName(nameController.text);
                Navigator.pop(context);
              } else {
                TopSnackBar.showCustomSnackBarError(
                    context, 'Name Can\'t be empty, Please Add A Name');
              }
            },
            child: const Text('Save'))
      ],
    );
  }
}
