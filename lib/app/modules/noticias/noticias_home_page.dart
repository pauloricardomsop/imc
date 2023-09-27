import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/noticias/noticias_controller.dart';
import 'package:svr/app/modules/noticias/noticias_model.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:material_symbols_icons/symbols.dart';

class NoticiasHomePage extends AdStatefulWidget {
  NoticiasHomePage({Key? key}) : super(key: key, name: 'NoticiasHomePage');

  @override
  State<NoticiasHomePage> createState() => _NoticiasHomePageState();
}

class _NoticiasHomePageState extends State<NoticiasHomePage> {
  final NoticiasController _noticiasController = NoticiasController();
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: bodyStacked(context),
    );
  }

  Widget bodyStacked(BuildContext _) {
    return AppListView(
      children: [
        const Header(
          top: HeaderTop(),
          title: 'Últimas notícias do Novo Bolsa Família',
          desc:
              'Fique atualizado sobre as notícias mais recentes do programa Bolsa Família.',
        ),
        const H(16),
        const AppTitle('Últimas notícias.'),
        const H(16),
        const BannerWidget(),
        const H(16),
        StreamOut<List<Noticia>>(
          loading: const AppShimmer(
            child: SizedBox(
              height: 40,
              width: 100,
            ),
          ),
          stream: _noticiasController.newsStream.listen,
          child: (_, news) {
            news.sort((a, b) => a.title.compareTo(b.title));
            return Column(
              children: news
                  .map((e) => InkWell(
                        onTap: () async => execUrl(e.url),
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.surfaceContainerHigh,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    e.title,
                                    style: const TextStyle().titleMedium,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Symbols.open_in_new,
                                color: AppColors.primary,
                                size: 32,
                                weight: 600,
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
