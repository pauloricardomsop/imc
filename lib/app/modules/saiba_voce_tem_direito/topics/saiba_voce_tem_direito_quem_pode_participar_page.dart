import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/quiz/ui/quiz_home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SaibaVoceTemDireitoQuemPodeParticiparPage extends AdStatefulWidget {
  SaibaVoceTemDireitoQuemPodeParticiparPage({Key? key})
      : super(key: key, name: 'SaibaVoceTemDireitoQuemPodeParticiparPage');

  @override
  State<SaibaVoceTemDireitoQuemPodeParticiparPage> createState() =>
      _SaibaVoceTemDireitoQuemPodeParticiparPageState();
}

class _SaibaVoceTemDireitoQuemPodeParticiparPageState
    extends State<SaibaVoceTemDireitoQuemPodeParticiparPage> {
  List<CheckListModel> get checklist => [
        CheckListModel(
          label:
              'Podem participar do Programa as famílias em situação de pobreza ou extrema pobreza que tenham, em sua composição, gestantes, nutrizes (mães que amamentam), crianças, adolescentes e jovens entre 0 e 21 anos incompletos.',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label:
              'As famílias extremamente pobres são aquelas que têm renda familiar por pessoa mensal igual ou inferior a R\$ 105,00 (cento e cinco reais). As famílias pobres são aquelas que têm renda familiar por pessoa de R\$ 105,01 (cento e cinco reais e um centavo) e R\$ 210,00 (duzentos e dez reais).',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label:
              'Para se candidatar ao Programa é necessário que a família esteja inscrita no Cadastro Único para Programas Sociais do Governo Federal e tenha atualizado seus dados cadastrais nos últimos 2 anos.',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label:
              'Caso atenda aos requisitos de renda e não esteja inscrito, procure o responsável pelo Programa Bolsa Família na prefeitura de sua cidade para realizar o cadastramento no Cadastro Único.',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label:
              'Mantenha seus dados sempre atualizados, informando à prefeitura qualquer mudança de endereço, telefone de contato e composição da sua família, como: nascimento, morte, casamento, separação e adoção.',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label:
              'O cadastramento é um pré-requisito, mas não implica a entrada imediata da família no Programa. Mensalmente, o Ministério da Cidadania seleciona, de forma automatizada, as famílias que serão incluídas para receber o benefício.',
          icon: Symbols.check_circle,
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
          title: 'Quem pode participar do Novo Bolsa Família?',
          desc:
              'Confira abaixo as regras de enquadramento do Novo Bolsa Família e saiba quem pode participar do programa.',
        ),
        const BannerWidget(),
        const AppTitle('Regras de enquadramento'),
        const H(16),
        CheckList(checklist),
        const H(24),
        const AppTitle('Participe!'),
        const H(24),
        const AppDesc(
            'Preparamos um QUIZ para saber se você tem ou não direito de participar do Novo Bolsa Família. Para participar, toque no botão fixo na parte inferior desta página.')
      ],
    );
  }
}
