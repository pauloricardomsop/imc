import 'package:ad_manager/ad_manager.dart';
import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/core/client/valores_receber/models/valores_receber_captcha_model.dart';
import 'package:svr/app/core/client/valores_receber/valores_receber_provider.dart';
import 'package:svr/app/core/models/app_stream_response.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_valores_receber/consulta_valores_model.dart';
import 'package:svr/app/modules/consulta_valores_receber/ui/consulte_valores_disponiveis_page.dart';
import 'package:svr/app/modules/consulta_valores_receber/ui/consulte_valores_error_page.dart';
import 'package:svr/app/modules/consulta_valores_receber/ui/consulte_valores_captcha_bottom.dart';
import 'package:svr/app/modules/consulta_valores_receber/ui/consulte_valores_indisponiveis_page.dart';
import 'package:validators/validators.dart';

class ConsulteValoresController {
  static final ConsulteValoresController _instance = ConsulteValoresController._();

  ConsulteValoresController._();

  factory ConsulteValoresController() => _instance;

  AppStreamResponse<ValoresReceberCaptcha> captchaResponseStream = AppStreamResponse<ValoresReceberCaptcha>();

  AppStream<ConsulteValoresModel> consultaValoresStream = AppStream<ConsulteValoresModel>();
  
  ConsulteValoresModel get consulta => consultaValoresStream.value;

  Future<void> onClickIniciarConsulta(_) async {
    try {
      late bool isValidIdentifier;
      if (consulta.isPessoaFisica) {
        isValidIdentifier = CPFValidator.isValid(consulta.identifier.text);
      } else {
        isValidIdentifier = CNPJValidator.isValid(consulta.identifier.text);
      }
      if (!isValidIdentifier) {
        throw Exception('${consulta.isPessoaFisica ? 'CPF' : 'CNPJ'} inválido');
      }

      if (!isDate(consulta.dateFormatted)) throw Exception('Data inválida');

      FocusManager.instance.primaryFocus!.unfocus();

      final result = await showConsultaValoresCaptchaBottom(_);

      if (result == null) return;

      if (result.hasError) {
        push(_, ConsulteValoresErrorPage());
        return;
      }

      AdManager.showRewarded(
          onDispose: () => push(
              _,
              result.data
                  ? ConsulteSeusValoresDisponiveisPage()
                  : ConsulteSeusValoresIndisponiveisPage()));
    } catch (e) {
      NotificationService.negative(e.toString());
    }
  }

  Future<void> fetchValoresReceberCaptcha() async {
    captchaResponseStream.setLoading();
    try {
      consulta.captcha.clear();
      consultaValoresStream.update();

      final captcha = await ValoresReceberProvider.getCaptcha();

      if (captcha.hasError) throw Exception('Erro ao realizar consulta');

      captchaResponseStream.add(captcha);
    } catch (e) {
      Navigator.pop(contextGlobal);
      NotificationService.negative(e.toString());
    }
  }

  Future<void> onClickConsultarValores(BuildContext context) async {
    try {
      final resultado = await ValoresReceberProvider.getValoresReceberResultado(
        consulta.identifierUnmasked,
        consulta.dateFormatted,
        captchaResponseStream.value.hash!,
        consulta.captcha.text,
      );

      if (resultado.hasError &&
          (resultado.error.error.toString().contains('412') ||
              resultado.error.error.toString().contains('404'))) {
        NotificationService.negative('Captcha Inválido, tente novamente.');
        fetchValoresReceberCaptcha();
        return;
      }

      Navigator.pop(context, resultado);
    } catch (_) {}
  }
}
