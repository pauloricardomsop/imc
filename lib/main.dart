import 'package:flutter/material.dart';
import 'package:svr/app/app_widget.dart';

void main() async => initializeServices().then((_) => runApp(const App()));
