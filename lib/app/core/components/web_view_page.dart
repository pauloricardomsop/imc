import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage(this.url, {super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
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
                        onTap: () => pop(context),
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
}
