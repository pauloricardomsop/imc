import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/modules/splash/splah_controller.dart';
import 'package:svr/app/modules/splash/splash_model.dart';

class SplashPage extends StatefulWidget {
  final Function onDispose;

  const SplashPage(this.onDispose, {Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController _splashController = SplashController();

  @override
  void initState() {
    FlutterNativeSplash.remove();
    _splashController.init(widget.onDispose);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: StreamOut<SplashItem>(
        stream: _splashController.splash.listen,
        child: (_, splash) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 246,
                height: 246,
                child: Image.asset('assets/images/logo.png'),
              ),
              const H(32),
              Row(
                children: [
                  Text(
                    splash.label,
                    style: AppTheme.text.normal.sm(const Color(0xFF474747)),
                  ),
                  const Spacer(),
                  Text('${splash.progress}%',
                      style: AppTheme.text.semi.sm(const Color(0xFF1C44F9)))
                ],
              ),
              const H(8),
              Row(
                children: [
                  Expanded(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: splash.progress / 100),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      builder: (_, value, child) {
                        return LinearProgressIndicator(
                          backgroundColor: const Color(0xFFE3E2E2),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF1C44F9)),
                          value: value,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
