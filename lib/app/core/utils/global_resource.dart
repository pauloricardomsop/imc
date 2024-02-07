import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svr/app/app_controller.dart';

const String empty = '';

BuildContext get contextGlobal => AppController().context;

List<NavigatorObserver> navigatorObservers = [ClearFocusOnPush()];

class ClearFocusOnPush extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }
}

double get height =>
    MediaQuery.of(AppController().context).size.height -
    (MediaQuery.of(AppController().context).padding.top +
        MediaQuery.of(AppController().context).padding.bottom);

double get width => MediaQuery.of(AppController().context).size.width;

dynamic push([a, b]) async {
  Widget? widget;
  BuildContext? context;
  if (a != null) {
    if (a is Widget) {
      widget = a;
    }
  } else {
    context = a;
  }
  if (b != null) {
    if (b is Widget) {
      widget = b;
    }
  } else {
    context = b;
  }
  var result = await Navigator.push(
      context ?? contextGlobal, MaterialPageRoute(builder: (_) => widget ?? Container()));
  return result;
}

String get random {
  final r = (1000 + Random().nextInt(9999 - 1000)).toString();
  return r;
}

pops(BuildContext context, int length) {
  for (var i = 0; i < length; i++) {
    Navigator.pop(context);
  }
}

Future<void> nextPage(controller) async =>
    await controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

Future<void> previousPage(controller) async => await controller.previousPage(
    duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

void showDialogAndPush(context, Widget dialog, Widget page) async {
  await showDialog(context: context, builder: (_) => dialog);
  push(context, page);
}

void pop([BuildContext? context]) => Navigator.pop(context ?? contextGlobal);
