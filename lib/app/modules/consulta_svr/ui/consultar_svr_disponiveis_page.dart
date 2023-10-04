import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_svr/consultar_svr_controller.dart';

class ConsultarSVRDisponiveisPage extends AdStatefulWidget {
  ConsultarSVRDisponiveisPage({
    Key? key,
  }) : super(key: key, name: 'ConsultarSVRDisponiveisPage');

  @override
  State<ConsultarSVRDisponiveisPage> createState() =>
      ConsultarSVRDisponiveisPageState();
}

class ConsultarSVRDisponiveisPageState
    extends State<ConsultarSVRDisponiveisPage> {
  final ConsultarSVRController _controller = ConsultarSVRController();

  List<CardFeature> get gridItens => [
        CardFeature(
            label: 'Não sei o que é conta GOV.BR',
            prefix: Symbols.contact_support,
            onTap: () => AdManager.showIntersticial(context,
                flow: AdFlow.going,
                onDispose: () => push(context, Container()))),
        CardFeature(
            label: 'Fazer uma Nova Consulta',
            prefix: Symbols.find_replace,
            onTap: () => pops(context, 3)),
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: AppListView(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AppIcon.exit(
              onTap: () => Navigator.pop(context),
            ),
          ),
          const H(16),
          const BannerWidget(),
          const H(20),
          Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF079669),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.done,
                size: 32,
                color: Color(0xFFECFEF6),
              ),
            ),
          ),
          const H(24),
          Center(
              child: AppTitle(
            'O ${_controller.consulta.isPessoaFisica ? 'CPF' : 'CNPJ'} pesquisado tem valores a receber',
            textAlign: TextAlign.center,
          )),
          const H(24),
          Row(
            children: [
              HeaderCard.text(
                label: _controller.consulta.isPessoaFisica
                    ? 'CPF do\nTitular'
                    : 'CNPJ',
                icon: Symbols.password,
                title: _controller.consulta.identifier.text,
              ),
              const W(8),
              HeaderCard.text(
                label: 'Data de\nNascimento',
                icon: Symbols.event,
                title: _controller.consulta.date.text,
              )
            ],
          ),
          const H(24),
          AppButton(
              label: 'ACESSAR O SVR',
              onTap: () => AdUtils.loadUrl(
                  'https://valoresareceber.bcb.gov.br/wr/rest/start')),
          const H(12),
          AppButton(
              label: 'NOVA CONSULTA',
              backgroundColor: const Color(0xFFEFF6FF),
              borderColor: const Color(0xFF94C4FD),
              foregroundColor: const Color(0xFF172554),
              onTap: () => AdManager.showIntersticial(context,
                  onDispose: () => pops(context, 2))),
          const H(24),
          const CardAlert(
            icon: AppIcon.info(
              backgroundColor: Color(0xFFFED8AA),
              iconColor: Color(0xFF441407),
            ),
            label:
                'Você precisa ter Conta gov.br (nível prata ou ouro*) para entrar no Sistema de Valores a Receber (SVR).',
            backgroundColor: Color(0xFFFFEDD5),
            borderColor: Color(0xFFFED8AA),
            textColor: Color(0xFF421407),
          ),
          const H(24),
          const AppDesc(
            'No SVR, você pode consultar seus valores ou de pessoas falecidas (nesse caso, você precisa ser herdeiro, testamentário, inventariante ou procurador).',
            textAlign: TextAlign.center,
          ),
          const H(24),
          const RateApp()
        ],
      ),
    );
  }
}
