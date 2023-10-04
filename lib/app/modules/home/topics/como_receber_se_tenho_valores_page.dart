import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ComoReceberSeTenhoValoresPage extends AdStatefulWidget {
  ComoReceberSeTenhoValoresPage({Key? key})
      : super(key: key, name: 'ComoReceberSeTenhoValoresPage');

  @override
  State<ComoReceberSeTenhoValoresPage> createState() =>
      _ComoReceberSeTenhoValoresPageState();
}

class _ComoReceberSeTenhoValoresPageState
    extends State<ComoReceberSeTenhoValoresPage> {
  List<CheckListModel> get checkList => [
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label:
              'Acesse o site e clique no botão ”Consulte se tem valores a receber”;',
        ),
        CheckListModel(
            icon: Symbols.check_circle,
            color: AppColors.success,
            label: const Column(
              children: [
                AppDesc(
                    'Em seguida, será necessário informar os dados solicitados:'),
                H(12),
                PointsCheckList(
                    'CPF e data de nascimento, caso se trate de pessoa física.'),
                PointsCheckList(
                    'CNPJ e a data de abertura da empresa, em caso de pessoa jurídica;'),
              ],
            )),
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label:
              'Se tiver algum valor a receber, selecione a opção “Acessar o SVR”;',
        ),
        CheckListModel(
            icon: Symbols.check_circle,
            color: AppColors.success,
            label: const Column(
              children: [
                AppDesc(
                    'Depois disso, é necessário fazer o login com a conta gov.br.'),
                H(12),
                PointsCheckList(
                    'Para valores de pessoa física, é preciso que a conta gov.br seja de nível prata ou ouro.'),
                PointsCheckList(
                    'Para valores de pessoa jurídica, precisa ter conta gov.br com qualquer tipo de vínculo ao CNPJ, exceto de colaborador;'),
              ],
            )),
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label:
              'Após realizar o login com sua conta gov.br, acesse a opção “Meus Valores a Receber”;',
        ),
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label:
              'Por fim, caso tenha valores a receber, para solicitar o valor é preciso seguir as orientações indicadas pela plataforma.',
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
            'Como saber se tenho valores a receber?',
            'Para saber se tem valores a receber, é preciso consultar o Serviço Valores a Receber (SVR), que é uma plataforma online criada para auxiliar o interessado a verificar se tem valores esquecidos para receber.',
          ),
          const AppTitle('Como fazer?'),
          const H(24),
          const AppDesc(
              'Para realizar essa consulta, basta seguir o passo a passo:'),
          CheckList(checkList),
          const H(16),
          const BannerWidget(),
          const H(16),
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

class PointsCheckList extends StatelessWidget {
  final String label;
  const PointsCheckList(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 16),
            child: Icon(Symbols.circle,
                color: AppColors.onSurface, fill: 1, size: 7),
          ),
          const W(8),
          Expanded(
              child: Text(label,
                  style:
                      const TextStyle(color: AppColors.onSurface).bodyLarge)),
        ],
      ),
    );
  }
}

class WarningCard extends StatelessWidget {
  final String label;
  const WarningCard(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: AppColors.onWarningContainer,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.onErrorShadow),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Atenção: ',
                        style: const TextStyle(color: AppColors.warningShadow)
                            .titleMedium,
                      ),
                      TextSpan(
                        text: label,
                        style: const TextStyle(color: AppColors.warningShadow)
                            .bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
