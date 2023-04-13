import 'package:flutter/material.dart';
import 'package:svr/app/core/components/app_image.dart';

class CheckListModel {
  final IconData icon;
  final String label;
  final AppImage? image;
  CheckListModel({
    required this.icon,
    required this.label,
    this.image,
  });
}
