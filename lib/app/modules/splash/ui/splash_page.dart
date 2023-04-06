import 'package:flutter/material.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/card_xs.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/enums/benefit_enum.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/splash/splah_controller.dart';
import 'package:svr/app/modules/splash/splash_model.dart';

class SplashPage extends JourneyStatefulWidget {
  const SplashPage({Key? key}) : super(key: key, name: 'SplashPage');

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController _splashController = SplashController();

  @override
  void initState() {
    _splashController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: StreamOut<SplashItem>(
        stream: _splashController.splash.listen,
        child: (_, splash) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CardXs(
                    benefit: Benefit.app,
                  ),
                  const H(32),
                  Text(
                    'Dica importante!',
                    style: AppTheme.text.extra.xl3(const Color(0xFF1B1C1C)),
                  ),
                  const H(8),
                  Text(
                    'Mantenha seu cadastro atualizado para evitar cancelamento.',
                    style: AppTheme.text.normal.lg(const Color(0xFF474747)),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 8,
                  height: 8,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1B1C1C)),
                  ),
                ),
                const W(8),
                Text(
                  splash.label,
                  style: AppTheme.text.normal.sm(const Color(0xFF474747)),
                ),
                const W(32),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    backgroundColor: const Color(0xFFE3E2E2),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF006D3C)),
                    value: splash.progress / 100,
                  ),
                ),
                const W(8),
                Text('${splash.progress}%', style: AppTheme.text.semi.sm(const Color(0xFF474747)))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
