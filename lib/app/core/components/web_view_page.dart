import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:url_launcher/url_launcher_string.dart';

bool isBottomOpen = false;

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage(this.url, {super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    isBottomOpen = false;
    Future.delayed(const Duration(seconds: 5)).then((value) => showConfirmBottom());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: true,
        bottom: true,
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  height: 80,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => showConfirmBottom(),
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              color: const Color(0xFF1C44F9),
                              borderRadius: BorderRadius.circular(6)),
                          child: const Icon(
                            Icons.close,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      const W(8),
                      Expanded(
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: const Color(0xFFDDE0FF),
                              borderRadius: BorderRadius.circular(6)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Site seguro:',
                                style: AppTheme.text.normal.xs(const Color(0xFF474747)),
                              ),
                              const H(2),
                              Expanded(
                                child: Text(
                                  widget.url,
                                  style: AppTheme.text.extra.xs(const Color(0xFF1B1C1C)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const W(8),
                      InkWell(
                        onTap: () {
                          pop(context);
                          push(context, WebViewPage(widget.url));
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: const Color(0xFFDDE0FF),
                              borderRadius: BorderRadius.circular(6)),
                          child: const Icon(
                            Icons.replay_outlined,
                            color: Color(0xFF000C61),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showConfirmBottom() async {
    if (!isBottomOpen) {
      isBottomOpen = true;
      bool query = await showModalBottomSheet(
          context: context,
          builder: (_) => const WebViewConfirmBottom(),
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          )));
      if (query) {
        bool? rate = await showModalBottomSheet(
            context: context,
            builder: (_) => const WebViewRateBottom(),
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            )));
        if (rate != null) {
          await launchUrlString('https://play.google.com/store/apps/details?id=com.ldcapps.svr');
          await Future.delayed(const Duration(seconds: 3));
          Navigator.pop(context);
        }
      } else {
        Navigator.pop(context);
      }
      isBottomOpen = false;
    }
  }
}

class WebViewConfirmBottom extends StatelessWidget {
  const WebViewConfirmBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 33,
              height: 7,
              decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(100)),
            ),
          ),
          const H(16),
          Text(
            'Conseguiu realizar sua consulta?',
            textAlign: TextAlign.center,
            style: AppTheme.text.extra.xl3(
              const Color(0xFF1B1C1C),
            ),
          ),
          const H(16),
          ButtonIcon(
            onTap: () => Navigator.pop(context, true),
            label: 'SIM',
          ),
          const H(8),
          ButtonIcon(
            onTap: () => Navigator.pop(context, false),
            label: 'NÃO',
            backgroundColor: const Color(0xFFEBDDFF),
            textColor: const Color(0xFF23005C),
          ),
        ],
      ),
    );
  }
}

class WebViewRateBottom extends StatelessWidget {
  const WebViewRateBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 33,
              height: 7,
              decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(100)),
            ),
          ),
          const H(16),
          Row(
            children: [null, null, null, null, null]
                .map((e) => const Expanded(
                      child: Icon(
                        Icons.star,
                        color: Color(0xFFF9A825),
                        size: 58,
                      ),
                    ))
                .toList(),
          ),
          const H(16),
          Text(
            'Avaliar nosso app.',
            textAlign: TextAlign.center,
            style: AppTheme.text.extra.xl3(
              const Color(0xFF1B1C1C),
            ),
          ),
          const H(8),
          Text(
            'Sua avaliação é muito importante, deixe sua opinião na PlayStore.',
            textAlign: TextAlign.center,
            style: AppTheme.text.extra
                .xl3(
                  const Color(0xFF1B1C1C),
                )
                .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const H(16),
          ButtonIcon(
            onTap: () => Navigator.pop(context, true),
            label: 'AVALIAR',
          ),
        ],
      ),
    );
  }
}
