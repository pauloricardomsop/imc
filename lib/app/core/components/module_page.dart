import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/enums/module_enum.dart';
import 'package:svr/app/core/utils/utils_controller.dart';
import 'package:svr/app/modules/home/home_page.dart';
import 'package:svr/app/modules/splash/ui/splash_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

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
        loading: const BackgroundPage(),
        stream: _utilsController.ignoringStream.listen,
        child: (_, ignoring) => IgnorePointer(
              ignoring: ignoring,
              child: StreamOut(
                loading: const BackgroundPage(),
                stream: _utilsController.moduleStream.listen,
                child: (_, module) => StreamOut(
                    stream: _utilsController.showOnboarding.listen,
                    loading: const BackgroundPage(),
                    child: (_, showOnboarding) =>
                        _buildPage(module, showOnboarding)),
              ),
            ));
  }

  Widget _buildPage(Module module, bool showOnboarding) {
    if (module == Module.splash) {
      return SplashPage(() => _utilsController.moduleStream.add(Module.home));
    }
    return HomePage();
  }
}
