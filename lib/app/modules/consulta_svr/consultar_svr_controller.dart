import 'package:ad_manager/ad_manager.dart';
import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/core/client/valores_receber/models/valores_receber_captcha_model.dart';
import 'package:svr/app/core/client/valores_receber/valores_receber_provider.dart';
import 'package:svr/app/core/models/app_stream_response.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_svr/consultar_svr_model.dart';
import 'package:svr/app/modules/consulta_svr/ui/consultar_svr_captcha_bottom.dart';
import 'package:svr/app/modules/consulta_svr/ui/consultar_svr_disponiveis_page.dart';
import 'package:svr/app/modules/consulta_svr/ui/consultar_svr_error_page.dart';
import 'package:svr/app/modules/consulta_svr/ui/consultar_svr_indisponiveis_page.dart';
import 'package:validators/validators.dart';

class ConsultarSVRController {
  static final ConsultarSVRController _instance = ConsultarSVRController._();

  ConsultarSVRController._();

  factory ConsultarSVRController() => _instance;

  AppStreamResponse<ValoresReceberCaptcha> captchaResponseStream =
      AppStreamResponse<ValoresReceberCaptcha>();

  AppStream<ConsultarSVRModel> consultaValoresStream =
      AppStream<ConsultarSVRModel>();
  ConsultarSVRModel get consulta => consultaValoresStream.value;

  Future<void> onClickProximo(_) async {
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
        push(_, ConsultarSVRServicoIndisponivelPage());
        return;
      }

      AdManager.showRewarded(
          onDispose: () => push(
              _,
              result.data
                  ? ConsultarSVRDisponiveisPage()
                  : ConsultarSVRNaoEncontradoPage()));
    } catch (e) {
      NotificationService.negative(e.toString());
    }
  }

  Future<void> onClickTentarNovamente(_) async {
    try {
      final result = await showConsultaValoresCaptchaBottom(_);

      if (result == null || result.hasError) {
        Navigator.pop(_);
        return;
      }

      AdManager.showRewarded(onDispose: () {
        pops(_, 2);
        push(
            _,
            result.data
                ? ConsultarSVRDisponiveisPage()
                : ConsultarSVRNaoEncontradoPage());
      });
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
      // ignore: use_build_context_synchronously
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

      // if (resultado.hasError &&
      //     (resultado.error.error.toString().contains('412') ||
      //         resultado.error.error.toString().contains('404'))) {
      //   NotificationService.negative('Captcha Inválido, tente novamente.');
      //   fetchValoresReceberCaptcha();
      //   return;
      // }

      // ignore: use_build_context_synchronously
      Navigator.pop(context, resultado);
    } catch (_) {}
  }
}
