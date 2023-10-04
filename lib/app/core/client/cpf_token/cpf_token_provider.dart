import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:svr/app/core/client/cpf_token/models/cpf_token.dart';
import 'package:svr/app/core/models/api_response_model.dart';

class CPFTokenProvider {
  static Future<ApiResponse<CPFToken>> postToken(Map<String, dynamic> body) async {
    try {
      var dio = Dio();
      var response =
          await dio.post('https://movel01.receita.fazenda.gov.br/servicos-rfb/v2/Util/obterToken',
              options: Options(
                headers: {
                  'Accept-Encoding': 'gzip',
                  'Content-Type': 'application/json',
                },
              ),
              data: jsonEncode(body));
      return ApiResponse.complete(CPFToken.fromJson(response.data));
    } catch (e) {
      return ApiResponse.error(DioException(requestOptions: RequestOptions(), error: e.toString()));
    }
  }

  static Future<ApiResponse<CPFToken>> postRecupararMensagens(Map<String, dynamic> body) async {
    try {
      var dio = Dio();
      var response = await dio.post(
        'https://movel02.receita.fazenda.gov.br/servicos-rfb/v2/EnviarMensagemNuvem/recuperarMensagens',
        data: jsonEncode(body),
      );
      return ApiResponse.complete(CPFToken.fromJson(response.data));
    } catch (e) {
      return ApiResponse.error(DioException(requestOptions: RequestOptions(), error: e.toString()));
    }
  }

  static Future<ApiResponse<CPFToken>> postConsultar(Map<String, dynamic> body) async {
    try {
      var dio = Dio();
      var response = await dio.post(
        'https://movel02.receita.fazenda.gov.br/servicos-rfb/v2/IRPF/cpf/consultar',
        data: jsonEncode(body),
      );
      return ApiResponse.complete(CPFToken.fromJson(response.data));
    } catch (e) {
      return ApiResponse.error(DioException(requestOptions: RequestOptions(), error: e.toString()));
    }
  }
}
