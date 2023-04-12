import 'package:flutter/material.dart';

class CheckListModel {
  final IconData icon;
  final String label;
  final String? image;
  CheckListModel({
    required this.icon,
    required this.label,
    this.image,
  });
}
