import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class OQueEPage extends AdStatefulWidget {
  OQueEPage({Key? key}) : super(key: key, name: 'OQueEPage');

  @override
  State<OQueEPage> createState() => _OQueEPageState();
}

class _OQueEPageState extends State<OQueEPage> {
  List<CheckListModel> get checkList => [
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label: 'Contas corrente ou poupança encerradas com saldo disponível;',
        ),
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label:
              'Cotas de capital e rateio de sobras líquidas de ex-participantes de cooperativas de crédito;',
        ),
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label: 'Recursos não procurados de grupos de consórcio encerrados;',
        ),
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label: 'Tarifas cobradas indevidamente;',
        ),
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label:
              'Parcelas ou despesas de operações de crédito cobradas indevidamente;',
        ),
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label:
              'Contas de pagamento pré ou pós-paga encerradas com saldo disponível;',
        ),
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label:
              'Contas de registro mantidas por corretoras e distribuidoras encerradas com saldo disponível;',
        ),
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label: 'Outros recursos disponíveis nas instituições para devolução.',
        ),
      ];

  List<CardAccordeonModel> get accordeonList => [
        CardAccordeonModel(
          title: 'Qual o prazo para receber o dinheiro esquecido?',
          desc: const AppDesc(
              'O prazo para receber depende da forma de solicitação. Se for solicitado no sistema com chave PIX o valor será recebido em até 12 dias úteis. Se for solicitado diretamente em contato com a instituição, ou pelo sistema sem PIX, o prazo pode passar de 12 dias úteis.'),
        ),
        CardAccordeonModel(
          title: 'Quais são as formas de receber o dinheiro esquecido?',
          desc: const AppDesc(
              'O dinheiro esquecido pode ser solicitado pelo SRV ou direto com a instituição financeira ou banco, e pode ser enviado ao cliente por PIX, TED ou DOC.'),
        ),
        CardAccordeonModel(
          title: 'Como saber se tenho valores a receber do Banco Central?',
          desc: const AppDesc(
              'Basta entrar no site Valores a Receber, do Banco Central, inserir o número do seu CPF, data de nascimento e conferir se tem direito.'),
        ),
        CardAccordeonModel(
          title: 'Quais as recomendações para evitar golpes no SVR?',
          desc: const AppDesc(
              'O Banco Central recomenda que as pessoas desconfiem de toda informação recebida por WhatsApp e não acessem nenhum link nas mensagens, pois podem roubar senhas, instalar vírus e programas maliciosos. A única fonte oficial de informações sobre o SVR é o site oficial do Banco Central.'),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: AppListView(
        children: [
          const Header.text(
            'O que é o Sistema de Valores a Rceber?',
            'O Sistema de Valores a Receber (SVR) é um serviço do Banco Central que permite ao cidadão consultar se ele, sua empresa ou pessoa falecida tem dinheiro esquecido em algum banco, consórcio ou outra instituição.',
          ),
          const AppTitle('Para que serve?'),
          const H(24),
          const AppDesc(
              'Tanto pelo sistema do Banco Central, como pela instituição ou pelo banco, o serviço é oferecido gratuitamente. Confira a seguir como solicitar o recebimento de seus valores a receber.'),
          const H(24),
          CheckList(checkList),
          const H(20),
          const BannerWidget(),
          const H(20),
          const AppTitle('Perguntas Frequentes'),
          const H(24),
          const AppDesc(
              'Confira perguntas frequentemente feitas por usuários, e tire suas dúvidas.'),
          const H(24),
          CardAppAccordeon(accordeonList),
        ],
      ),
    );
  }
}
