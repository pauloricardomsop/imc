import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosCriancaFelizPage extends AdStatefulWidget {
  BeneficiosCriancaFelizPage({Key? key})
      : super(key: key, name: 'BeneficiosCriancaFelizPage');

  @override
  State<BeneficiosCriancaFelizPage> createState() =>
      _BeneficiosCriancaFelizPageState();
}

class _BeneficiosCriancaFelizPageState
    extends State<BeneficiosCriancaFelizPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Famílias inscritas no Cadastro Único: beneficiárias do Programa Auxílio Brasil com gestantes ou crianças de até três anos; beneficiárias do BPC com crianças de até seis anos; crianças de até seis anos afastadas do convívio familiar em razão da aplicação de medida de proteção.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'A família ou pessoa interessada em participar deve procurar o Centro de Referência da Assistência Social (CRAS) do seu município.'),
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
          title: 'Programa Criança Feliz',
          desc:
              'Visitas domiciliares para orientações e acompanhamento das famílias com o objetivo de promover o desenvolvimento infantil integral.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
