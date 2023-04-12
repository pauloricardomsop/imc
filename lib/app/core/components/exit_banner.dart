import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class ExitBanner extends JourneyStatefulWidget {
  final String title;
  final String url;
  final String buttonLabel;
  final String buttonSubLabel;
  final String buttonSubLabelBold;

  const ExitBanner({
    Key? key,
    required this.title,
    required this.url,
    required this.buttonLabel,
    required this.buttonSubLabel,
    required this.buttonSubLabelBold,
  }) : super(key: key, name: 'ExitBanner');

  @override
  State<ExitBanner> createState() => _ExitBannerState();
}

class _ExitBannerState extends State<ExitBanner> {
  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: [widget.name],
        body: body(context),
      ),
    );
  }

  Widget body(_) {
    return ListView(
      children: [
        const BackHeader(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(32),
              Text(
                widget.title,
                style: AppTheme.text.extra.xl3(const Color(0xFF1B1C1C)),
              ),
              const H(8),
              Text(
                'Clique no botão abaixo para continuar.',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
            ],
          ),
        ),
        InFooterCta(
          onTap: () => execUrl(widget.url),
          icon: Icons.open_in_new,
          label: widget.buttonLabel,
          invert: true,
          subtitle: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: widget.buttonSubLabel,
                  style: AppTheme.text.normal.sm(const Color(0xFF474747))),
              TextSpan(
                  text: widget.buttonSubLabelBold,
                  style: AppTheme.text.normal
                      .sm(const Color(0xFF474747))
                      .copyWith(fontWeight: FontWeight.bold)),
            ]),
          ),
        )
      ],
    );
  }
}
