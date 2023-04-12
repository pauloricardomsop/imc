import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_card_purple.dart';
import 'package:svr/app/core/components/app_carroussel.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/button_icon.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/label_double_column.dart';
import 'package:svr/app/core/models/carroussel_model.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class QueryDetailedPage extends JourneyStatefulWidget {
  const QueryDetailedPage({Key? key}) : super(key: key, name: 'QueryDetailedPage');

  @override
  State<QueryDetailedPage> createState() => QueryDetailedPageState();
}

class QueryDetailedPageState extends State<QueryDetailedPage> {
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

  final List<CarrousselModel> _questions = [
    CarrousselModel(
      title: 'Qual o prazo para receber o dinheiro esquecido?',
      desc:
          'O prazo para receber depende da forma de solicitação. Se for solicitado no sistema com chave PIX o valor será recebido em até 12 dias úteis. Se for solicitado diretamente em contato com a instituição, ou pelo sistema sem PIX, o prazo pode passar de 12 dias úteis.',
    ),
    CarrousselModel(
      title: 'Quais são as formas de receber o dinheiro esquecido?',
      desc:
          'O dinheiro esquecido pode ser solicitado pelo SRV ou direto com a instituição financeira ou banco, e pode ser enviado ao cliente por PIX, TED ou DOC.',
    ),
    CarrousselModel(
      title: 'Como saber se tenho valores a receber do Banco Central?',
      desc:
          'Basta entrar no site Valores a Receber, do Banco Central, inserir o número do seu CPF, data de nascimento e conferir se tem direito.',
    ),
    CarrousselModel(
      title: 'Quais as recomendações para evitar golpes no SVR?',
      desc:
          'O Banco Central recomenda que as pessoas desconfiem de toda informação recebida por WhatsApp e não acessem nenhum link nas mensagens, pois podem roubar senhas, instalar vírus e programas maliciosos. A única fonte oficial de informações sobre o SVR é o site oficial do Banco Central.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: ['${widget.name}1', '${widget.name}2'],
        body: body(context),
      ),
    );
  }

  Widget body(_) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        BackHeader(
          button: ButtonIconSmall(
            onTap: () {},
            icon: Icons.arrow_forward_ios_outlined,
            label: 'Próximo',
            invert: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBannerAd(AdBannerStorage.get('${widget.name}2')),
              const H(16),
              const HeaderHero(
                title: 'Passo a passo para consultar e resgatar valores a receber de falecidos.',
                desc:
                    'O sistema valores a receber começou a sua segunda faze como uma grande novidade, agora você pode consultar e resgatar valores de pessoas falecidas\n\nVeja passo a passo e dicas importantes de como resgatar valores de pessoas falecidas.',
              ),
              const H(24),
              AppBannerAd(AdBannerStorage.get('${widget.name}2')),
              const H(24),
              //VIDEO YT
              const H(24),
              const AppCardPurple(
                  'Atenção: O vídeo acima é do canal oficial do Banco Central no Youtube. Nosso app não tem nenhum relacionamento formal com o Banco Centra. Somente facilitamos o acesso a informações baseadas nos sites oficiais.'),
              const H(16),
              Text(
                'Passo a passo de como resgatar valores de pessoas falecidas?',
                style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
              ),
              Text(
                'Tanto pelo sistema do Banco Central, como pela instituição ou pelo banco, o serviço é oferecido gratuitamente. Confira a seguir como solicitar o recebimento de seus valores a receber.',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
              const H(16),
              CheckList([
                CheckListModel(
                    icon: Icons.done,
                    label:
                        'Se o sistema oferecer a opção “Solicitar por aqui”, selecione uma de suas chaves PIX, no campo obrigatório, e informe seus dados pessoais solicitados.\nGuarde o número de protocolo, para entrar em contato com a instituição, se necessário.')
              ]),
              const AppCardPurple(
                  'Atenção: Somente quando é informada a chave PIX na solicitação do SVR, é que o cliente deve receber o valor no prazo de até 12 dias úteis.'),
              const H(16),
              Text(
                'Mesmo que você tenha indicado o PIX, a instituição ou banco poderá devolver o dinheiro por TED ou DOC na conta bancária vinculada à chave informada.\n\nAlém disso, a instituição ou o banco pode entrar em contato pelo telefone ou pelo e-mail indicado por você para confirmar sua identidade ou esclarecer dúvidas sobre a forma de devolução.\n\nEsse é um procedimento para a segurança da empresa, mas não é necessário que você forneça suas senhas.',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
              const H(16),
              CheckList([
                CheckListModel(
                    icon: Icons.done,
                    label:
                        'Caso o sistema ofereça a opção “Solicitar por aqui”, mas não apresentar chave Pix disponível para seleção, entre em contato diretamente com a instituição financeira ou com o banco.\n\nO contato pode ser feito pelo telefone, e-mail informado ou presencialmente, para combinar a forma de devolução do dinheiro.')
              ]),
              const H(8),
              Text(
                'Com a opção: Direto com a instituição ou banco.',
                style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
              ),
              const H(8),
              Text(
                'Se o sistema não oferecer a opção “Solicitar por aqui”, entre em contato diretamente com a instituição ou banco, por telefone ou e-mail, para combinar a forma de devolução.\n\nCaso tenha solicitado para receber por PIX, você pode solicitar o comprovante, que contém informações sobre o valor a receber, as solicitações realizadas e o protocolo de solicitação.\n\nContinue por dentro de novidades sobre valores a receber e outros benefícios que você pode ter direito, inscreva-se abaixo e receba os nossos conteúdos por e-mail.',
                style: AppTheme.text.normal.base(const Color(0xFF474747)),
              ),
              const H(24),
              AppBannerAd(AdBannerStorage.get('${widget.name}1')),
              const H(24),
              const LabelDoubleColumn('Perguntas', 'Frequentes'),
            ],
          ),
        ),
        AppCarroussel(_questions),
        const H(16),
      ],
    );
  }
}
