import 'package:flutter/material.dart';
import 'package:svr/app/core/components/loading.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.all(18),
        children: [
          Row(
            children: const [
              Loading(),
              SizedBox(width: 18),
              //TODO
              // Text('Carregando...', style: AppTheme.text.bodyText1)
            ],
          )
        ],
      ),
    );
  }
}
