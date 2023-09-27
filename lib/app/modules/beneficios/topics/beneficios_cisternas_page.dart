import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class BeneficiosCisternasPage extends AdStatefulWidget {
  BeneficiosCisternasPage({Key? key})
      : super(key: key, name: 'BeneficiosCisternasPage');

  @override
  State<BeneficiosCisternasPage> createState() =>
      _BeneficiosCisternasPageState();
}

class _BeneficiosCisternasPageState extends State<BeneficiosCisternasPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Famílias inscritas no Cadastro Único com renda familiar por pessoa de até meio salário mínimo e residentes no meio rural, em locais sem acesso à água potável, conforme definido pelo programa.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'As famílias que atendem aos requisitos do programa e residem nos municípios atendidos pelo programa são selecionadas para receber o benefício.'),
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
          title: 'Programa Cisternas',
          desc:
              'Construção de cisternas e outras tecnologias de captação e armazenamento de água com o objetivo de promover o acesso à água para consumo humano e para a produção de alimentos às famílias de baixa renda residentes em zonas rurais atingidas por secas ou falta regular de água.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
