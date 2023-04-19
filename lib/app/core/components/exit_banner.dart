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
  final String pageId;
  final String title;
  final String? url;
  final String buttonLabel;
  final String buttonSubLabel;
  final String buttonSubLabelBold;
  final void Function()? onClick;

  const ExitBanner(
    this.pageId, {
    Key? key,
    required this.title,
    required this.buttonLabel,
    required this.buttonSubLabel,
    required this.buttonSubLabelBold,
    this.url,
    this.onClick,
  }) : super(key: key, name: 'ExitBanner');

  @override
  State<ExitBanner> createState() => _ExitBannerState();
}

class _ExitBannerState extends State<ExitBanner> {
  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.pageId + widget.name + widget.title),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      active: AdController.adConfig.banner.active,
      behavior: [widget.pageId + widget.name + widget.title],
      bottom: _inFooterCta(),
      child: body(context),
    );
  }

  Widget body(_) {
    return Stack(
      children: [
        ListView(
          children: [
            const BackHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBannerAd(AdBannerStorage.get(widget.pageId + widget.name + widget.title)),
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
          ],
        ),
      ],
    );
  }

  InFooterCta _inFooterCta() {
    return InFooterCta(
        onTap: () {
          if (widget.url != null) {
            execUrl(widget.url!);
          }
          if (widget.onClick != null) {
            widget.onClick!.call();
          }
        },
        icon: Icons.open_in_new,
        label: widget.buttonLabel,
        invert: true,
        subtitle: widget.buttonSubLabel.isNotEmpty || widget.buttonSubLabelBold.isNotEmpty
            ? RichText(
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
              )
            : null,
      );
  }
}
