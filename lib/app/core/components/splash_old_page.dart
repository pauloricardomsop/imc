import 'package:flutter/material.dart';
import 'package:svr/app/core/theme/app_theme.dart';

class SplashOldPage extends StatefulWidget {
  const SplashOldPage({Key? key}) : super(key: key);

  @override
  State<SplashOldPage> createState() => _SplashOldPageState();
}

class _SplashOldPageState extends State<SplashOldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
                child: SizedBox(
              width: 246,
              height: 246,
              child: Image.asset('assets/images/loading.gif'),
            )),
            SizedBox(width: 200, height: 200, child: Image.asset('assets/images/logo.png')),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 278),
                child: Text(
                  'Abrindo o App...',
                  style: AppTheme.text.normal.sm(const Color(0xFF1C44F9)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
