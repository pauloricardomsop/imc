import 'package:svr/app/core/client/providers/portal_transparencia/models/bolsa_familia.dart';
import 'package:svr/app/core/client/providers/portal_transparencia/portal_transparencia_provider.dart';
import 'package:svr/app/core/models/app_stream.dart';

class ExtratoController {
  static final ExtratoController _instance = ExtratoController._();

  ExtratoController._();

  factory ExtratoController() => _instance;

  AppStreamResponse<BolsaFamilia> bolsaFamiliaResponse =
      AppStreamResponse<BolsaFamilia>();

  Future<void> fecthBolsaFamilia(String nis) async {
    final response = await PortalTransparenciaProvider.getBolsaFamilia(nis);
    bolsaFamiliaResponse.add(response);
  }
}
