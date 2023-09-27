import 'package:svr/app/core/services/shared_preferences_service.dart';
import 'package:svr/app/modules/consulta_pagamentos/consulta_pagamentos_model.dart';

class ConsultaPagamentosRepository {
  static const String key = 'bolsa_familia_view_model';

  static Future<BolsaFamiliaViewModel?> getBolsaFamiliaViewModel() async {
    final json = SharedPreferencesService.getString(key);
    if (json == null || json.isEmpty) return null;

    return BolsaFamiliaViewModel.fromJson(json);
  }

  static Future<void> setBolsaFamiliaViewModel(
      BolsaFamiliaViewModel? bolsaFamilia) async {
    await SharedPreferencesService.setString(key, bolsaFamilia?.toJson() ?? '');
  }
}
