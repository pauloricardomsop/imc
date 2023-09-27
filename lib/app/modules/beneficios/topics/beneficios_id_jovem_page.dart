import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BeneficiosIdJovemPage extends AdStatefulWidget {
  BeneficiosIdJovemPage({Key? key})
      : super(key: key, name: 'BeneficiosIdJovemPage');

  @override
  State<BeneficiosIdJovemPage> createState() => _BeneficiosIdJovemPageState();
}

class _BeneficiosIdJovemPageState extends State<BeneficiosIdJovemPage> {
  List<CardAccordeonModel> get list => [
        CardAccordeonModel(
          title: 'A quem se destina?',
          desc: const AppDesc(
              'Indivíduos com idade entre 15 e 29 anos de idade inscritos no Cadastro Único com renda familiar mensal total de até dois salários mínimos. \n\nNão é preciso ser estudante para ter acesso ao benefício.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'A ID Jovem pode ser emitido pela internet no sítio site da Secretaria Nacional de Juventude ou pelos aplicativos do ID Jovem para celular. \n\nNão é necessário imprimir a carteirinha, podendo ser utilizado de forma digital.'),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: Footer(AppButton(
        label: 'ACESSAR SITE ID JOVEM',
        onTap: () =>
            execUrl('https://idjovem.juventude.gov.br/emitir-id-jovem'),
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
          title: 'Identidade Jovem (iD Jovem)',
          desc:
              'Documento que possibilita aos jovens de baixa renda acesso aos benefícios de meia-entrada em eventos artístico-culturais e esportivos e também a vagas gratuitas ou com desconto no sistema de transporte coletivo interestadual.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
