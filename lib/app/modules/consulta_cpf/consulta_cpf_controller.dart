import 'package:ad_manager/ad_manager.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/core/client/cpf_captcha/cpf_captcha_adapter.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_cpf/consulta_cpf_model.dart';
import 'package:svr/app/modules/consulta_cpf/ui/consulta_cpf_captcha_bottom.dart';
import 'package:svr/app/modules/consulta_cpf/ui/consulta_cpf_data_invalida_page.dart';
import 'package:svr/app/modules/consulta_cpf/ui/consulta_cpf_network_error_page.dart';
import 'package:svr/app/modules/consulta_cpf/ui/consulta_cpf_success_page.dart';
import 'package:validators/validators.dart';

class ConsultaCPFController {
  static final ConsultaCPFController _instance = ConsultaCPFController._();

  ConsultaCPFController._();

  factory ConsultaCPFController() => _instance;

  final CPFCaptchaAdapter cpfAdapter = CPFCaptchaAdapter();

  AppStream<ConsultaCPFModel> consultaStream =
      AppStream<ConsultaCPFModel>.seed(ConsultaCPFModel());
  ConsultaCPFModel get consulta => consultaStream.value;

  void init() {
    getCaptcha();
  }

  Future<void> getCaptcha() async {
    await cpfAdapter.getCaptcha();
    consulta.captchaEC.clear();
    consultaStream.update();
  }

  Future<void> onClickProximo(_) async {
    try {
      if (!CPFValidator.isValid(consulta.cpfEC.text)) {
        consulta.cpfFC.requestFocus();
        throw Exception('CPF inválido');
      }

      if (!isDate(consulta.dateFormatted)) {
        consulta.dataNascimentoFC.requestFocus();
        throw Exception('Data inválida');
      }
      FocusScope.of(_).unfocus();
      final responseSituacao = await showConsultaCPFCaptchaBottom(_);
      if (responseSituacao == null) return;
      if (responseSituacao.hasError) {
        push(_, ConsultaCPFNetworkErrorPage());
        return;
      }
      AdManager.showRewarded(
          onDispose: () =>
              push(_, ConsultaCPFSuccessPage(responseSituacao.data)));
      getCaptcha();
    } catch (e) {
      NotificationService.negative(e.toString());
    }
  }

  Future<void> onClickConsultar(_) async {
    final situacaoResponse = await cpfAdapter.getSituacao(consulta.cpfEC.text,
        consulta.dataNascimentoEC.text, consultaStream.value.captchaEC.text);
    // final situacaoResponse = await cpfAdapter.getSituacao(
    //     '057.693.353-86', '15/06/1993', consultaStream.value.captchaEC.text);
    if (situacaoResponse.hasError && !situacaoResponse.isDioException) {
      if (situacaoResponse.error
          .toString()
          .contains('Data de Nascimento Incorreta')) {
        await getCaptcha();
        Navigator.pop(_);
        await push(_, ConsultaCPFDataInvalidaPage());
        consulta.dataNascimentoFC.requestFocus();
        return;
      }
      NotificationService.negative(situacaoResponse.error.toString());
    }
    Navigator.pop(_, situacaoResponse);
  }
}
