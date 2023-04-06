import 'package:flutter/material.dart';
import 'package:svr/app/core/components/module_page.dart';

class RouteService {
  static String initial = '/';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (_) => ModulePage(),
  };
}
