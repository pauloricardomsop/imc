import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BeneficiosCarteiraIdosoPage extends AdStatefulWidget {
  BeneficiosCarteiraIdosoPage({Key? key})
      : super(key: key, name: 'BeneficiosCarteiraIdosoPage');

  @override
  State<BeneficiosCarteiraIdosoPage> createState() =>
      _BeneficiosCarteiraIdosoPageState();
}

class _BeneficiosCarteiraIdosoPageState
    extends State<BeneficiosCarteiraIdosoPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Pessoas idosas com idade de 60 anos ou mais inscritas no Cadastro Único com renda individual mensal de até dois salários mínimos.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'A Carteira do Idoso é gratuita e pode ser emitida pela internet ou presencialmente pelos Centros de Referência de Assistência Social (CRAS). \n\nO documento poderá ser apresentado na forma digital, pela tela do celular, por exemplo, pois ele possui QR CODE para sua validação junto às empresas de transporte.'),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(AppButton(
        label: 'ACESSAR SITE ID JOVEM',
        onTap: () => execUrl('https://carteiraidoso.cidadania.gov.br/'),
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
          title: 'Carteira do Idoso',
          desc:
              'Documento que garante à pessoa idosa acesso a passagens gratuitas ou com desconto de, no mínimo, 50% nos transportes interestaduais rodoviários, ferroviários e aquaviários.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
