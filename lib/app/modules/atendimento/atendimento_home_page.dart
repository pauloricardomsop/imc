import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/atendimento/topics/atendimento_bolsa_familia_page.dart';
import 'package:svr/app/modules/atendimento/topics/atendimento_caixa_cidadao_page.dart';
import 'package:svr/app/modules/atendimento/topics/atendimento_presencial_page.dart';
import 'package:svr/app/modules/atendimento/topics/atendimento_whatsapp_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class AtendimentoHomePage extends AdStatefulWidget {
  AtendimentoHomePage({Key? key})
      : super(key: key, name: 'AtendimentoHomePage');

  @override
  State<AtendimentoHomePage> createState() => _AtendimentoHomePageState();
}

class _AtendimentoHomePageState extends State<AtendimentoHomePage> {
  List<CardFeature> get cardItens => [
        CardFeature(
            label: 'Atendimento\nBolsa Família',
            prefix: Symbols.attach_money,
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, AtendimentoBolsaFamiliaPage()))),
        CardFeature(
            label: 'Atendimento\nCAIXA Cidadão',
            prefix: Symbols.add_card,
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, AtendimentoCaixaCidadaoPage()))),
        CardFeature(
            label: 'Atendimento\nWhatsapp CAIXA',
            prefix: Symbols.add_card,
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, AtendimentoWhatsappPage()))),
        CardFeature(
          label: 'Encontre um\nCRAS',
          prefix: Symbols.pin_drop,
          onTap: () => AdManager.showIntersticial(
            context,
            onDispose: () => push(context, AtendimentoPresencialPage()),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(child: body(context));
  }

  Widget body(_) {
    return AppListView(
      children: [
        const Header(
          backgroundColor: AppColors.primaryShadow,
          top: HeaderTop(backgroundColor: AppColors.primaryShadow),
          title: 'Encontre \nAtendimento',
          desc:
              'Disponibilizamos aqui, alguns canais de atendimento presenciais e virtuais.',
        ),
        const AppTitle('Opções de atendimento'),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardFeatures(cardItens)
      ],
    );
  }
}
