import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BeneficiosPlanoProgredirPage extends AdStatefulWidget {
  BeneficiosPlanoProgredirPage({Key? key})
      : super(key: key, name: 'BeneficiosPlanoProgredirPage');

  @override
  State<BeneficiosPlanoProgredirPage> createState() =>
      _BeneficiosPlanoProgredirPageState();
}

class _BeneficiosPlanoProgredirPageState
    extends State<BeneficiosPlanoProgredirPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Famílias de inscritas no Cadastro Único com renda mensal por pessoa de até meio salário mínimo ou com renda familiar mensal total de até três salários mínimos.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'Interessado que preenche os requisitos do Plano deve se inscrever no Portal do Plano Progredir e acessar as ferramentas disponíveis.'),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(AppButton(
        label: 'SITE PROGREDIR',
        onTap: () =>
            execUrl('https://www.gov.br/mds/pt-br/acoes-e-programas/progredir'),
        icon: Symbols.open_in_new,
      )),
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
      children: [
        const Header(
          top: HeaderTop(),
          title: 'Plano Progredir',
          desc:
              'Oferece oportunidades de qualificação profissional, apoio ao empreendedorismo e encaminhamento ao mercado de trabalho.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
