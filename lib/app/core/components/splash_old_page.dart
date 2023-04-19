import 'package:flutter/material.dart';
import 'package:svr/app/core/components/app_scaffold.dart';

class SplashOldPage extends StatefulWidget {
  const SplashOldPage({Key? key}) : super(key: key);

  @override
  State<SplashOldPage> createState() => _SplashOldPageState();
}

class _SplashOldPageState extends State<SplashOldPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Container(
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
          ],
        ),
      ),
    );
  }
}
