import 'dart:math';

import 'package:flutter/material.dart';

class AccordeonModel {
  final String title;
  final String desc;
  final String? alert;
  bool expanded = false;
  late Key key;
  late int keyValue;

  String get bannerKey => title + desc;

  AccordeonModel({
    required this.title,
    required this.desc,
    this.alert,
  }) {
    keyValue = Random().nextInt(10000);
    key = Key(keyValue.toString());
  }
}