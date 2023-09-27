// ignore_for_file: use_build_context_synchronously

import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/client/providers/portal_transparencia/portal_transparencia_provider.dart';
import 'package:svr/app/core/models/api_response_model.dart';
import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_nis/consulta_nis_model.dart';
import 'package:svr/app/modules/consulta_nis/ui/consulta/consulta_nis_nao_encontrado_page.dart';
import 'package:svr/app/modules/consulta_nis/ui/consulta/consulta_nis_success_page.dart';
import 'package:svr/app/modules/home/home_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

import '../../core/client/providers/portal_transparencia/models/bolsa_familia.dart';

class ConsultaNisController {
  static final ConsultaNisController _instance = ConsultaNisController._();

  ConsultaNisController._();

  factory ConsultaNisController() => _instance;

  AppStream<ConsultaNisModel> consultaNistream = AppStream<ConsultaNisModel>();
  ConsultaNisModel get consultaPagamento => consultaNistream.value;

  Future<void> init() async {
    consultaNistream.add(ConsultaNisModel());
  }

  // 683.136.246-04
  void onClickConsultar(BuildContext context) async {
    if (consultaNistream.value.cpf.text.length != 14) {
      NotificationService.negative('CPF inválido!');
      return;
    }
    ApiResponse<BolsaFamilia> response =
        await PortalTransparenciaProvider.getNis(consultaPagamento.nisReplaced);
    if (response.hasError) {
      AdManager.showIntersticial(context,
          onDispose: () => push(
              context,
              ServiceIndisponivelPage(
                home: HomePage(),
                onTryAgain: () => onClickConsultar(context),
              )));
      return;
    }

    String nome = '';
    String nis = '';

    for (var data in response.data.data) {
      nome = data.beneficiario;
      nis = data.nis;
    }

    AdManager.showRewarded(
        onDispose: () => push(
            context,
            nis.isNotEmpty
                ? ConsultaNisSuccessPage(nome, nis)
                : ConsultaNisNaoEncontradoPage()));
  }
}
