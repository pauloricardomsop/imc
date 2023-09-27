import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/client/providers/dataprev/models/estado_model.dart';
import 'package:svr/app/core/client/providers/dataprev/models/municipio_model.dart';
import 'package:svr/app/core/client/providers/dataprev/models/posto_atendimento_model.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/models/api_response_model.dart';
import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/modules/atendimento/atendimento_presencial_controller.dart';
import 'package:svr/app/modules/atendimento/atendimento_presencial_model.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class AtendimentoEstadoBottomSheet extends StatefulWidget {
  const AtendimentoEstadoBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AtendimentoEstadoBottomSheet> createState() => _SheetEstadosPage();
}

class _SheetEstadosPage extends State<AtendimentoEstadoBottomSheet> {
  final AtendimentoPresencialController _controller =
      AtendimentoPresencialController();

  @override
  void initState() {
    _controller.fetchEstados(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: StreamOut<AtendimentoPresencialModel>(
          stream: _controller.atendimentoPresencialStream.listen,
          child: (contexto, model) => body(context, model),
        ),
      ),
    );
  }

  Widget body(BuildContext context, AtendimentoPresencialModel model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTitle('Selecione o estado', color: AppColors.onSurface),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: StreamOutResponse<ApiResponse<List<EstadoModel>>,
                    List<EstadoModel>>(
                loading: const AppShimmer(
                    child: SizedBox(
                  height: 80,
                  width: 100,
                )),
                stream: _controller.estadosStream.listen,
                child: (context, estados) => ListView.separated(
                      shrinkWrap: true,
                      itemCount: estados.length,
                      itemBuilder: (context, index) =>
                          itemEstadoWidget(estados[index]),
                      separatorBuilder: (context, index) =>
                          const Divisor(color: AppColors.surfaceContainer),
                    )),
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'SELECIONAR CIDADE',
            onTap: () {
              Navigator.pop(context);
            },
            icon: Symbols.trending_flat,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget itemEstadoWidget(EstadoModel estado) {
    return InkWell(
      onTap: () {
        _controller.atendimentoPresencialStream.value.estado = estado;
        _controller.atendimentoPresencialStream.value.municipio = null;
        _controller.municipioStream = AppStreamResponse<List<MunicipioModel>>();
        _controller.postosStream =
            AppStreamResponse<List<PostoAtendimentoModel>>();
        _controller.atendimentoPresencialStream.update();
      },
      child: Container(
        width: 320,
        height: 56,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              _controller.atendimentoPresencialStream.value.estado == estado
                  ? Symbols.check_circle_rounded
                  : Symbols.circle,
              color:
                  _controller.atendimentoPresencialStream.value.estado == estado
                      ? AppColors.primary
                      : AppColors.surfaceContainerHighest,
              size: 32,
              fill:
                  _controller.atendimentoPresencialStream.value.estado == estado
                      ? 1
                      : 0,
            ),
            const SizedBox(width: 12),
            SizedBox(
              child: Text(
                '${estado.siglaUf} - ${estado.nomeUf}',
                style: const TextStyle(color: AppColors.onSurface).bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
