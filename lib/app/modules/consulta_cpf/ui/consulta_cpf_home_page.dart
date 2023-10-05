import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/client/cpf_captcha/models/cpf_captcha_situacao_model.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_cpf/consulta_cpf_controller.dart';
import 'package:svr/app/modules/consulta_cpf/consulta_cpf_model.dart';
import 'package:svr/app/modules/consulta_cpf/ui/consulta_cpf_success_page.dart';

class ConsultaCPFHomePage extends AdStatefulWidget {
  ConsultaCPFHomePage({Key? key})
      : super(key: key, name: 'ConsultaCPFHomePage');

  @override
  State<ConsultaCPFHomePage> createState() => _ConsultaCPFHomePageState();
}

class _ConsultaCPFHomePageState extends State<ConsultaCPFHomePage> {
  final ConsultaCPFController _controller = ConsultaCPFController();

  List<CardFeature> get cardHomeItens => [
        CardFeature(
          label: 'Como funciona e\nvalores.',
          prefix: Symbols.attach_money,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () =>
                  push(context, const Text('Como funciona e\nvalores.'))),
        ),
        CardFeature(
          label: 'Consulte suas\ndívidas',
          prefix: Symbols.request_quote,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () =>
                  push(context, const Text('Consulte suas\ndívidas'))),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainer,
      bottom: Footer(
        AppButton(
          label: 'CONSULTAR',
          onTap: () => push(
              context,
              ConsultaCPFSuccessPage(CPFCaptchaSituacaoModel(
                  cpf: '',
                  dataNascimento: '',
                  situacaoCadastral: '',
                  codigoControleComprovante: '',
                  comprovanteEmitido: '',
                  dataInscricao: '',
                  digitoVerificador: '',
                  nome: ''))),
          icon: Icons.arrow_forward,
        ),
      ),
      child: StreamOut<ConsultaCPFModel>(
        stream: _controller.consultaStream.listen,
        child: (_, model) => AppListView(
          children: [
            const Header(
              title: 'Verifique a\nsituação de seu\nCPF.',
              desc:
                  'Digite seu CPF no campo abaixo para realizar uma consulta nas bases de dados da Receita Federal.',
            ),
            AppField(
              controller: model.cpfEC,
              focus: model.cpfFC,
              label: 'CPF',
              hint: '000.000.000-00',
              type: const TextInputType.numberWithOptions(),
              icon: Symbols.person_search,
              action: TextInputAction.next,
              onEditingComplete: () => model.dataNascimentoFC.requestFocus(),
            ),
            const H(16),
            AppField(
              controller: model.dataNascimentoEC,
              focus: model.dataNascimentoFC,
              label: 'Data de nascimento',
              hint: '00/00/0000',
              type: const TextInputType.numberWithOptions(),
              icon: Symbols.calendar_month,
              action: TextInputAction.go,
              onEditingComplete: () => _controller.onClickProximo(context),
            ),
            const H(16),
            const CardAlert.info(
                'Não armazenamos seus dados\nao fazer a consulta.'),
            const H(16),
            const AppTitle('Veja mais opções.'),
            const H(16),
            const BannerWidget(),
            const H(16),
            CardFeatures(cardHomeItens)
          ],
        ),
      ),
    );
  }
}
