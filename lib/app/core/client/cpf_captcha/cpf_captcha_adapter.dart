import 'dart:convert';
import 'dart:typed_data';

import 'package:html/parser.dart';
import 'package:log_manager/log_manager.dart';
import 'package:svr/app/core/client/cpf_captcha/cpf_captcha_provider.dart';
import 'package:svr/app/core/client/cpf_captcha/models/cpf_captcha_situacao_model.dart';
import 'package:svr/app/core/models/api_response_model.dart';
import 'package:svr/app/core/models/app_stream_response.dart';

class CPFCaptchaAdapter {
  static late Map<String, String> lastHeader;

  AppStreamResponse<Uint8List> captchaResponse =
      AppStreamResponse<Uint8List>.seeded(ApiResponse.loading());

  Future<void> getCaptcha() async {
    captchaResponse.add(ApiResponse<Uint8List>.loading());
    captchaResponse.add(await _getCaptcha());
  }

  Future<ApiResponse<Uint8List>> _getCaptcha() async {
    try {
      final response = await CPFProvider.getCaptcha();
      if (response.hasError) return ApiResponse.error(response.error);
      if (!response.data.html.contains('imgCaptcha')) return _getCaptcha();
      final document = parse(response.data.html);
      final element = document.getElementById("imgCaptcha");
      if (element == null) {
        ApiResponse.error(Exception('Erro ao realizar conversão'));
      }
      final src = element!.attributes['src'];
      if (src == null) {
        ApiResponse.error(Exception('Erro ao realizar conversão'));
      }
      final image = src!.split(',').last;
      final bytes = base64Decode(image);
      final result = ApiResponse.complete(bytes);
      lastHeader = response.data.headers;
      return result;
    } catch (_) {
      return ApiResponse.error(Exception('Erro ao realizar conversão'));
    }
  }

  AppStreamResponse<CPFCaptchaSituacaoModel> situacaoResponse =
      AppStreamResponse<CPFCaptchaSituacaoModel>();

  Future<ApiResponse<CPFCaptchaSituacaoModel>> getSituacao(
      String cpf, String dataNascimento, String captcha) async {
    final value = await _getSituacao(cpf, dataNascimento, captcha);
    situacaoResponse.add(value);
    return value;
  }

  Future<ApiResponse<CPFCaptchaSituacaoModel>> _getSituacao(
      String cpf, String dataNascimento, String captcha) async {
    try {
      final response =
          await CPFProvider.getSituacao(cpf, dataNascimento, captcha);
      if (response.hasError) return ApiResponse.error(response.error);

      if (response.data
          .contains("Data de nascimento informada  est&aacute; divergente")) {
        return ApiResponse.error(Exception('Data de Nascimento Incorreta'));
      }
      if (response.data
          .contains("foi realizada corretamente. Por favor, tente novamente")) {
        return ApiResponse.error(Exception('Captcha incorreto'));
      }
      if (response.data.contains("expirou")) {
        await getCaptcha();
        return ApiResponse.error(
            Exception('Captcha expirado, tente novamente'));
      }
      if (response.data.contains(
          "Os caracteres da imagem n�o foram preenchidos corretamente. Por favor, envie novamente.")) {
        await getCaptcha();
        return ApiResponse.error(
            Exception('Captcha inválido, tente novamente'));
      }

      final document = parse(response.data);
      final clConteudoDados =
          document.getElementsByClassName('clConteudoDados');
      final clConteudoComp = document.getElementsByClassName('clConteudoComp');
      LogManager.instance
          .event('consulta_cpf', params: {'html': response.data});
      final model = CPFCaptchaSituacaoModel(
        cpf: clConteudoDados[0].text.split('No do CPF: ').last,
        nome: clConteudoDados[1].text.split('Nome: ').last,
        dataNascimento:
            clConteudoDados[2].text.split('Data de Nascimento: ').last,
        situacaoCadastral:
            clConteudoDados[3].text.split('Situação Cadastral: ').last,
        dataInscricao:
            clConteudoDados[4].text.split('Data da Inscrição: ').last,
        digitoVerificador:
            clConteudoDados[5].text.split('Digito Verificador: ').last,
        comprovanteEmitido:
            clConteudoComp[0].text.split('Comprovante emitido às: ').last,
        codigoControleComprovante: clConteudoComp[1]
            .text
            .split('Código de controle do comprovante: ')
            .last,
      );
      return ApiResponse.complete(model);
    } catch (_) {
      await getCaptcha();
      return ApiResponse.error(Exception('Erro ao realizar conversão'));
    }
  }
}
