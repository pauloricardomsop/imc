import 'package:flutter/material.dart';
import 'package:svr/app/core/components/app_image.dart';

class CheckListModel {
  final IconData icon;
  final String label;
  final AppImage? image;
  Color? color;
  CheckListModel({
    required this.icon,
    required this.label,
    this.image,
    this.color = const Color(0xFF1C44F9),
  });
}
