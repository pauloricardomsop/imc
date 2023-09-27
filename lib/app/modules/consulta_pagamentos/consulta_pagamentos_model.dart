// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:svr/app/core/client/providers/portal_transparencia/models/bolsa_familia.dart';
import 'package:svr/app/core/utils/extensions.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class ConsultaPagamentosModel {
  TextEditingController nis = MaskedTextController(mask: '0.000.000.000-0');
  double progressValue = 0.25;
  String progressString = 'loading_nis_header_progress_string_1';
  double valorBolsaFamilia = 0;
  String get nisReplaced =>
      nis.value.text.replaceAll('.', '').replaceAll('-', '');
  BolsaFamiliaViewModel? bolsaFamilia;

  bool get hasPagamentoSalvo => bolsaFamilia != null;
}

class BolsaFamiliaViewModel {
  final String nis;
  final String name;
  final bool beneficio = true;
  String valor;
  final DateTime date = DateTime.now();
  final String address;

  BolsaFamiliaViewModel({
    required this.nis,
    required this.name,
    required this.valor,
    required this.address,
  });

  factory BolsaFamiliaViewModel.fromRequest(BolsaFamilia bolsaFamilia) {
    return BolsaFamiliaViewModel(
      nis: bolsaFamilia.data.last.nis,
      name: bolsaFamilia.data.last.beneficiario.toTitleCase(),
      valor: bolsaFamilia.data.last.valorTotalPeriodo,
      address:
          '${bolsaFamilia.data.last.municipio.toTitleCase()} / ${bolsaFamilia.data.last.uf.toUpperCase()}',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nis': nis,
      'name': name,
      'valor': valor,
      'address': address,
    };
  }

  factory BolsaFamiliaViewModel.fromMap(Map<String, dynamic> map) {
    return BolsaFamiliaViewModel(
      nis: map['nis'] as String,
      name: map['name'] as String,
      valor: map['valor'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BolsaFamiliaViewModel.fromJson(String source) =>
      BolsaFamiliaViewModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
