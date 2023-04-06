import 'package:benefits_brazil/app/core/components/module_page.dart';
import 'package:flutter/material.dart';

class RouteService {
  static String initial = '/';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (_) => ModulePage(),
  };
}
