import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/modules/home/topics/como_aumentar_nivel_page.dart';

class ComoReceberMeusValoresPage extends AdStatefulWidget {
  ComoReceberMeusValoresPage({Key? key})
      : super(key: key, name: 'ComoReceberMeusValoresPage');

  @override
  State<ComoReceberMeusValoresPage> createState() =>
      _ComoReceberMeusValoresPageState();
}

class _ComoReceberMeusValoresPageState
    extends State<ComoReceberMeusValoresPage> {
  List<CheckListModel> get checkList => [
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label:
              'Se o sistema oferecer a opção “Solicitar por aqui”, selecione uma de suas chaves PIX, no campo obrigatório, e informe seus dados pessoais solicitados. \n\nGuarde o número de protocolo, para entrar em contato com a instituição, se necessário.',
        ),
        CheckListModel(
          icon: Symbols.check_circle,
          color: AppColors.success,
          label:
              'Caso o sistema ofereça a opção “Solicitar por aqui”, mas não apresentar chave Pix disponível para seleção, entre em contato diretamente com a instituição financeira ou com o banco. \n\nO contato pode ser feito pelo telefone, e-mail informado ou presencialmente, para combinar a forma de devolução do dinheiro.',
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
            'Como vou receber meus valores?',
            'O recebimento do dinheiro esquecido pode ser feito de duas maneiras, pelo sistema oferecido ou por contato direto com a instituição financeira ou banco.',
          ),
          const WarningCard(
              'O Banco Central informou que não solicita confirmação de dados posteriormente e que somente a instituição ou banco que aparece na consulta do SVR pode entrar em contato com o cliente.'),
          const H(24),
          const AppDesc(
              'Tanto pelo sistema do Banco Central, como pela instituição ou pelo banco, o serviço é oferecido gratuitamente. Confira a seguir como solicitar o recebimento de seus valores a receber.'),
          CheckList(checkList.sublist(0, 1)),
          const WarningCard(
              'Somente quando é informada a chave PIX na solicitação do SVR, é que o cliente deve receber o valor no prazo de até 12 dias úteis.'),
          const H(24),
          const AppDesc(
              'Mesmo que você tenha indicado o PIX, a instituição ou banco poderá devolver o dinheiro por TED ou DOC na conta bancária vinculada à chave informada. \n\nAlém disso, a instituição ou o banco pode entrar em contato pelo telefone ou pelo e-mail indicado por você para confirmar sua identidade ou esclarecer dúvidas sobre a forma de devolução. \n\nEsse é um procedimento para a segurança da empresa, mas não é necessário que você forneça suas senhas.'),
          CheckList(checkList.sublist(1, 2)),
          const BannerWidget(),
          const H(24),
          const AppTitle('Com a opção: Direto com a instituição ou banco.'),
          const H(24),
          const AppDesc(
              'Se o sistema não oferecer a opção “Solicitar por aqui”, entre em contato diretamente com a instituição ou banco, por telefone ou e-mail, para combinar a forma de devolução. \n\nCaso tenha solicitado para receber por PIX, você pode solicitar o comprovante, que contém informações sobre o valor a receber, as solicitações realizadas e o protocolo de solicitação. \n\nContinue por dentro de novidades sobre valores a receber e outros benefícios que você pode ter direito, inscreva-se abaixo e receba os nossos conteúdos por e-mail.'),
          const H(24),
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
