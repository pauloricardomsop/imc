import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(const App());
}