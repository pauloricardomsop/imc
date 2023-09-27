import 'package:svr/app/core/client/providers/dataprev/models/estado_model.dart';
import 'package:svr/app/core/client/providers/dataprev/models/municipio_model.dart';
import 'package:svr/app/core/client/providers/dataprev/models/posto_atendimento_model.dart';

class AtendimentoPresencialModel {
  String valueEstado = 'UF';
  String valueMunicipio = 'MUNÍCIPIO';
  String cNasVersao = '';
  String? latitude;
  String? longitude;
  EstadoModel? estado;
  MunicipioModel? municipio;
  List<PostoAtendimentoModel>? postosAtendimento = [];
}
