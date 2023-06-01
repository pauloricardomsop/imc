import 'package:flutter/material.dart';
import 'package:svr/app/core/ad/ad_banner_storage.dart';
import 'package:svr/app/core/ad/ad_controller.dart';
import 'package:svr/app/core/components/app_accordeon.dart';
import 'package:svr/app/core/components/app_banner_ad.dart';
import 'package:svr/app/core/components/app_card_purple.dart';
import 'package:svr/app/core/components/app_image.dart';
import 'package:svr/app/core/components/app_list_view.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/back_header_benefit.dart';
import 'package:svr/app/core/components/check_list.dart';
import 'package:svr/app/core/components/exit_banner.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/header_hero.dart';
import 'package:svr/app/core/components/in_footer_cta.dart';
import 'package:svr/app/core/components/label_double_column.dart';
import 'package:svr/app/core/components/rate_app.dart';
import 'package:svr/app/core/models/accordeon_model.dart';
import 'package:svr/app/core/models/check_list_model.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/core/utils/global_resource.dart';

class AumentarNivelPage extends JourneyStatefulWidget {
  const AumentarNivelPage({Key? key}) : super(key: key, name: 'AumentarNivelPage');

  @override
  State<AumentarNivelPage> createState() => AumentarNivelPageState();
}

class AumentarNivelPageState extends State<AumentarNivelPage> {
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
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get('${widget.name}3'),
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
      behavior: ['${widget.name}1', '${widget.name}2', '${widget.name}3'],
      bottom: _inFooterCta(),
      child: body(context),
    );
  }

  Widget body(_) {
    return Stack(
      children: [
        AppListView(
          padding: EdgeInsets.zero,
          children: [
            const BackHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const H(16),
                  const HeaderHero(
                    title: 'Conta gov.br: como aumentar o nível para "prata" ou "ouro"',
                    desc:
                        'Para resgatar seus valores, é preciso ter uma conta Gov.br, com nível de segurança prata ou ouro. \n\nA conta gov.br dá acesso aos serviços digitais do governo como, por exemplo, INSS, carteira de trabalho digital, Receita Federal, eSocial, entre outros.',
                    image:
                        'https://ldcapps.com/wp-content/uploads/2023/04/Conta-gov-como-aumentar-o-nivel-para-prata-ou-ouro.png',
                  ),
                  const H(24),
                  AppBannerAd(AdBannerStorage.get('${widget.name}1')),
                  const H(24),
                  const AppCardPurple(
                      'Estas contas são divididas em "ouro", "prata" e "bronze". O padrão ao entrar no serviço é ter o acesso "bronze". O login nível "prata" ou "ouro" exige maior nível de segurança, como reconhecimento facial, permitindo o acesso a bancos credenciados e a serviços mais sensíveis - como o resgate de valores esquecidos nos bancos.'),
                  const H(16),
                  Text(
                    'Passo a passo',
                    style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
                  ),
                  const H(8),
                  Text(
                    'A criação da conta gov.br é gratuita. Quem ainda não possui, pode fazer o cadastro pelos seguintes caminhos:',
                    style: AppTheme.text.normal.base(const Color(0xFF474747)),
                  ),
                  const H(16),
                  CheckList([
                    CheckListModel(
                        icon: Icons.done,
                        label: 'Acesse o site sso.acesso.gov.br ou baixe o app gov.br',
                        image: const AppImage(
                          url:
                              'https://ldcapps.com/wp-content/uploads/2023/04/Conta-gov-como-aumentar-o-nivel-para-prata-ou-ouro-2.png',
                          height: 500,
                        )),
                  ]),
                  const AppCardPurple(
                      'A conta gov.br tem três níveis de segurança e acesso: bronze, prata e ouro.'),
                  const H(16),
                  Text(
                    'Ao ser criada via formulário online do INSS ou da Receita Federal, por exemplo, a conta gov.br costuma iniciar no nível bronze, que dá acesso apenas parcial aos serviços digitais do governo e cujo grau de segurança é considerado apenas básico.\n\nAo fazer o login no gov.br, o cidadão já é informado do nível da conta. Para aumentar o nível, basta seguir as instruções ou entrar em "Privacidade/Selos de Confiabilidade".',
                    style: AppTheme.text.normal.base(const Color(0xFF474747)),
                  ),
                  const H(16),
                  const AppRate(),
                  const H(16),
                  const AppImage(
                    url:
                        'https://ldcapps.com/wp-content/uploads/2023/04/Conta-gov-como-aumentar-o-nivel-para-prata-ou-ouro-3.png',
                    height: 500,
                  ),
                  const H(16),
                  Text(
                    'Como obter nível prata?',
                    style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
                  ),
                  const H(8),
                  Text(
                    'O nível prata é obtido por meio de:',
                    style: AppTheme.text.normal.base(const Color(0xFF474747)),
                  ),
                  const H(16),
                  CheckList([
                    CheckListModel(
                        icon: Icons.done,
                        label:
                            'Validação facial pelo aplicativo gov.br para conferência da sua foto nas bases da Carteira de Habilitação (CNH)'),
                    CheckListModel(
                        icon: Icons.done,
                        label:
                            'Validação dos dados pessoais via internet banking de um banco credenciado'),
                    CheckListModel(
                        icon: Icons.done,
                        label:
                            'Validação dos dados com usuário e senha do SIGEPE, se o cidadão for servidor público federal')
                  ]),
                  const H(8),
                  AppBannerAd(AdBannerStorage.get('${widget.name}2')),
                  const H(16),
                  Text(
                    'Como obter nível ouro?',
                    style: AppTheme.text.extra.xl(const Color(0xFF1B1C1C)),
                  ),
                  const H(8),
                  Text(
                    'O nível máximo de segurança pode ser através de:',
                    style: AppTheme.text.normal.base(const Color(0xFF474747)),
                  ),
                  const H(16),
                  CheckList([
                    CheckListModel(
                        icon: Icons.done,
                        label:
                            'Validação facial pelo aplicativo gov.br para conferência da sua foto nas bases da Justiça Eleitoral'),
                    CheckListModel(
                        icon: Icons.done,
                        label:
                            'Validação dos seus dados com Certificado Digital compatível com ICP-Brasil',
                        image: const AppImage(
                          url:
                              'https://ldcapps.com/wp-content/uploads/2023/04/Conta-gov-como-aumentar-o-nivel-para-prata-ou-ouro-4.png',
                          height: 500,
                        )),
                  ]),
                  const H(24),
                  AppBannerAd(AdBannerStorage.get('${widget.name}3')),
                  const H(24),
                  const LabelDoubleColumn('Perguntas', 'Frequentes'),
                ],
              ),
            ),
            AppAccordeon(_questions),
            const H(160),
          ],
        ),
      ],
    );
  }

  InFooterCta _inFooterCta() {
    return InFooterCta(
      onTap: () => push(
          context,
          ExitBanner(
            widget.name,
            title: 'Você será encaminhado para um site oficial do governo.',
            url: 'https://valoresareceber.bcb.gov.br/publico',
            buttonLabel: 'Ir para site externo',
            buttonSubLabel: 'Você será redirecionado para o site oficial do Banco Central:  ',
            buttonSubLabelBold: 'valoresareceber.bcb.gov.br',
          )),
      label: 'Acessar GOV.BR',
      invert: true,
      subtitle: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
              text: 'Você será redirecionado para o site oficial do GOV.BR:  ',
              style: AppTheme.text.normal.sm(const Color(0xFF474747))),
          TextSpan(
              text: 'sso.acesso.gov.br',
              style: AppTheme.text.normal
                  .sm(const Color(0xFF474747))
                  .copyWith(fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
