import 'package:svr/app/core/utils/global_resource.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static void negative(
    String label,
  ) =>
      ScaffoldMessenger.of(contextGlobal).showSnackBar(
        SnackBar(
          content: Text(
            label,
          ),
        ),
      );
  static void positive(
    String label,
  ) =>
      ScaffoldMessenger.of(contextGlobal).showSnackBar(
        SnackBar(
          content: Text(
            label,
          ),
        ),
      );
  static void neutral(
    String label,
  ) =>
      ScaffoldMessenger.of(contextGlobal).showSnackBar(
        SnackBar(
          content: Text(
            label,
          ),
        ),
      );
}
