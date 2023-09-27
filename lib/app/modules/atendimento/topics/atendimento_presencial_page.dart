import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/client/providers/dataprev/models/posto_atendimento_model.dart';

import 'package:svr/app/core/components/stream_out.dart';

import 'package:svr/app/core/models/api_response_model.dart';
import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/atendimento/atendimento_presencial_controller.dart';
import 'package:svr/app/modules/atendimento/atendimento_presencial_model.dart';
import 'package:svr/app/modules/atendimento/topics/atendimento_bolsa_familia_page.dart';
import 'package:svr/app/modules/atendimento/topics/atendimento_caixa_cidadao_page.dart';
import 'package:svr/app/modules/atendimento/topics/atendimento_whatsapp_page.dart';
import 'package:svr/app/modules/atendimento/widgets/atendimento_estado_bottomsheet.dart';
import 'package:svr/app/modules/atendimento/widgets/atendimento_municipio_bottomsheet.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class AtendimentoPresencialPage extends AdStatefulWidget {
  AtendimentoPresencialPage({Key? key})
      : super(key: key, name: 'AtendimentoPresencialPage');

  @override
  State<AtendimentoPresencialPage> createState() =>
      _AtendimentoPresencialPageState();
}

class _AtendimentoPresencialPageState extends State<AtendimentoPresencialPage> {
  final AtendimentoPresencialController _controller =
      AtendimentoPresencialController();
  List<CardFeature> get gridItens => [
        CardFeature(
            label: 'Atendimento\nBolsa Família',
            prefix: Symbols.attach_money,
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, AtendimentoBolsaFamiliaPage()))),
        CardFeature(
            label: 'Atendimento\nCAIXA Cidadão',
            prefix: Symbols.add_card,
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, AtendimentoCaixaCidadaoPage()))),
        CardFeature(
            label: 'Atendimento\nWhatsapp CAIXA',
            prefix: Symbols.add_card,
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, AtendimentoWhatsappPage()))),
        CardFeature(
            label: 'Encontre um\nCRAS',
            prefix: Symbols.pin_drop,
            onTap: () => AdManager.showIntersticial(context,
                onDispose: () => push(context, AtendimentoPresencialPage()))),
      ];

  @override
  void initState() {
    _controller.init(context);
    _controller.postosStream = AppStreamResponse<List<PostoAtendimentoModel>>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        child: StreamOut<AtendimentoPresencialModel>(
            stream: _controller.atendimentoPresencialStream.listen,
            child: (_, model) => body(context, model)));
  }

  Widget body(_, AtendimentoPresencialModel model) {
    return AppListView(
      children: [
        Header(
          backgroundColor: AppColors.primaryShadow,
          top: const HeaderTop(backgroundColor: AppColors.primaryShadow),
          title: 'Atendimento Presencial',
          desc:
              'Encontre uma unidade de atendimento presencial perto de sua casa.',
          child: Column(
            children: [
              const H(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  estado('Estado', model.estado?.siglaUf ?? model.valueEstado),
                  const W(16),
                  municipio('Cidade',
                      model.municipio?.nomeMunicipio ?? model.valueMunicipio),
                ],
              ),
            ],
          ),
        ),
        const AppTitle('Unidades de atendimento'),
        const H(16),
        StreamBuilder<ApiResponse<List<PostoAtendimentoModel>>>(
          stream: _controller.postosStream.listen,
          builder: (context, postos) => ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              if (postos.connectionState == ConnectionState.waiting)
                const AppShimmer(
                  child: SizedBox(
                    height: 80,
                    width: 100,
                  ),
                )
              else if (postos.hasData && postos.data!.data.isNotEmpty)
                ...postos.data!.data.map((posto) => Column(
                      children: [
                        itemEnderecoWidget(posto),
                        const H(16),
                      ],
                    )),
            ],
          ),
        ),
      ],
    );
  }

  Widget itemEnderecoWidget(PostoAtendimentoModel posto) {
    return InkWell(
      onTap: () async => execUrl(
          'https://www.google.com/maps/search/?api=1&query=${posto.latitude},${posto.longitude}'),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.surfaceContainerHigh,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.surfaceContainerLowest,
                    ),
                  ),
                  child: const Icon(
                    Symbols.pin_drop,
                    color: AppColors.onPrimary,
                    size: 32,
                    weight: 700,
                  ),
                ),
                const W(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        posto.nomePostoAtendimento ?? '',
                        style: const TextStyle(color: AppColors.onSurface)
                            .titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      posto.distanciaReferencia != null &&
                              posto.distanciaReferencia! > 0.0
                          ? Text(
                              'Distância: ${posto.distanciaReferencia!} km',
                              style: const TextStyle(color: AppColors.onSurface)
                                  .labelMedium,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                )
              ],
            ),
            const H(16),
            Text(
              '${posto.enderecoCompleto?.replaceAll(' -', ',') ?? ''}\n${posto.nomeMunicipio?.toUpperCase() ?? ''}',
              style: const TextStyle(color: AppColors.onSurface).bodyLarge,
            )
          ],
        ),
      ),
    );
  }

  Widget estado(String label, String value) {
    return InkWell(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => const AtendimentoEstadoBottomSheet(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.surfaceContainerLowest)
                .labelLarge,
          ),
          const H(8),
          Container(
            width: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryShadow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.surfaceContainerLowest,
              ),
            ),
            child: Row(
              children: [
                Text(
                  value,
                  style:
                      const TextStyle(color: AppColors.surfaceContainerLowest)
                          .labelLarge,
                ),
                const Spacer(),
                const Icon(
                  Symbols.keyboard_arrow_down,
                  color: Color(0xFFF8FAFC),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget municipio(String label, String value) {
    return Expanded(
      child: InkWell(
        onTap: () =>
            _controller.atendimentoPresencialStream.value.estado == null
                ? NotificationService.negative('Selecione um estado')
                : showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) =>
                        const AtendimentoMunicipioBottomSheet(),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                    ),
                  ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.surfaceContainerLowest)
                  .labelLarge,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryShadow,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.surfaceContainerLowest,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                              color: AppColors.surfaceContainerLowest)
                          .labelLarge,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Symbols.keyboard_arrow_down,
                    color: Color(0xFFF8FAFC),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
