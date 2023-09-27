import 'package:svr/app/core/client/api_constanst.dart';
import 'package:svr/app/core/client/providers/portal_transparencia/models/bolsa_familia.dart';
import 'package:svr/app/core/client/providers/portal_transparencia/models/bolsa_familia_backup_model.dart';
import 'package:svr/app/core/models/api_response_model.dart';
import 'package:dio/dio.dart';

class PortalTransparenciaProvider {
  static List<String> userAgents = [
    'Mozilla/5.0 (iPad; CPU iPad OS 10_6_1 like Mac OS X) AppleWebKit/534.24 (KHTML, like Gecko)  Chrome/55.0.3886.110 Mobile Safari/537.3',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 11_6_0; like Mac OS X) AppleWebKit/533.31 (KHTML, like Gecko)  Chrome/50.0.2167.232 Mobile Safari/602.3',
    'Mozilla/5.0 (U; Linux x86_64) AppleWebKit/603.20 (KHTML, like Gecko) Chrome/52.0.1165.267 Safari/600',
    'Mozilla/5.0 (Windows; U; Windows NT 6.1; Win64; x64; en-US) AppleWebKit/537.47 (KHTML, like Gecko) Chrome/47.0.2918.345 Safari/534',
    'Mozilla/5.0 (Linux; U; Linux x86_64; en-US) Gecko/20130401 Firefox/54.6',
    'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_3_3; en-US) Gecko/20100101 Firefox/49.0',
    'Mozilla/5.0 (Linux; Linux x86_64; en-US) Gecko/20100101 Firefox/63.5',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 7_3_3; en-US) Gecko/20130401 Firefox/55.1',
    'Mozilla/5.0 (Windows; Windows NT 10.0; x64; en-US) AppleWebKit/535.4 (KHTML, like Gecko) Chrome/50.0.1538.374 Safari/600',
    'Mozilla/5.0 (Windows; Windows NT 10.5;) AppleWebKit/603.33 (KHTML, like Gecko) Chrome/52.0.3734.329 Safari/600.6 Edge/10.21710',
  ];

  static Future<ApiResponse<BolsaFamilia>> getNis(
      String cpfNisBeneficiario) async {
    for (var userAgent in userAgents.toList()..shuffle()) {
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://portaldatransparencia.gov.br/beneficios/bolsa-familia/resultado?paginacaoSimples=True&tamanhoPagina=15&offset=0&direcaoOrdenacao=asc&colunaOrdenacao=beneficiario&de=01/01/2019&ate=31/12/2019&cpfNisBeneficiario=$cpfNisBeneficiario&colunasSelecionadas=linkDetalhamento,mesReferencia,uf,municipio,nis,beneficiario,valorTotalPeriodo',
          options: Options(method: 'GET', headers: {'User-Agent': userAgent}),
        );
        if (response.statusCode == 200) {
          return ApiResponse.complete(BolsaFamilia.fromJson(response.data));
        }
      } catch (_) {}
    }
    return fetchConsultaBackup(cpfNisBeneficiario);
  }

  static Future<ApiResponse<BolsaFamilia>> getBolsaFamilia(
      String cpfNisBeneficiario) async {
    for (var userAgent in userAgents.toList()..shuffle()) {
      try {
        var dio = Dio();
        var response = await dio.request(
          'https://portaldatransparencia.gov.br/beneficios/novo-bolsa-familia/resultado?paginacaoSimples=True&tamanhoPagina=15&offset=0&direcaoOrdenacao=asc&colunaOrdenacao=beneficiario&de=01/03/2023&ate=01/03/2024&cpfNisBeneficiario=$cpfNisBeneficiario&colunasSelecionadas=linkDetalhamento,mesReferencia,uf,municipio,nis,beneficiario,valorTotalPeriodo',
          options: Options(method: 'GET', headers: {'User-Agent': userAgent}),
        );
        if (response.statusCode == 200) {
          return ApiResponse.complete(BolsaFamilia.fromJson(response.data));
        }
      } catch (_) {}
    }
    return fetchConsultaBackup(cpfNisBeneficiario);
  }

  static Future<ApiResponse<BolsaFamilia>> fetchConsultaBackup(
      String cpfNisBeneficiario) async {
    final List<String> keys = ApiConstants.govApiKeys.toList()..shuffle();
    for (String key in keys) {
      final response = await getConsultaBackup(key, cpfNisBeneficiario);
      if (response.hasData) return response;
      if (key == keys.last) return response;
    }
    return ApiResponse.error(DioException(
        requestOptions: RequestOptions(),
        error: 'Não há dados disponíveis'.toString()));
  }

  static Future<ApiResponse<BolsaFamilia>> getConsultaBackup(
      String key, String codigoBeneficiario) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://api.portaldatransparencia.gov.br/api-de-dados/auxilio-emergencial-por-cpf-ou-nis?codigoBeneficiario=$codigoBeneficiario&pagina=1',
        options: Options(
            method: 'GET',
            headers: {"chave-api-dados": key},
            sendTimeout: const Duration(seconds: 20)),
      );
      var apiResponse = ApiResponse.complete(BolsaFamilia.fromBackup(response
          .data
          .map<BolsaFamiliaBackup>((e) => BolsaFamiliaBackup.fromJson(e))
          .toList()));
      return apiResponse;
    } catch (e) {
      return ApiResponse.error(
          DioException(requestOptions: RequestOptions(), error: e.toString()));
    }
  }
}
