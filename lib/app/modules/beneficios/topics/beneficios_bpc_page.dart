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
              'Pessoas idosas com idade de 65 anos ou mais e com renda familiar mensal por pessoa inferior a ¼ do salário mínimo inscritas no Cadastro Único OU Pessoas com deficiência de qualquer idade e com renda familiar mensal por pessoa inferior a ¼ do salário mínimo inscritas no Cadastro Único.'),
        ),
        CardAccordeonModel(
          title: 'Como Solicitar?',
          desc: const AppDesc(
              'O requerimento do BPC é realizado nas Agências da Previdência Social (APS) ou pelos canais de atendimento do INSS: pelo telefone 135 (ligação gratuita de telefone fixo) ou pelo site ou aplicativo de celular “Meu INSS”. \n\nAntes de apresentar o requerimento ao INSS, o cidadão deverá estar inscrito no Cadastro Único e com o cadastro atualizado. \n\nÉ importante destacar que, para receber o BPC, caso sejam atendidos os requisitos do programa, não é necessário pagar intermediários.'),
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
          title: 'BPC - Benefício de Prestação Continuada',
          desc:
              'É um benefício individual que garante a transferência de um salário mínimo à pessoa idosa (a partir de 65 anos) e à pessoa com deficiência de qualquer idade, com renda familiar inferior a 1/4 (um quarto) do salário mínimo por pessoa.',
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        CardAppAccordeon(list)
      ],
    );
  }
}
