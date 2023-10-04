import 'package:ad_manager/ad_manager.dart';

import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class ConsultaCpfAtivoSituacaoCadastraisPage extends AdStatefulWidget {
  ConsultaCpfAtivoSituacaoCadastraisPage({Key? key})
      : super(key: key, name: 'ConsultaCpfAtivoSituacaoCadastraisPage');

  @override
  State<ConsultaCpfAtivoSituacaoCadastraisPage> createState() =>
      _ConsultaCpfAtivoSituacaoCadastraisPage();
}

class _ConsultaCpfAtivoSituacaoCadastraisPage
    extends State<ConsultaCpfAtivoSituacaoCadastraisPage> {
  List<CardAccordeonModel> get listAccrodeon => [
        CardAccordeonModel(
          title: 'CPF com\nSituação Regular',
          desc: const AppDesc('Se seu CPF estiver em Situação Regular, não áh nada com que se preocupar, pois significa que seu cadastro está sem nenhum tipo de pendência!'),
        ),
        CardAccordeonModel(
          title: 'CPF com\nSituação Suspensa',
          desc: const AppDesc('Se seu cadastro estiver incompleto, ou seja com alguma pendência de informações seu CPF será marcado como suspenso. \n\nNesse caso você deve procurar ajuda na Receita Federal.'),
        ),
        CardAccordeonModel(
          title: 'Situação Pendente de\nRegularização',
          desc: const AppDesc('Se você tiver esquecido de fazer alguma declaração no imposto de renda nos últimos 5 anos. \n\nPara solucionar isto, você deve procurar ajuda na Receita Federal e regularizar sua situação.'),
        ),
        CardAccordeonModel(
            title: 'Situações que o cadastro está\nInativo',
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppDesc('Algumas situações podem mostrar que seu cadastro está inativo, confira:'),
                  const H(8),
                  Text('Cancelado', style: const TextStyle(color: AppColors.onSurface).titleMedium),
                  const H(8),
                  const AppDesc('O CPF pode ser cancelado por decisão judicial, administrativa ou quando um contribuinte possui mais de um CPF.'),
                  const H(8),
                  Text('Titular falecido', style: const TextStyle(color: AppColors.onSurface).titleMedium),
                  const H(8),
                  const AppDesc('Se o contribuinte vier a óbito, o cadastro será inativado'),
                  const H(8),
                  Text('Nulo', style: const TextStyle(color: AppColors.onSurface).titleMedium),
                  const H(8),
                  const AppDesc('Em caso de constatação de fraude no cadastro do CPF, este cadastro será inativado e dado como Nulo.'),
                ],
              )
            ]),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        child: body(context));
  }

  Widget body(_) {
    return AppListView(
      children: [
        const Header.light(
          child: Column(children: [
          HeaderTitle('Situações cadastrais podem ser apresentadas.', color: AppColors.onSurface),
          H(12),
          HeaderDesc(
              'Preparamos uma lista das possíveis situações de cadastro do seu CPF, entenda o que significa cada uma delas.',
              color: AppColors.onSurface),
        ])),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(listAccrodeon),
        const H(16),
        const AppDesc('Existem situações em que o cidadão pode estar com o CPF regular em relação à situação cadastral, mas está com alguma pendência na Receita Federal. Para todos os fins, busque ajuda para regularizar sua situação.'),
        const H(16),
        const SelectYesNo()
      ],
    );
  }
}
