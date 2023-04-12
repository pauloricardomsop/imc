import 'package:flutter/material.dart';

class CardGridModel {
  final String title;
  final IconData icon;
  final void Function() onTap;
  CardGridModel({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
