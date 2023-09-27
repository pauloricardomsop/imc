import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/ui/quiz_home_page.dart';
import 'package:svr/app/modules/saiba_voce_tem_direito/topics/saiba_voce_tem_direito_como_cadastrar_page.dart';
import 'package:svr/app/modules/saiba_voce_tem_direito/topics/saiba_voce_tem_direito_quem_pode_participar_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SaibaVoceTemDireitoHomePage extends AdStatefulWidget {
  SaibaVoceTemDireitoHomePage({Key? key})
      : super(key: key, name: 'SaibaVoceTemDireitoHomePage');

  @override
  State<SaibaVoceTemDireitoHomePage> createState() =>
      _SaibaVoceTemDireitoHomePageState();
}

class _SaibaVoceTemDireitoHomePageState
    extends State<SaibaVoceTemDireitoHomePage> {
  List<CardFeature> get listGrid => [
        CardFeature.full(
          label: 'Quem tem direito de \nparticipar do programa?',
          prefix: Symbols.counter_1,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () =>
                  push(context, SaibaVoceTemDireitoQuemPodeParticiparPage())),
        ),
        CardFeature.full(
          label: 'Como se cadastrar no \nNovo Bolsa Família?',
          prefix: Symbols.counter_2,
          onTap: () => AdManager.showIntersticial(context,
              onDispose: () =>
                  push(context, SaibaVoceTemDireitoComoCadastrarPage())),
        ),
      ];

  List<CardAccordeonModel> get listgCardGrid => [
        CardAccordeonModel(
          title: 'É possível se cadastrar no Bolsa Família pela Internet?',
          desc: const AppDesc(
              'O Responsável Familiar pode fazer o pré-cadastro da família por meio do celular e tem até 120 dias para ir à unidade do CRAS fazer a entrega dos documentos e passar por uma entrevista social.'),
        ),
        CardAccordeonModel(
          title: 'O que é necessário para se inscrever no Bolsa Família?',
          desc: const AppDesc(
              'É preciso que todos os membros da família estejam inscritos no CadÚnico e mantenham as informações atualizadas a cada dois anos. \n\nO titular deve comparecer ao CRAS levando seu CPF, o Título de eleitor e comprovante de residência e ainda levar uma cópia de cada documento para cada membro da família.'),
        ),
        CardAccordeonModel(
          title: 'Como saber se eu tenho direito ao Novo Bolsa Família?',
          desc: const AppDesc(
              'Além de estarem enquadradas na situação de pobreza e extrema pobreza, é preciso que as famílias tenham gestantes, mães que amamentam ou pessoas de 0 a 21 anos incompletos (crianças, adolescentes e jovens adultos).'),
        ),
        CardAccordeonModel(
          title: 'O que é o Cadastro Único?',
          desc: const AppDesc(
              'O Cadastro Único do Governo Federal, mais conhecido como CadÚnico, é o principal registro das famílias brasileiras de baixa renda e é muito importante para quem deseja receber benefícios e participar dos programas sociais disponibilizados.'),
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
        Header(
          top: const HeaderTop(),
          title: 'Saiba se você \ntem direito de \nparticipar.',
          desc:
              'Preparamos um QUIZ para que você saiba se tem ou não o direito de participar do Novo Bolsa Família. Clique no botão abaixo para participar.',
          buttons: [
            AppButton(
              label: 'QUEM TEM DIREITO',
              onTap: () => AdManager.showIntersticial(context,
                  onDispose: () => push(context, QuizHomePage())),
              icon: Symbols.trending_flat,
            ),
          ],
        ),
        const AppTitle('Veja mais opções.'),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardFeatures.full(listGrid),
        const H(16),
        const AppTitle('Perguntas Frequentes'),
        const H(16),
        CardAppAccordeon(listgCardGrid)
      ],
    );
  }
}
