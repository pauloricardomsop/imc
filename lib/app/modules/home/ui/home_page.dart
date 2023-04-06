import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/card_base.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/home/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/components/label_double_column.dart';

class HomePage extends JourneyStatefulWidget {
  const HomePage({Key? key}) : super(key: key, name: 'HomePage');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
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
        behavior: AdBannerStorage.get(widget.name),
        body: body(context),
      ),
    );
  }

  Widget body(_) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppBannerAd(AdBannerStorage.get(widget.name)),
        const H(32),
        const LabelDoubleColumn('Consulte seus', 'Benefícios'),
        const H(8),
        ...HomeItem.values
            .map((e) => CardBase(
                  onTap: () => push(context, e.page),
                  title: 'Benefícios',
                  subtitle: e.label,
                  image: Container(
                    margin: const EdgeInsets.all(8),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[800]!,
                      image: DecorationImage(image: CachedNetworkImageProvider(e.url), fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(color: Colors.grey[300]!, blurRadius: 2, spreadRadius: 1.5)
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ))
            .toList()
      ],
    );
  }
}
