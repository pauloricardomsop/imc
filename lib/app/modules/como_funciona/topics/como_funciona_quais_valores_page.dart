import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/ui/quiz_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ComoFuncionaQuaisSaoValoresPage extends AdStatefulWidget {
  ComoFuncionaQuaisSaoValoresPage({Key? key})
      : super(key: key, name: 'ComoFuncionaQuaisSaoValoresPage');

  @override
  State<ComoFuncionaQuaisSaoValoresPage> createState() =>
      _ComoFuncionaQuaisSaoValoresPageState();
}

class _ComoFuncionaQuaisSaoValoresPageState
    extends State<ComoFuncionaQuaisSaoValoresPage> {
  List<CardAccordeonModel> get listgCardGrid => [
        CardAccordeonModel(
          title: 'Benefício de Renda \nde Cidadania.',
          desc: const AppDesc(
              'Este benefício é pago para todos os integrantes da família, no valor de R\$ 142 por pessoa.'),
        ),
        CardAccordeonModel(
          title: 'Benefício de Renda \nComplementar',
          desc: const AppDesc(
              'Este benefício é pago para famílias do programa Novo Bolsa Família, caso o Benefício de Renda de Cidadania não seja suficiente para alcançar o valor mínimo de R\$ 600 por família. \n\nO complemento é calculado para garantir que nenhuma família receba menos de que o valor de R\$ 600.'),
        ),
        CardAccordeonModel(
          title: 'Benefício Primeira \nInfância',
          desc: const AppDesc(
              'O Benefício Primeira Infância é pago para famílias com crianças com idade entre 0 e 6 anos. \n\nCada criança com idade entre 0 e 6 anos recebe o valor de R\$ 150 que são somados aos R\$ 600 do Bolsa Família.'),
        ),
        CardAccordeonModel(
          title: 'Benefício Variável \nFamiliar',
          desc: const AppDesc(
              'Este benefício é pago para famílias que tenham em sua composição: \n\n- Mulheres gestantes; \n- Crianças com idade entre 7 e 12 anos; \n- Adolescentes com idade entre 12 e 18 anos incompletos; \n\nO valor deste benefício é de R\$ 50 por cada pessoa que esteja dentro das condições.'),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bottom: Footer(
          AppButton(
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, QuizHomePage())),
            label: 'VEJA SE VOCÊ TEM DIREITO',
            icon: Symbols.trending_flat,
          ),
        ),
        child: body(context));
  }

  Widget body(_) {
    return AppListView(
      children: [
        const Header(
          top: HeaderTop(),
          title: 'Quais são os valores pagos aos beneficiários?',
          desc:
              'Veja abaixo a lista de benefícios que compõem o Novo Bolsa Família e saiba quanto cada benefício paga.',
        ),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(listgCardGrid),
        const H(24),
        const AppTitle(
            'Dá para receber todos os benefícios propostos no Novo Bolsa Família?'),
        const H(24),
        const AppDesc(
            'O Ministério da Cidadania informou que a família pode receber todos os benefícios propostos pelo programa Bolsa Família, desde que preencha os pré-requisitos para receber. \n\nÉ importante buscar um CRAS mais próximo de você para fazer parte de cada benefício do Bolsa Família, e também para saber se tem direito e quais benefícios tem direito receber.')
      ],
    );
  }
}
