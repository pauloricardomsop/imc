import 'package:flutter/material.dart';
import 'package:svr/app/core/components/splash_old_page.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/enums/module_enum.dart';
import 'package:svr/app/core/utils/utils_controller.dart';
import 'package:svr/app/modules/home/home_page.dart';
import 'package:svr/app/modules/onboarding/onboarding_page.dart';

class ModulePage extends StatefulWidget {
  const ModulePage({Key? key}) : super(key: key);

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final UtilsController _utilsController = UtilsController();

  @override
  void initState() {
    _utilsController.getShowOnboarding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamOut<bool>(
        stream: _utilsController.ignoringStream.listen,
        child: (_, ignoring) => IgnorePointer(
              ignoring: ignoring,
              child: StreamOut(
                stream: _utilsController.moduleStream.listen,
                child: (_, module) => StreamOut(
                    stream: _utilsController.showOnboarding.listen,
                    child: (_, showOnboarding) => _buildPage(module, showOnboarding)),
              ),
            ));
  }

  Widget _buildPage(Module module, bool showOnboarding) {
    if (module == Module.splash) {
      return const SplashOldPage();
    }
    if (showOnboarding) return const OnboardingPage();
    return const HomePage();
  }
}
