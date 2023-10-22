import 'package:dio/dio.dart';
import 'package:request_manager/request_manager.dart';
import 'package:svr/app/core/client/valores_receber/models/valores_receber_captcha_model.dart';

class ValoresReceberProvider {
  static Future<ApiResponse<ValoresReceberCaptcha>> getCaptcha() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://valoresareceber.bcb.gov.br/publico/rest/captcha',
        options: Options(
          method: 'GET',
        ),
      );
      return ApiResponse.complete(
          ValoresReceberCaptcha.fromJson(response.data));
    } catch (e) {
      return ApiResponse.error(
          DioException(requestOptions: RequestOptions(), error: e.toString()));
    }
  }

  static Future<ApiResponse<bool>> getValoresReceberResultado(
      String identifier, String date, String hash, String captcha) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://valoresareceber.bcb.gov.br/publico/rest/valoresAReceber/$identifier/$date/$hash/$captcha',
        options: Options(
            method: 'GET',
            sendTimeout: const Duration(seconds: 8),
            receiveTimeout: const Duration(seconds: 8)),
      );
      return ApiResponse.complete(response.data['temValorAReceber'] as bool);
    } catch (e) {
      return ApiResponse.error(
          DioException(requestOptions: RequestOptions(), error: e.toString()));
    }
  }
}
