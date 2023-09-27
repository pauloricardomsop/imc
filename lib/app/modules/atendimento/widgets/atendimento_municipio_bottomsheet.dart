import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/client/providers/dataprev/models/municipio_model.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/models/api_response_model.dart';
import 'package:svr/app/modules/atendimento/atendimento_presencial_controller.dart';
import 'package:svr/app/modules/atendimento/atendimento_presencial_model.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:material_symbols_icons/symbols.dart';

class AtendimentoMunicipioBottomSheet extends StatefulWidget {
  const AtendimentoMunicipioBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AtendimentoMunicipioBottomSheet> createState() =>
      _AtendimentoMunicipioBottomSheet();
}

class _AtendimentoMunicipioBottomSheet
    extends State<AtendimentoMunicipioBottomSheet> {
  final AtendimentoPresencialController _controller =
      AtendimentoPresencialController();
  Location location = Location();
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  LocationData? locationData;

  @override
  void initState() {
    _controller.fetchMunicipio(
        context,
        _controller.atendimentoPresencialStream.value.estado!.codigoUfIbge ??
            '0');
    super.initState();
    getLocation();
  }

  getLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await location.getLocation();
    setlocation();
  }

  void setlocation() {
    _controller.atendimentoPresencialStream.value.latitude =
        locationData!.latitude.toString();
    _controller.atendimentoPresencialStream.value.longitude =
        locationData!.longitude.toString();
    _controller.atendimentoPresencialStream.update();
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
              AppTitle('Selecione sua cidade', color: AppColors.onSurface),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: StreamOutResponse<ApiResponse<List<MunicipioModel>>,
                    List<MunicipioModel>>(
                loading: const AppShimmer(
                    child: SizedBox(
                  height: 80,
                  width: 100,
                )),
                stream: _controller.municipioStream.listen,
                child: (context, municipio) => ListView.separated(
                      shrinkWrap: true,
                      itemCount: municipio.length,
                      itemBuilder: (context, index) =>
                          itemMunicipioWidget(municipio[index]),
                      separatorBuilder: (context, index) =>
                          const Divisor(color: AppColors.surfaceContainer),
                    )),
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'BUSCAR ATENDIMENTO',
            onTap: () {
              _controller.feachPostosAtendimento();
              Navigator.pop(context);
            },
            icon: Symbols.travel_explore,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget itemMunicipioWidget(MunicipioModel municipio) {
    var controller = _controller.atendimentoPresencialStream;
    return InkWell(
      onTap: () {
        controller.value.municipio = municipio;
        controller.update();
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
              controller.value.municipio == municipio
                  ? Symbols.check_circle
                  : Symbols.circle,
              color: controller.value.municipio == municipio
                  ? AppColors.primary
                  : AppColors.surfaceContainerHighest,
              size: 32,
              fill: controller.value.municipio == municipio ? 1 : 0,
            ),
            const SizedBox(width: 12),
            SizedBox(
              child: Text(
                municipio.nomeMunicipio ?? '',
                style: const TextStyle(color: AppColors.onSurface).bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
