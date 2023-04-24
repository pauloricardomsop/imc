import 'package:flutter/material.dart';
import 'package:svr/app/core/components/loading.dart';
import 'package:svr/app/core/theme/app_theme.dart';

class LoadingTransitionDialog extends StatelessWidget {
  const LoadingTransitionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.all(18),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Loading(
                color: Color(0xFF1C44F9),
              ),
              const SizedBox(height: 12),
              Text('Aguarde redirecionando...', style: AppTheme.text.semi.base(const Color(0xFF474747)))
            ],
          )
        ],
      ),
    );
  }
}
