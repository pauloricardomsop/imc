import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/utils/global_resource.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class AtendimentoCaixaCidadaoPage extends AdStatefulWidget {
  AtendimentoCaixaCidadaoPage({Key? key})
      : super(key: key, name: 'AtendimentoCaixaCidadaoPage');

  @override
  State<AtendimentoCaixaCidadaoPage> createState() =>
      _AtendimentoCaixaCidadaoPageState();
}

class _AtendimentoCaixaCidadaoPageState
    extends State<AtendimentoCaixaCidadaoPage> {
  List<CheckListModel> get checklist => [
        CheckListModel(
          label: 'PIS',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Benefícios Sociais',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'FGTS',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label: 'Cartão Social',
          icon: Symbols.check_circle,
        ),
      ];

  List<CardFeature> get listCards => [
        CardFeature.full(
          label: 'Atendimento \n0800 726 0207',
          prefix: Symbols.call,
          sufix: Symbols.open_in_new,
          onTap: () => execUrl('tel:08007260207'),
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
          title: 'Atendimento \nCAIXA Cidadão',
          desc:
              'Um canal para tirar diversas dúvidas sobre benefícios sociais e muito mais.',
        ),
        CardFeatures.full(listCards),
        const H(16),
        const BannerWidget(),
        const H(16),
        const AppDesc(
            'O atendimento eletrônico está disponível 24 horas por dia, 7 dias por semana. Já o atendimento humano ocorre de segunda a sexta-feira, das 8h às 21h, e aos sábados, das 10h às 16h. \n\nO atendimento é exclusivo para:'),
        const H(16),
        CheckList(checklist)
      ],
    );
  }
}
