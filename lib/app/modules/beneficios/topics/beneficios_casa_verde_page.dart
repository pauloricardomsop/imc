import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosBPCPage extends AdStatefulWidget {
  BeneficiosBPCPage({Key? key}) : super(key: key, name: 'BeneficiosBPCPage');

  @override
  State<BeneficiosBPCPage> createState() => _BeneficiosBPCPageState();
}

class _BeneficiosBPCPageState extends State<BeneficiosBPCPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Famílias inscritas no Cadastro Único com renda familiar de até R\$ 2.000,00 são o público do Grupo 1 do Programa Casa Verde e Amarela. \n\nPara se beneficiarem do programa, as famílias também não podem possuir imóvel próprio.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'A família deve se inscrever no Cadastro Habitacional na sua cidade. Esse cadastro é feitos pelas Secretarias de Habitação municipais e, em alguns casos, nas estaduais. \n\nPara mais informações, procure a Secretaria de Habitação de sua cidade.'),
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
          title: 'Programa Casa Verde e Amarela',
          desc:
              'Oferece condições facilitadas para atender as necessidades habitacionais da população.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
