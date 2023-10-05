import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'package:svr/app/core/client/cpf_captcha/cpf_captcha_adapter.dart';
import 'package:svr/app/core/client/cpf_captcha/models/cpf_captcha_model.dart';
import 'package:svr/app/core/models/api_response_model.dart';

class CPFProvider {
  static Future<ApiResponse<CPFCaptchaModel>> getCaptcha() async {
    try {
      final header = {'User-Agent': Faker().internet.userAgent()};
      http.Response response = await http.get(
        Uri.parse(
            'https://servicos.receita.fazenda.gov.br/servicos/cpf/consultasituacao/ConsultaPublicaSonoro.asp?CPF=&NASCIMENTO='),
        headers: header,
      );
      log(response.headers.toString());
      return ApiResponse.complete(
          CPFCaptchaModel.fromJson(response.body.toString(), header, response.headers));
    } catch (e) {
      return ApiResponse.error(DioException(requestOptions: RequestOptions(), error: e.toString()));
    }
  }

  static Future<ApiResponse<String>> getSituacao(
      String cpf, String dataNascimento, String captcha) async {
    try {
      Map<String, String> headers = CPFCaptchaAdapter.lastHeader
        ..addAll({'Content-Type': 'application/x-www-form-urlencoded'});
      var data = {
        'idCheckedReCaptcha': 'false',
        'txtCPF': cpf,
        'txtDataNascimento': dataNascimento,
        'CPF': '',
        'NASCIMENTO': '',
        'txtTexto_captcha_serpro_gov_br': captcha,
        'Enviar': 'Consultar'
      };
      var response = await Dio().request(
        'https://servicos.receita.fazenda.gov.br/servicos/cpf/consultasituacao/ConsultaPublicaExibir.asp',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );
      log(response.headers.toString());
      log(response.data);
      if (response.statusCode != 200) throw Exception();
      return ApiResponse.complete(response.data);
    } catch (e) {
      log(e.toString());
      return ApiResponse.error(DioException(requestOptions: RequestOptions(), error: e.toString()));
    }
  }
}
