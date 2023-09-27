import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosAtividadesRuraisPage extends AdStatefulWidget {
  BeneficiosAtividadesRuraisPage({Key? key})
      : super(key: key, name: 'BeneficiosAtividadesRuraisPage');

  @override
  State<BeneficiosAtividadesRuraisPage> createState() =>
      _BeneficiosAtividadesRuraisPageState();
}

class _BeneficiosAtividadesRuraisPageState
    extends State<BeneficiosAtividadesRuraisPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Famílias inscritas no Cadastro Único residentes no meio rural, nas localidades atendidas pelo programa. com renda familiar por pessoa de até R\$ 105,00 mensais OU famílias com renda por pessoa entre R\$ 105,01 e R\$ 210,00 mensais.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'O programa é ofertado por entidades públicas (EMATER) ou privadas prestadoras de assistência técnica e extensão rural em localidades definidas pelo Programa. \n\nPara saber se seu município participa do programa, contate a Empresa de Assistência Técnica e Extensão Rural (EMATER) do seu estado.'),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
      children: [
        const Header(
          top: HeaderTop(),
          title: 'Programa de Fomento às Atividades Produtivas Rurais',
          desc:
              'Oferece transferência de recursos financeiros e serviços de acompanhamento social e produtivo para estruturar atividades produtivas rurais, com o objetivo de promover a inclusão produtiva e a segurança alimentar e nutricional.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
