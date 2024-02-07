import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TopSnackBar {
  static void showCustomSnackBarInfo(BuildContext context, String message) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          message: message,
        ),
        dismissDirection: [
          DismissDirection.down,
          DismissDirection.up,
          DismissDirection.endToStart,
          DismissDirection.startToEnd
        ]);
  }

  static void showCustomSnackBarSuccess(BuildContext context, String message) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message,
        ),
        dismissDirection: [
          DismissDirection.down,
          DismissDirection.up,
          DismissDirection.endToStart,
          DismissDirection.startToEnd
        ]);
  }

  static void showCustomSnackBarError(BuildContext context, String message) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: message,
        ),
        dismissDirection: [
          DismissDirection.down,
          DismissDirection.up,
          DismissDirection.endToStart,
          DismissDirection.startToEnd
        ]);
  }
}
