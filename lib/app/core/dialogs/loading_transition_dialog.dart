import 'package:flutter/material.dart';
import 'package:svr/app/core/components/app_image.dart';
import 'package:svr/app/core/components/app_shimmer.dart';
import 'package:svr/app/core/components/h.dart';
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
      child: SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppImage(
                url: 'https://ldcapps.com/wp-content/uploads/2023/05/cuate.svg',
                isSVG: true,
              ),
              const H(12),
              Row(
                children: [
                  Expanded(
                    child:
                        Text('$label...', style: AppTheme.text.semi.base(const Color(0xFF1B1C1C))),
                  ),
                  Text('$percent%', style: AppTheme.text.semi.base(const Color(0xFF1B1C1C))),
                ],
              ),
              const H(12),
              AppShimmer(
                child: Container(
                  width: double.maxFinite,
                  height: 8,
                  color: Colors.grey,
                ),
              )
            ],
          )
        ],
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
