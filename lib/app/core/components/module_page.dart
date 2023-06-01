import 'package:flutter/material.dart';
import 'package:svr/app/core/components/splash_old_page.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/enums/module_enum.dart';
import 'package:svr/app/core/utils/utils_controller.dart';

import '../../modules/home/home_page.dart';

class ModulePage extends StatelessWidget {
  ModulePage({Key? key}) : super(key: key);

  final UtilsController _utilsController = UtilsController();

  @override
  Widget build(BuildContext context) {
    return StreamOut<bool>(
      stream: _utilsController.ignoringStream.listen,
      child: (_, ignoring) => IgnorePointer(
        ignoring: ignoring,
        child: StreamOut(
          stream: _utilsController.moduleStream.listen,
          child: (_, module) => const SplashOldPage(),
          // child: (_, module) => module == Module.home ? const HomePage() : const SplashOldPage(),
        ),
      ),
    );
  }
}
