import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaNisSiteMeuInssPage extends AdStatefulWidget {
  ConsultaNisSiteMeuInssPage({Key? key})
      : super(key: key, name: 'ConsultaNisSiteMeuNisPage');

  @override
  State<ConsultaNisSiteMeuInssPage> createState() =>
      _ConsultaNisSiteMeuNisPage();
}

class _ConsultaNisSiteMeuNisPage extends State<ConsultaNisSiteMeuInssPage> {
  List<AppStep> get steps => [
        const AppStep(
          label:
              'Acesse o site oficial do Meu INSS. O link está disponível no botão fixo no fim desta página “IR PARA MEU INSS”.',
        ),
        const AppStep(
          label:
              'Em seguida, entre com o login da sua conta Gov.BR, geralmente as credênciais de acesso são CPF e Senha.',
          image: 'assets/images/image4.png',
        ),
        const AppStep(
          label:
              'Ao entrar no site com suas credenciais de acesso, busque o menu na lateral esquerda. Abaixo do seu nome, na parte superior do menu, você verá seu NIT que é mesma coisa do NIS. Caso não encontre seu NIT no menu lateral, acesse a opção “Meu Cadastro”.',
          image: 'assets/images/image5.png',
        ),
        const AppStep(
          label:
              'Na página “Meu Cadastro” role até em baixo e procure o item NIT, este número é o número do seu NIS.',
          image: 'assets/images/image6.png',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bottom: Footer(
          AppButton(
            onTap: () => AdUtils.loadUrl('https://meu.inss.gov.br/#/login'),
            label: 'IR PARA MEU INSS',
            icon: Symbols.trending_flat,
          ),
        ),
        child: body(context));
  }

  Widget body(_) {
    return AppListView(
      children: [
        const Header.light(),
        const HeaderTitle(
          'Consultando NIS através do site Meu INSS',
          color: Color(0xFF020617),
        ),
        const H(16),
        const HeaderDesc(
          'Veja como é fácil encontrar seu NIS no site Meu INSS. Confira o passo a passo logo abaixo e aprenda.',
          color: Color(0xFF020617),
        ),
        const H(16),
        const BannerWidget(),
        const H(16),
        AppStepper(steps),
      ],
    );
  }
}
