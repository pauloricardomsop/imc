import 'package:intl/intl.dart';

class BolsaFamiliaBackup {
  int id = 0;
  late DateTime mesDisponibilizacao;
  Beneficiario beneficiario = Beneficiario();
  ResponsavelAuxilioEmergencial responsavelAuxilioEmergencial = ResponsavelAuxilioEmergencial();
  Municipio municipio = Municipio();
  String situacaoAuxilioEmergencial = '';
  String enquadramentoAuxilioEmergencial = '';
  double valor = 0.0;
  String numeroParcela = '';

  BolsaFamiliaBackup();

  BolsaFamiliaBackup.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    mesDisponibilizacao = DateFormat('MM/yyyy').parse(json['mesDisponibilizacao']);
    beneficiario =
        json['beneficiario'] != null ? Beneficiario.fromJson(json['beneficiario']) : Beneficiario();
    responsavelAuxilioEmergencial = json['responsavelAuxilioEmergencial'] != null
        ? ResponsavelAuxilioEmergencial.fromJson(json['responsavelAuxilioEmergencial'])
        : ResponsavelAuxilioEmergencial();
    municipio = json['municipio'] != null ? Municipio.fromJson(json['municipio']) : Municipio();
    situacaoAuxilioEmergencial = json['situacaoAuxilioEmergencial'] ?? '';
    enquadramentoAuxilioEmergencial = json['enquadramentoAuxilioEmergencial'] ?? '';
    valor = json['valor'] ?? 0;
    numeroParcela = json['numeroParcela'] ?? '';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'mesDisponibilizacao': mesDisponibilizacao,
        'beneficiario': beneficiario.toJson(),
        'responsavelAuxilioEmergencial': responsavelAuxilioEmergencial.toJson(),
        'municipio': municipio.toJson(),
        'situacaoAuxilioEmergencial': situacaoAuxilioEmergencial,
        'enquadramentoAuxilioEmergencial': enquadramentoAuxilioEmergencial,
        'valor': valor,
        'numeroParcela': numeroParcela
      };
}

class Municipio {
  String codigoIBGE = '';
  String nomeIBGE = '';
  String codigoRegiao = '';
  String nomeRegiao = '';
  String pais = '';
  Uf uf = Uf();

  Municipio();

  Municipio.fromJson(Map<String, dynamic> json) {
    codigoIBGE = json['codigoIBGE'] ?? '';
    nomeIBGE = json['nomeIBGE'] ?? '';
    codigoRegiao = json['codigoRegiao'] ?? '';
    nomeRegiao = json['nomeRegiao'] ?? '';
    pais = json['pais'] ?? '';
    uf = json['uf'] != null ? Uf.fromJson(json['uf']) : Uf();
  }

  Map<String, dynamic> toJson() => {
        'codigoIBGE': codigoIBGE,
        'nomeIBGE': nomeIBGE,
        'codigoRegiao': codigoRegiao,
        'nomeRegiao': nomeRegiao,
        'pais': pais,
        'uf': uf.toJson()
      };
}

class Uf {
  String sigla = '';
  String nome = '';

  Uf();

  Uf.fromJson(Map<String, dynamic> json) {
    sigla = json['sigla'] ?? '';
    nome = json['nome'] ?? '';
  }

  Map<String, dynamic> toJson() => {'sigla': sigla, 'nome': nome};
}

class ResponsavelAuxilioEmergencial {
  String cpfFormatado = '';
  String nis = '';
  String nome = '';

  ResponsavelAuxilioEmergencial();

  ResponsavelAuxilioEmergencial.fromJson(Map<String, dynamic> json) {
    cpfFormatado = json['cpfFormatado'] ?? '';
    nis = json['nis'] ?? '';
    nome = json['nome'] ?? '';
  }

  Map<String, dynamic> toJson() => {'cpfFormatado': cpfFormatado, 'nis': nis, 'nome': nome};
}

class Beneficiario {
  String cpfFormatado = '';
  String nis = '';
  String nome = '';

  Beneficiario();

  Beneficiario.fromJson(Map<String, dynamic> json) {
    cpfFormatado = json['cpfFormatado'] ?? '';
    nis = json['nis'] ?? '';
    nome = json['nome'] ?? '';
  }

  Map<String, dynamic> toJson() => {'cpfFormatado': cpfFormatado, 'nis': nis, 'nome': nome};
}
