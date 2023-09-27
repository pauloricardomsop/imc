import 'package:svr/app/core/client/providers/portal_transparencia/models/bolsa_familia_backup_model.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:intl/intl.dart';

class BolsaFamilia {
  int draw = 0;
  int recordsTotal = 0;
  int recordsFiltered = 0;
  List<BolsaFamiliaData> data = [];
  String error = '';

  BolsaFamilia();

  BolsaFamilia.fromJson(Map<String, dynamic> json) {
    draw = json['draw'] ?? 0;
    recordsTotal = json['recordsTotal'] ?? 0;
    recordsFiltered = json['recordsFiltered'] ?? 0;
    if (json['data'] != null) {
      data = <BolsaFamiliaData>[];
      json['data'].forEach((v) {
        data.add(BolsaFamiliaData.fromJson(v));
      });
    }
    error = json['error'] ?? '';
  }

  BolsaFamilia.fromBackup(List<BolsaFamiliaBackup> backups) {
    backups
        .sort((a, b) => a.mesDisponibilizacao.compareTo(b.mesDisponibilizacao));
    recordsTotal = backups.length;
    data.addAll(backups.map((e) => BolsaFamiliaData.fromBackup(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['draw'] = draw;
    data['recordsTotal'] = recordsTotal;
    data['recordsFiltered'] = recordsFiltered;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    data['error'] = error;
    return data;
  }
}

class BolsaFamiliaData {
  String mesReferencia = '';
  String uf = '';
  String municipio = '';
  String beneficiario = '';
  String cpf = '';
  String nis = '';
  bool multiploCadastro = false;
  int skBeneficiarioNovoBolsaFamilia = 0;
  int skMunicipio = 0;
  String valorTotalPeriodo = '';
  bool menorDe16anos = false;
  String linkDetalhamento = '';

  DateTime get monthRefer => DateFormat('MM/yyyy').parse(mesReferencia);

  BolsaFamiliaData();

  BolsaFamiliaData.fromJson(Map<String, dynamic> json) {
    mesReferencia = json['mesReferencia'] ?? '';
    uf = json['uf'] ?? '';
    municipio = json['municipio'] ?? '';
    beneficiario = json['beneficiario'] ?? '';
    cpf = json['cpf'] ?? '';
    nis = json['nis'] ?? '';
    multiploCadastro = json['multiploCadastro'] ?? false;
    skBeneficiarioNovoBolsaFamilia =
        json['skBeneficiarioNovoBolsaFamilia'] ?? 0;
    skMunicipio = json['skMunicipio'] ?? 0;
    valorTotalPeriodo = json['valorTotalPeriodo'] ?? '';
    double? value = double.tryParse(
        json['valorTotalPeriodo'].toString().replaceAll(',', '.'));
    if (value == null || value < 600) {
      valorTotalPeriodo = '600,00';
    }
    menorDe16anos = json['menorDe16anos'] ?? false;
    linkDetalhamento = json['linkDetalhamento'] ?? '';
  }

  BolsaFamiliaData.fromBackup(BolsaFamiliaBackup backup) {
    mesReferencia = DateFormat('MM/yyyy').format(backup.mesDisponibilizacao);
    uf = '${backup.municipio.nomeIBGE}-${backup.municipio.uf.nome}';
    municipio = backup.municipio.nomeRegiao;
    beneficiario = backup.beneficiario.nome;
    cpf = backup.beneficiario.cpfFormatado;
    nis = backup.beneficiario.nis;
    if (backup.valor < 600) {
      valorTotalPeriodo = '600,00';
    } else {
      valorTotalPeriodo = toMoney(backup.valor);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mesReferencia'] = mesReferencia;
    data['uf'] = uf;
    data['municipio'] = municipio;
    data['beneficiario'] = beneficiario;
    data['cpf'] = cpf;
    data['nis'] = nis;
    data['multiploCadastro'] = multiploCadastro;
    data['skBeneficiarioNovoBolsaFamilia'] = skBeneficiarioNovoBolsaFamilia;
    data['skMunicipio'] = skMunicipio;
    data['valorTotalPeriodo'] = valorTotalPeriodo;
    data['menorDe16anos'] = menorDe16anos;
    data['linkDetalhamento'] = linkDetalhamento;
    return data;
  }
}
