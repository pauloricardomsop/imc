import 'package:flutter/material.dart';
import 'package:svr/app/core/dialogs/loading_dialog.dart';
import 'package:svr/app/core/dialogs/loading_transition_dialog.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class DialogUtils {
  static showLoadingDialog([BuildContext? context]) {
    context ??= contextGlobal;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          FocusManager.instance.primaryFocus!.unfocus();
          return const LoadingDialog();
        });
  }

  static showTransitionLoadingDialog([BuildContext? context]) {
    context ??= contextGlobal;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          FocusManager.instance.primaryFocus!.unfocus();
          return const LoadingTransitionDialog();
        });
  }

  static Future<dynamic> showAppDialog(BuildContext context, Widget widget) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          FocusManager.instance.primaryFocus!.unfocus();
          return widget;
        });
  }
}
