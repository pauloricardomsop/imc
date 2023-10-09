import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:request_manager/request_manager.dart';
import 'package:svr/app/core/enums/consulta_valores_tipo.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_cpf/consulta_cpf_controller.dart';
import 'package:svr/app/modules/consulta_cpf/consulta_cpf_model.dart';
import 'package:svr/app/modules/consulta_svr/ui/consultar_svr_home_page.dart';
import 'package:svr/app/modules/servicos_banco_central/servico_banco_central_home_page.dart';

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
          label: 'Serviços do Banco\nCentral',
          prefix: Symbols.monitoring,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context, ServicoBancoCentralHomePage())),
        ),
        CardFeature(
          label: 'Consultar Valores\na Receber',
          prefix: Symbols.payments,
          onTap: () => AdManager.showIntersticial(context,
              flow: AdFlow.going,
              onDispose: () => push(context,
                  ConsultarSVRHomePage(ConsultaValoresPessoaEstado.vivo))),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainer,
      bottom: Footer(
        AppButton(
          label: 'CONSULTAR',
          onTap: () =>
              ConsultaCPFAdapter.getConsultaCPF('606.960.033-92', '14/09/1995'),
          icon: Icons.arrow_forward,
        ),
      ),
      child: StreamOut<ConsultaCPFViewModel>(
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
