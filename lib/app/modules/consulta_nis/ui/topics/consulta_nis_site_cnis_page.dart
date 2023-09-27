import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConsultaNisSiteCnisPage extends AdStatefulWidget {
  ConsultaNisSiteCnisPage({Key? key})
      : super(key: key, name: 'ConsultaNisSiteCnisPage');

  @override
  State<ConsultaNisSiteCnisPage> createState() => _ConsultaNisSiteCnisPage();
}

class _ConsultaNisSiteCnisPage extends State<ConsultaNisSiteCnisPage> {
  List<AppStep> get steps => [
        const AppStep(
          label:
              'Primeiro acesse o site CNIS (Cadastro Nacional de Informações Sociais).',
        ),
        const AppStep(
            label: 'Após acessar o site CNIS, selecione a opção “Cidadão”.',
            image: 'assets/images/image1.png'),
        const AppStep(
            label:
                'após acessar o menu cidadão, busque no canto superior direito da tela o ícone de MENU, abra o menu e busque a opção de “Inscrição” e por fim selecione a opção “Filiado”.',
            image: 'assets/images/image2.png'),
        const AppStep(
            label:
                'Nesta parte, você verá um formulário solicitando seu nome, nome de sua mãe, sua data de nascimento e seu CPF. Preencha os campos e clique na caixa de verificação “Não sou um robô”, após verificar que você não éum robô, clique em “Continuar”.',
            image: 'assets/images/image3.png'),
        const AppStep(
          label:
              'Após preencher o formulário você verá uma mensagem contendo o número NIT/PIS, este é o mesmo número de seu NIS.',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bottom: Footer(
          AppButton(
            onTap: () => AdUtils.loadUrl(
                'https://cnisnet.inss.gov.br/cnisinternet/faces/pages/index.xhtml'),
            label: 'IR PARA SITE CNIS',
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
          'Como saber se meu CadÚnico está atualizado?',
          color: Color(0xFF020617),
        ),
        const H(16),
        const HeaderDesc(
          'O usuário poderá verificar se seus dados cadastrais estão atualizados ou não pelo aplicativo do Cadastro Único ou na versão web através do endereço cadunico.cidadania.gov.br. \n\nOutra opção é verificar no CRAS mais próximo de sua casa.',
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
