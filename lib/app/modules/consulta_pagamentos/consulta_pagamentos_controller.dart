// ignore_for_file: use_build_context_synchronously

import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/client/providers/portal_transparencia/models/bolsa_familia.dart';
import 'package:svr/app/core/client/providers/portal_transparencia/portal_transparencia_provider.dart';
import 'package:svr/app/core/models/api_response_model.dart';
import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_model.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_repository.dart';
import 'package:svr/app/modules/consulta_pagamentos/ui/consulta_pagamentos_nao_encontrado_page.dart';
import 'package:svr/app/modules/consulta_pagamentos/ui/consulta_pagamentos_success_page.dart';
import 'package:svr/app/modules/home/home_page.dart';
import 'package:svr/app/modules/solucionando_divergencias/solucionando_divergencias_model.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class ConsultaPagamentosController {
  static final ConsultaPagamentosController _instance =
      ConsultaPagamentosController._();

  ConsultaPagamentosController._();

  factory ConsultaPagamentosController() => _instance;

  AppStream<ConsultaPagamentosModel> consultaPagamentoStream =
      AppStream<ConsultaPagamentosModel>();
  ConsultaPagamentosModel get consultaPagamento =>
      consultaPagamentoStream.value;

  AppStreamResponse<BolsaFamilia> bolsaFamiliaStream =
      AppStreamResponse<BolsaFamilia>();

  Future<void> init() async {
    var value = ConsultaPagamentosModel()
      ..bolsaFamilia =
          await ConsultaPagamentosRepository.getBolsaFamiliaViewModel();
    consultaPagamentoStream.add(value);
  }

  void onClickConsultar(BuildContext context) async {
    if (consultaPagamentoStream.value.nis.text.length != 15) {
      NotificationService.negative('NIS inválido!');
      return;
    }
    // 23756470551
    ApiResponse<BolsaFamilia> response =
        await PortalTransparenciaProvider.getBolsaFamilia(
            consultaPagamento.nisReplaced);
    if (response.hasError) {
      push(
          context,
          ServiceIndisponivelPage(
            home: HomePage(),
            onTryAgain: () => onClickConsultar(context),
          ));
      return;
    }
    if (response.data.data.isEmpty) {
      AdManager.showRewarded(
          onDispose: () => push(context, ConsultaPagamentoNaoEncontradoPage()));
      return;
    }

    bolsaFamiliaStream.add(response);
    saveBolsaFamiliaResult();

    AdManager.showRewarded(
        onDispose: () =>
            push(context, ConsultaPagamentosSuccessPage(response.data)));
  }

  void onClickDeleteBolsaFamiliaViewModel() {
    consultaPagamento.bolsaFamilia = null;
    ConsultaPagamentosRepository.setBolsaFamiliaViewModel(null);
    consultaPagamentoStream.update();
  }

  void saveBolsaFamiliaResult() {
    if (!bolsaFamiliaStream.hasValidData) return;
    consultaPagamento.bolsaFamilia =
        BolsaFamiliaViewModel.fromRequest(bolsaFamiliaStream.value);
    ConsultaPagamentosRepository.setBolsaFamiliaViewModel(
        consultaPagamento.bolsaFamilia!);
    consultaPagamentoStream.update();
  }

  void removeBolsaFamiliaResult() {
    consultaPagamento.bolsaFamilia = null;
    ConsultaPagamentosRepository.setBolsaFamiliaViewModel(null);
    consultaPagamentoStream.update();
  }

  void updateBolsaFamiliaFromSolucionandoDivergencias(
      SolucionandoDivergenciasQuiz quiz) {
    consultaPagamento.bolsaFamilia =
        BolsaFamiliaViewModel.fromRequest(bolsaFamiliaStream.value);
    consultaPagamento.bolsaFamilia?.valor = toMoney(quiz.totalBolsaFamilia);
    ConsultaPagamentosRepository.setBolsaFamiliaViewModel(
        consultaPagamento.bolsaFamilia!);
    consultaPagamentoStream.update();
  }
}
