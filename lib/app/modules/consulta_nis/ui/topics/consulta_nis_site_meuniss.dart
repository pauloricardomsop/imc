import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaNisSiteMeuNisPage extends AdStatefulWidget {
  ConsultaNisSiteMeuNisPage({Key? key}) : super(key: key, name: 'ConsultaNisSiteMeuNisPage');

  @override
  State<ConsultaNisSiteMeuNisPage> createState() => _ConsultaNisSiteMeuNisPage();
}

class _ConsultaNisSiteMeuNisPage extends State<ConsultaNisSiteMeuNisPage> {
  List<CheckListModel> get checklist => [
        CheckListModel(
          label:
              'O Bolsa Família integra em apenas um programa várias políticas públicas de assistência social, saúde, educação, emprego e renda.',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label:
              'O novo programa social de transferência direta e indireta de renda é destinado às famílias em situação de pobreza e de extrema pobreza em todo o país.',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label:
              'Além de garantir uma renda básica a essas famílias, o programa busca simplificar a cesta de benefícios e estimular a emancipação dessas famílias para que alcancem autonomia e superem situações de vulnerabilidade social.',
          icon: Symbols.check_circle,
        ),
        CheckListModel(
          label:
              'O Bolsa Família é coordenado pelo Ministério da Cidadania, responsável por gerenciar os benefícios do programa e o envio de recursos para pagamento.',
          icon: Symbols.check_circle,
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
    return ListView(
      children: const [
        Header(
          backgroundColor: AppColors.white,
          top: HeaderTop(
            backgroundColor: AppColors.white,
            leading: AppIcon.back(
              backgroundColor: AppColors.surfaceContainer,
              iconColor: AppColors.onSurface,
            ),
          ),
          title: 'Consultando NIS através do site Meu INSS',
          desc:
              'Veja como é fácil encontrar seu NIS no site Meu INSS. Confira o passo a passo logo abaixo e aprenda.',
        ),
        BannerWidget(),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTitle('Passo a passo:'),
              H(24),
              AppDesc(
                  '1. Acesse o site oficial do Meu INSS. O link está disponível no botão fixo no fim desta página “IR PARA MEU INSS”.'),
              H(24),
              AppDesc(
                  '2. Em seguida, entre com o login da sua conta Gov.BR, geralmente as credênciais de acesso são CPF e Senha.'),
              H(8),
              AppImage(url: 'assets/images/image4.png', isSVG: false),
              H(24),
              AppDesc(
                  '3. Ao entrar no site com suas credenciais de acesso, busque o menu na lateral esquerda. Abaixo do seu nome, na parte superior do menu, você verá seu NIT que é mesma coisa do NIS. Caso não encontre seu NIT no menu lateral, acesse a opção “Meu Cadastro”.'),
              H(8),
              AppImage(
                url: 'assets/images/image5.png',
                isSVG: false,
                fit: BoxFit.contain,
              ),
              H(24),
              AppDesc(
                  '4. Na página “Meu Cadastro” role até em baixo e procure o item NIT, este número é o número do seu NIS.'),
              H(8),
              AppImage(url: 'assets/images/image6.png', isSVG: false),
            ],
          ),
        )
      ],
    );
  }
}
