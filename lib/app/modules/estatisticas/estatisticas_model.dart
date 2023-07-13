// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EstatisticaValorModel {
  final String label;
  final String value;
  final String? desc;
  EstatisticaValorModel({required this.label, required this.value, this.desc});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': label,
      'value': value,
      'desc': desc,
    };
  }

  factory EstatisticaValorModel.fromMap(Map<String, dynamic> map) {
    return EstatisticaValorModel(
      label: map['date'] as String,
      value: map['value'] as String,
      desc: map['desc'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EstatisticaValorModel.fromJson(String source) =>
      EstatisticaValorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
