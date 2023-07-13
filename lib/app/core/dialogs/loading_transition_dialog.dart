import 'package:flutter/material.dart';
import 'package:svr/app/core/theme/app_theme.dart';

class LoadingTransitionDialog extends StatefulWidget {
  const LoadingTransitionDialog({Key? key}) : super(key: key);

  @override
  State<LoadingTransitionDialog> createState() => _LoadingTransitionDialogState();
}

class _LoadingTransitionDialogState extends State<LoadingTransitionDialog> {
  String label = 'Aguarde um momento';
  int percent = 75;

  @override
  void initState() {
    onUpdateText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 400,
                width: 240,
                height: 240,
                child: CircularProgressIndicator(
                  value: percent / 100,
                  strokeWidth: 8,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1C44F9)),
                  color: Colors.grey,
                  backgroundColor: Colors.grey,
                ),
              ),
              Positioned(bottom: 480, child: Text('$percent%', style: AppTheme.text.extra.xl6())),
              Positioned(
                bottom: 300,
                child: Text(label, style: AppTheme.text.extra.xl3()),
              ),
              Positioned(
                bottom: 260,
                child: Text('O resultado aparecerá após o anúncio.',
                    style: AppTheme.text.normal.sm(const Color(0xFF1B1C1C))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onUpdateText() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      label = 'Carregando informações';
      percent = 99;
    });
  }
}
