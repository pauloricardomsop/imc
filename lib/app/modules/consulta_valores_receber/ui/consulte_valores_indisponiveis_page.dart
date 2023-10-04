import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart' as dk;
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_valores_receber/consulta_valores_controller.dart';

class ConsulteSeusValoresIndisponiveisPage extends AdStatefulWidget {
  ConsulteSeusValoresIndisponiveisPage({
    Key? key,
  }) : super(key: key, name: 'ConsulteSeusValoresIndisponiveisPage');

  @override
  State<ConsulteSeusValoresIndisponiveisPage> createState() =>
      ConsulteSeusValoresIndisponiveisPageState();
}

class ConsulteSeusValoresIndisponiveisPageState
    extends State<ConsulteSeusValoresIndisponiveisPage> {
  final ConsulteValoresController _controller = ConsulteValoresController();

  List<CardFeature> get gridItens => [
        CardFeature(
            label: 'Não sei o que é conta GOV.BR',
            prefix: Symbols.contact_support,
            onTap: () => AdManager.showIntersticial(context,
                flow: AdFlow.going, onDispose: () => push(context, Container()))),
        CardFeature(
            label: 'Fazer uma Nova Consulta',
            prefix: Symbols.find_replace,
            onTap: () => pops(context, 3)),
      ];

  @override
  Widget build(BuildContext context) {
    return dk.AppScaffold(
      hasBannerBottom: false,
      child: body(context),
    );
  }

  Widget body(_) {
    return dk.AppListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                titlePage(),
                const H(16),
                const Divisor(),
                const H(8),
                _userDataItem(
                  'CPF',
                  _controller.consulta.identifier.text,
                ),
                const H(8),
                _userDataItem(
                  'DATA DE NASCIMENTO',
                  _controller.consulta.date.text,
                ),
                const H(8),
                const Divisor(),
                const H(8),
                const AppDesc(
                    "Verifique se o CPF e a data de nascimento estão corretos. Se estiverem errados, refaça a consulta.\n\nMensalmente são divulgados novos valores a receber. Verifique o calendário e confira"),
                const H(16),
                AppButton(
                  label: 'PRÓXIMAS DIVULGAÇÕES',
                  onTap: () {
                    push(context, Container());
                    showModalBottomSheet(
                        context: context,
                        builder: (_) => Container(),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        )));
                  },
                  icon: Icons.arrow_right_alt,
                ),
                const H(16),
                appRateCard(),
                const H(16),
                CardFeatures(gridItens),
                const H(16),
                appInfoCard(),
              ],
            ))
      ],
    );
  }

  Row _userDataItem(String label, String value) {
    return Row(
      children: [
        Text('$label:', 
        // style: AppTheme.text.extra.base(const Color(0xFF1B1C1C)),
        ),
        const W(8),
        Text(
          value,
          // style: AppTheme.text.normal.base(const Color(0xFF1B1C1C),
          // ),
        ),
      ],
    );
  }

  Widget titlePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
          size: 64,
          fill: 1,
          color: Color(0xFFF42500),
        ),
        const H(12),
        Text(
          'Não foram encontrados\nvalores a receber para os\ndados informados:',
          textAlign: TextAlign.center,
          // style: AppTheme.text.extra.xl2(const Color(0xFF1B1C1C)),
        ),
      ],
    );
  }

  Widget appRateCard() => InkWell(
        onTap: () => sendToStore(),
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            border: Border.all(width: 1, color: const Color(0xFFE3E2E2)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: (index == 4) ? 0 : 8,
                    ),
                    child: const Icon(
                      Symbols.star,
                      fill: 1,
                      size: 32,
                      color: Color(0xFFF9A825),
                    ),
                  );
                }),
              ),
              const H(8),
              Text('Avaliar nosso app.',
                  textAlign: TextAlign.center,
                  // style: AppTheme.text.extra.xl2(const Color(0xFF1B1C1C))
                  ),
              const H(8),
              Text(
                'Sua avaliação é muito importante, deixe \nsua opinião na PlayStore.',
                textAlign: TextAlign.center,
                // style: AppTheme.text.normal.base(const Color(0xFF1B1C1C)),
              ),
              const H(8),
              Text(
                'AVALIAR AGORA',
                textAlign: TextAlign.center,
                // style: AppTheme.text.normal
                //     .xl(const Color(0xFF1C44F9))
                //     .copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );

  Widget appInfoCard() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration:
              BoxDecoration(color: const Color(0xFFDDE0FF), borderRadius: BorderRadius.circular(8)),
          child: const Icon(
            Symbols.info,
            weight: 800,
            color: Color(0xFF000C61),
          ),
        ),
        const W(16),
        Expanded(
          child: Text(
            'Informações extraídas do site oficial do Banco Central do Brasil.',
            // style: AppTheme.text.normal.base(const Color(0xFF000C61)),
          ),
        ),
      ],
    );
  }
}
