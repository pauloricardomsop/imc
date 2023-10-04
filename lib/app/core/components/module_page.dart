import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/app_controller.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/enums/module_enum.dart';
import 'package:svr/app/core/utils/utils_controller.dart';
import 'package:svr/app/modules/home/home_page.dart';

class ModulePage extends StatefulWidget {
  const ModulePage({Key? key}) : super(key: key);

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final UtilsController _utilsController = UtilsController();

  @override
  Widget build(BuildContext context) {
    return StreamOut<bool>(
        loading: const BackgroundPage(),
        stream: _utilsController.ignoringStream.listen,
        child: (_, ignoring) => IgnorePointer(
              ignoring: ignoring,
              child: StreamOut<Module>(
                loading: const BackgroundPage(),
                stream: _utilsController.moduleStream.listen,
                child: (_, module) => module == Module.home
                    ? HomePage()
                    : LoadingPage.open(
                        (_) => AppController().initialize(),
                      ),
              ),
            ));
  }
}
