import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:flutter/material.dart';

int count = 0;

class RedirectPage extends JourneyStatefulWidget {
  final String title;
  final String url;
  final String? titleInfooter;
  final Widget? child;
  const RedirectPage(
    this.title,
    this.url, {
    Key? key,
    this.titleInfooter,
    this.child,
  }) : super(key: key, name: 'RedirectBanner');

  @override
  State<RedirectPage> createState() => RedirectBannerState();
}

class RedirectBannerState extends State<RedirectPage> {
  String get name => 'RedirectBanner${widget.title}$count';
  @override
  void initState() {
    count++;
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(name),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      active: AdController.adConfig.banner.active,
      behavior: [name],
      bottom: infooter(),
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
      padding: EdgeInsets.zero,
      children: [
        const BackHeader(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const H(16),
              AppBannerAd(AdBannerStorage.get(name)),
              const H(16),
              HeaderHero(
                  title: widget.title,
                  desc: 'Clique no botão abaixo para continuar.')
            ],
          ),
        ),
      ],
    );
  }

  Widget infooter() {
    return InFooterCta(
      onTap: () => execUrl(widget.url),
      label: widget.titleInfooter ?? '',
      icon: Icons.open_in_new_outlined,
      invert: true,
      subtitle: widget.child,
    );
  }
}
