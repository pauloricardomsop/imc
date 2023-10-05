import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svr/app/app_controller.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:url_launcher/url_launcher.dart';

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
  var result = await Navigator.push(context ?? contextGlobal,
      MaterialPageRoute(builder: (_) => widget ?? Container()));
  return result;
}

String get random {
  final r = (1000 + Random().nextInt(9999 - 1000)).toString();
  return r;
}

String getInitials(String name) {
  final namesPart = name.split(' ');
  final first = namesPart.first.split(empty).first;
  final second = namesPart[1].split(empty).first;
  return (first + second).toUpperCase();
}

void copyClipboard(String data) {
  Clipboard.setData(ClipboardData(text: data));
  NotificationService.positive('Movido para área de transferência');
}

String toNonDiacritics(String value) {
  String diacritics =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  String nonDiacritics =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
  return value.splitMapJoin('',
      onNonMatch: (char) => char.isNotEmpty && diacritics.contains(char)
          ? nonDiacritics[diacritics.indexOf(char)]
          : char);
}

pops(BuildContext context, int length) {
  for (var i = 0; i < length; i++) {
    Navigator.pop(context);
  }
}

Future<void> nextPage(controller) async => await controller.nextPage(
    duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

Future<void> previousPage(controller) async => await controller.previousPage(
    duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

void execUrl(String url) {
  launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
}

void showDialogAndPush(context, Widget dialog, Widget page) async {
  await showDialog(context: context, builder: (_) => dialog);
  push(context, page);
}

void pop([BuildContext? context]) => Navigator.pop(context ?? contextGlobal);

String urlImage =
    'https://img.freepik.com/fotos-premium/sinal-de-trabalho-em-andamento-amarelo-com-listras_698953-677.jpg?w=2000';

void fazerChamada(String numero) async {
  String url = 'tel:$numero';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

void sendMensageWhatsApp(String numero, String mensagem) async {
  String url =
      'whatsapp://send?phone=$numero&text=${Uri.encodeComponent(mensagem)}';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Não foi possível enviar a mensagem pelo WhatsApp para $numero';
  }
}
