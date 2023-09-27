import 'package:svr/app/core/client/providers/dataprev/dataprev_provider.dart';
import 'package:svr/app/core/client/providers/dataprev/models/error_model.dart';
import 'package:svr/app/core/client/providers/dataprev/models/estado_model.dart';
import 'package:svr/app/core/client/providers/dataprev/models/municipio_model.dart';
import 'package:svr/app/core/client/providers/dataprev/models/posto_atendimento_model.dart';
import 'package:svr/app/core/models/api_response_model.dart';
import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/modules/atendimento/atendimento_presencial_model.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class AtendimentoPresencialController {
  static final AtendimentoPresencialController _instance =
      AtendimentoPresencialController._();

  AtendimentoPresencialController._();

  factory AtendimentoPresencialController() => _instance;

  AppStream<AtendimentoPresencialModel> atendimentoPresencialStream =
      AppStream<AtendimentoPresencialModel>();

  AppStreamResponse<List<EstadoModel>> estadosStream =
      AppStreamResponse<List<EstadoModel>>();
  AppStreamResponse<List<MunicipioModel>> municipioStream =
      AppStreamResponse<List<MunicipioModel>>();
  AppStreamResponse<List<PostoAtendimentoModel>> postosStream =
      AppStreamResponse<List<PostoAtendimentoModel>>();
  AppStreamResponse<List<ErrorModel>> errorStream =
      AppStreamResponse<List<ErrorModel>>();

  void init(BuildContext context) async {
    try {
      var value = FirebaseRemoteConfig.instance.getString('c_nas_versao');
      atendimentoPresencialStream
          .add(AtendimentoPresencialModel()..cNasVersao = value);
      debugPrint('debug cNasVersao: $value.');
    } catch (e) {
      debugPrint("debug Erro ao inicializar: $e");
    }
  }

  void fetchEstados(BuildContext context) async {
    try {
      ApiResponse<List<EstadoModel>>? response =
          await DataprevProvider.getEstados();
      estadosStream.add(response);
    } catch (e) {
      debugPrint('Erro ao buscar estados: $e');
    }
  }

  void fetchMunicipio(BuildContext context, String codigoUF) async {
    try {
      ApiResponse<List<MunicipioModel>>? response =
          await DataprevProvider.getMunicipios(codigoUF);
      municipioStream.add(response);
    } catch (e) {
      debugPrint('Erro ao buscar municipio: $e');
    }
  }

  void feachPostosAtendimento() async {
    try {
      String latidude = atendimentoPresencialStream.value.latitude ?? '0';
      String longetude = atendimentoPresencialStream.value.longitude ?? '0';
      String codigoMunicipioIbge =
          atendimentoPresencialStream.value.municipio!.codigoMunicipioIbge!;
      ApiResponse<List<PostoAtendimentoModel>>? response = (longetude == '0' ||
              latidude == '0' ||
              latidude.isEmpty ||
              longetude.isEmpty)
          ? await DataprevProvider.getPostosAtendimentosSemDistancia(
              codigoMunicipioIbge)
          : await DataprevProvider.getPostosAtendimentosComDistancia(
              atendimentoPresencialStream.value.municipio!.codigoMunicipioIbge!,
              latidude,
              longetude,
            );
      postosStream.add(response);
    } catch (e) {
      debugPrint('Erro ao buscar postos de atendimento: $e');
    }
  }

  void cleanPostosAtendimento() {
    postosStream
        .add(ApiResponse.complete(ApiResponse<List<PostoAtendimentoModel>>));
  }
}
