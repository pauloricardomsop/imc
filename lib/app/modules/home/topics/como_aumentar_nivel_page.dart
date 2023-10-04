import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ComoAumentarNivelPage extends AdStatefulWidget {
  ComoAumentarNivelPage({Key? key})
      : super(key: key, name: 'ComoAumentarNivelPage');

  @override
  State<ComoAumentarNivelPage> createState() =>
      _ComoAumentarNivelPageState();
}

class _ComoAumentarNivelPageState extends State<ComoAumentarNivelPage> {
  List<CheckListModel> get checkList => [
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Acesse o site sso.acesso.gov.br ou baixe o app gov.br',
    ),
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Validação facial pelo aplicativo gov.br para conferência da sua foto nas bases da Carteira de Habilitação (CNH)',
    ),
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Validação dos dados pessoais via internet banking de um banco credenciado',
    ),
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Validação dos dados com usuário e senha do SIGEPE, se o cidadão for servidor público federal',
    ),
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Validação facial pelo aplicativo gov.br para conferência da sua foto nas bases da Justiça Eleitoral',
    ),
    CheckListModel(
      icon: Symbols.check_circle,
      color: AppColors.success,
      label: 'Validação dos seus dados com Certificado Digital compatível com ICP-Brasil',
    ),
  ];

  List<CardAccordeonModel> get accordeonList => [
    CardAccordeonModel(
      title: 'Qual o prazo para receber o dinheiro esquecido?',
      desc: const AppDesc('O prazo para receber depende da forma de solicitação. Se for solicitado no sistema com chave PIX o valor será recebido em até 12 dias úteis. Se for solicitado diretamente em contato com a instituição, ou pelo sistema sem PIX, o prazo pode passar de 12 dias úteis.'),
    ),
    CardAccordeonModel(
      title: 'Quais são as formas de receber o dinheiro esquecido?',
      desc: const AppDesc('O dinheiro esquecido pode ser solicitado pelo SRV ou direto com a instituição financeira ou banco, e pode ser enviado ao cliente por PIX, TED ou DOC.'),
    ),
    CardAccordeonModel(
      title: 'Como saber se tenho valores a receber do Banco Central?',
      desc: const AppDesc('Basta entrar no site Valores a Receber, do Banco Central, inserir o número do seu CPF, data de nascimento e conferir se tem direito.'),
    ),
    CardAccordeonModel(
      title: 'Quais as recomendações para evitar golpes no SVR?',
      desc: const AppDesc('O Banco Central recomenda que as pessoas desconfiem de toda informação recebida por WhatsApp e não acessem nenhum link nas mensagens, pois podem roubar senhas, instalar vírus e programas maliciosos. A única fonte oficial de informações sobre o SVR é o site oficial do Banco Central.'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: AppListView(
        children: [
          const Header.text(
            'Conta gov.br: como aumentar o nível para \'prata\' ou \'ouro\'',
            'Para resgatar seus valores, é preciso ter uma conta Gov.br, com nível de segurança prata ou ouro. \n\nA conta gov.br dá acesso aos serviços digitais do governo como, por exemplo, INSS, carteira de trabalho digital, Receita Federal, eSocial, entre outros.',
          ),
          const WarningCard('Estas contas são divididas em "ouro", "prata" e "bronze". O padrão ao entrar no serviço é ter o acesso "bronze". O login nível "prata" ou "ouro" exige maior nível de segurança, como reconhecimento facial, permitindo o acesso a bancos credenciados e a serviços mais sensíveis - como o resgate de valores esquecidos nos bancos.', hasTitle: false,),
          const H(24),
          const AppTitle('Passo a passo'),
          const H(24),
          const AppDesc('A criação da conta gov.br é gratuita. Quem ainda não possui, pode fazer o cadastro pelos seguintes caminhos:'),
          const H(24),
          CheckList(checkList.sublist(0,1)),
          const H(16),
          AppImage(url: 'assets/images/gov.png', isSVG: false,fit: BoxFit.fitHeight, height: MediaQuery.of(context).size.width),
          const H(24),
          const WarningCard('A conta gov.br tem três níveis de segurança e acesso: bronze, prata e ouro.', hasTitle: false,),
          const H(24),
          const AppDesc('Ao ser criada via formulário online do INSS ou da Receita Federal, por exemplo, a conta gov.br costuma iniciar no nível bronze, que dá acesso apenas parcial aos serviços digitais do governo e cujo grau de segurança é considerado apenas básico. \n\nAo fazer o login no gov.br, o cidadão já é informado do nível da conta. Para aumentar o nível, basta seguir as instruções ou entrar em "Privacidade/Selos de Confiabilidade".'),
          const H(24),
          AppImage(url: 'assets/images/nivelConta.png', isSVG: false,fit: BoxFit.fitHeight, height: MediaQuery.of(context).size.width),
          const H(24),
          const BannerWidget(),
          const H(24),
          const AppTitle('Como obter nível prata?'),
          const H(24),
          const AppDesc('O nível prata é obtido por meio de:'),
          const H(24),
          CheckList(checkList.sublist(1,4)),
          const H(24),
          const AppTitle('Como obter nível ouro?'),
          const H(24),
          const AppDesc('O nível máximo de segurança pode ser através de:'),
          const H(24),
          CheckList(checkList.sublist(4,6)),
          const H(24),
          AppImage(url: 'assets/images/servicoAutorizacao.png', isSVG: false,fit: BoxFit.fitHeight, height: MediaQuery.of(context).size.width),
          const H(24),
          const AppTitle('Perguntas Frequentes'),
          const H(24),
          const AppDesc('Confira perguntas frequentemente feitas por usuários, e tire suas dúvidas.'),
          const H(24),
          CardAppAccordeon(accordeonList),
        ],
      ),
    );
  }
}

class WarningCard extends StatelessWidget {
  final String? text;
  final String label;
  final bool hasTitle;
  const WarningCard(this.label, {
    super.key, this.text, this.hasTitle = true,
  });

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
                     (hasTitle) ? TextSpan(
                        text: text ?? 'Atenção: ',
                        style: const TextStyle(color: AppColors.warningShadow).titleMedium,
                      ) : const TextSpan(),
                      TextSpan(
                        text: label,
                        style: const TextStyle(color: AppColors.warningShadow).bodyLarge,
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
