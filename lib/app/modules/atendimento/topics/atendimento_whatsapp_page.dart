import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class AtendimentoWhatsappPage extends AdStatefulWidget {
  AtendimentoWhatsappPage({Key? key})
      : super(key: key, name: 'AtendimentoWhatsappPage');

  @override
  State<AtendimentoWhatsappPage> createState() =>
      _AtendimentoWhatsappPageState();
}

class _AtendimentoWhatsappPageState extends State<AtendimentoWhatsappPage> {
  List<CardFeature> get listCards => [
        CardFeature.full(
          label: 'Whatsapp CAIXA \n0800 104 0104',
          prefix: Symbols.call,
          sufix: Symbols.open_in_new,
          onTap: () => execUrl('https://wa.me/558001040104'),
        )
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
          title: 'Atendimento por Whatsapp',
          desc: 'Tire suas dúvidas de forma descomplicada pelo Whatsapp.',
        ),
        CardFeatures.full(listCards),
        const H(16),
        const BannerWidget()
      ],
    );
  }
}
