import 'package:svr/app/core/client/providers/dataprev/models/estado_model.dart';
import 'package:svr/app/core/client/providers/dataprev/models/municipio_model.dart';
import 'package:svr/app/core/client/providers/dataprev/models/posto_atendimento_model.dart';
import 'package:svr/app/core/models/api_response_model.dart';
import 'package:svr/app/modules/atendimento/atendimento_presencial_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataprevProvider {
  static Future<ApiResponse<List<MunicipioModel>>> getMunicipios(
      String codigoMunicipio) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://api-sp.dataprev.gov.br/cadunico/1.0.0/v1/sdc/municipios/$codigoMunicipio',
        options: Options(
          method: 'GET',
          headers: {
            'CnasVersao': AtendimentoPresencialController()
                .atendimentoPresencialStream
                .value
                .cNasVersao,
          },
        ),
      );
      return ApiResponse.complete(MunicipioModel.fromJsonList(response.data));
    } catch (e) {
      return ApiResponse.error(
          DioException(requestOptions: RequestOptions(), error: e.toString()));
    }
  }

  static Future<ApiResponse<List<EstadoModel>>> getEstados() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://api-sp.dataprev.gov.br/cadunico/1.0.0/v1/sdc/ufs',
        options: Options(
          method: 'GET',
          headers: {
            'CnasVersao': AtendimentoPresencialController()
                .atendimentoPresencialStream
                .value
                .cNasVersao
          },
        ),
      );
      return ApiResponse.complete(EstadoModel.fromJsonList(response.data));
    } catch (e) {
      return ApiResponse.error(
          DioException(requestOptions: RequestOptions(), error: e.toString()));
    }
  }

  static Future<ApiResponse<List<PostoAtendimentoModel>>>
      getPostosAtendimentosSemDistancia(String codigoMunicipio) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://api-sp.dataprev.gov.br/cadunico/1.0.0/v1/posto-atendimento/municipio/$codigoMunicipio',
        options: Options(
          method: 'GET',
          headers: {
            'CnasVersao': AtendimentoPresencialController()
                .atendimentoPresencialStream
                .value
                .cNasVersao,
          },
        ),
      );
      debugPrint('debug response: ${response.data}');
      return ApiResponse.complete(
          PostoAtendimentoModel.fromJsonList(response.data));
    } catch (e) {
      return ApiResponse.error(
          DioException(requestOptions: RequestOptions(), error: e.toString()));
    }
  }

  static Future<ApiResponse<List<PostoAtendimentoModel>>>
      getPostosAtendimentosComDistancia(
    String codigoMunicipio,
    String latidute,
    String longitude,
  ) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://api-sp.dataprev.gov.br/cadunico/1.0.0/v1/posto-atendimento/municipio/$codigoMunicipio?latitudeReferencia=$latidute&longitudeReferencia=$longitude&tipoOrdenacao=DISTANCIA',
        options: Options(
          method: 'GET',
          headers: {
            'CnasVersao': AtendimentoPresencialController()
                .atendimentoPresencialStream
                .value
                .cNasVersao,
          },
        ),
      );
      return ApiResponse.complete(
          PostoAtendimentoModel.fromJsonList(response.data));
    } catch (e) {
      return ApiResponse.error(
          DioException(requestOptions: RequestOptions(), error: e.toString()));
    }
  }
}
