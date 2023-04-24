import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_accordeon.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/label_double_column.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/models/carroussel_model.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class KnowReceivePage extends JourneyStatefulWidget {
  const KnowReceivePage({Key? key}) : super(key: key, name: 'KnowReceivePage');

  @override
  State<KnowReceivePage> createState() => KnowReceivePageState();
}

class KnowReceivePageState extends State<KnowReceivePage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get('${widget.name}1'),
    );
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get('${widget.name}2'),
    );
    super.initState();
  }

  List<CheckListModel> checkList = [
    CheckListModel(
      icon: Icons.check,
      label: 'Acesse o site e clique no botão ”Consulte se tem valores a receber”;',
    ),
    CheckListModel(
      icon: Icons.check,
      label:
          'Em seguida, será necessário informar os dados solicitados:\nCPF e data de nascimento, caso se trate de pessoa física.\nCNPJ e a data de abertura da empresa, em caso de pessoa jurídica;',
    ),
    CheckListModel(
      icon: Icons.check,
      label:
          'Faça o login com seu CPF e senha no Gov.br. Caso ainda não tenha uma conta, basta fazer seu cadastro;',
    ),
    CheckListModel(
      icon: Icons.check,
      label: 'Se tiver algum valor a receber, selecione a opção “Acessar o SVR”;',
    ),
    CheckListModel(
      icon: Icons.check,
      label:
          'Depois disso, é necessário fazer o login com a conta gov.br.\nPara valores de pessoa física, é preciso que a conta gov.br seja de nível prata ou ouro.\nPara valores de pessoa jurídica, precisa ter conta gov.br com qualquer tipo de vínculo ao CNPJ, exceto de colaborador;',
    ),
    CheckListModel(
      icon: Icons.check,
      label: 'Após realizar o login com sua conta gov.br, acesse a opção “Meus Valores a Receber”;',
    ),
    CheckListModel(
      icon: Icons.check,
      label:
          'Por fim, caso tenha valores a receber, para solicitar o valor é preciso seguir as orientações indicadas pela plataforma.',
    ),
  ];

  final List<AccordeonModel> _questions = [
    AccordeonModel(
      title: 'Qual o prazo para receber o dinheiro esquecido?',
      desc:
          'O prazo para receber depende da forma de solicitação. Se for solicitado no sistema com chave PIX o valor será recebido em até 12 dias úteis. Se for solicitado diretamente em contato com a instituição, ou pelo sistema sem PIX, o prazo pode passar de 12 dias úteis.',
    ),
    AccordeonModel(
      title: 'Quais são as formas de receber o dinheiro esquecido?',
      desc:
          'O dinheiro esquecido pode ser solicitado pelo SRV ou direto com a instituição financeira ou banco, e pode ser enviado ao cliente por PIX, TED ou DOC.',
    ),
    AccordeonModel(
      title: 'Como saber se tenho valores a receber do Banco Central?',
      desc:
          'Basta entrar no site Valores a Receber, do Banco Central, inserir o número do seu CPF, data de nascimento e conferir se tem direito.',
    ),
    AccordeonModel(
      title: 'Quais as recomendações para evitar golpes no SVR?',
      desc:
          'O Banco Central recomenda que as pessoas desconfiem de toda informação recebida por WhatsApp e não acessem nenhum link nas mensagens, pois podem roubar senhas, instalar vírus e programas maliciosos. A única fonte oficial de informações sobre o SVR é o site oficial do Banco Central.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      active: AdController.adConfig.banner.active,
      behavior: ['${widget.name}1', '${widget.name}2'],
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
      padding: EdgeInsets.zero,
      children: [
        BackHeader(
          button: ButtonIconSmall(
            onTap: () {
              Navigator.pop(context);
              push(context, Container());
            },
            icon: Icons.open_in_new,
            label: 'Consultar Agora',
            invert: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const H(16),
              const HeaderHero(
                title: 'Como saber se tenho valores a receber?',
                desc:
                    'Para saber se tem valores a receber, é preciso consultar o Serviço Valores a Receber (SVR), que é uma plataforma online criada para auxiliar o interessado a verificar se tem valores esquecidos para receber.',
                image:
                    'https://ldcapps.com/wp-content/uploads/2023/04/Como-saber-se-tenho-valores-a-receber.png',
              ),
              const H(16),
              AppBannerAd(AdBannerStorage.get('${widget.name}1')),
              const H(24),
              Text(
                'Para realizar essa consulta, basta seguir o passo a passo:',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
              const H(16),
              CheckList(checkList),
              const H(32),
              AppBannerAd(AdBannerStorage.get('${widget.name}2')),
              const H(24),
              const LabelDoubleColumn('Perguntas', 'Frequentes'),
            ],
          ),
        ),
        AppAccordeon(_questions),
        const H(16),
      ],
    );
  }
}
