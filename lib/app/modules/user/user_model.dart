// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svr/app/core/enums/gender_type.dart';
import 'package:svr/app/core/enums/height_type.dart';
import 'package:svr/app/core/enums/imc_level.dart';
import 'package:svr/app/core/enums/turns.dart';
import 'package:svr/app/core/enums/weight_type.dart';

class UserModel {
  final TextEditingController weightEC;
  final TextEditingController centimetersEC;
  final TextEditingController feetEC;
  final TextEditingController incEC;
  Turn turn;
  DateTime date;
  WeightType weightType;
  HeightType heightType;
  GenderType gender;
  int age;
  late double imcValue;
  late IMCLevel imcLevel;
  bool isFirst;

  UserModel copyWith() => UserModel(
        weightEC: TextEditingController(text: weightEC.text),
        centimetersEC: TextEditingController(text: centimetersEC.text),
        feetEC: TextEditingController(text: feetEC.text),
        incEC: TextEditingController(text: incEC.text),
        weightType: weightType,
        heightType: heightType,
        gender: gender,
        age: age,
        date: date,
        turn: turn,
        isFirst: isFirst,
      );

  bool get imcNormal => imcValue > 18.5 && imcValue < 25;

  double get height {
    double heightValue = double.tryParse(centimetersEC.text) ?? 0.0;

    if (heightType == HeightType.ftin) {
      double feet = double.tryParse(feetEC.text) ?? 0.0;
      double inches = double.tryParse(incEC.text) ?? 0.0;

      heightValue = feet * 0.3048 + inches * 0.0254;
    } else {
      heightValue /= 100.0;
    }

    return heightValue;
  }

  String get heightLabel {
    double heightValue = double.tryParse(centimetersEC.text) ?? 0.0;

    if (heightType == HeightType.ftin) {
      double feet = double.tryParse(feetEC.text) ?? 0.0;
      double inches = double.tryParse(incEC.text) ?? 0.0;
      return '${feet}ft ${inches}in';
    } else {
      return '${heightValue.toStringAsFixed(1)} cm';
    }
  }

  double get weight {
    double weightValue = double.tryParse(weightEC.text) ?? 0.0;

    if (weightType == WeightType.lb) {
      weightValue *= 0.453592;
    }

    return weightValue;
  }

  String get weightLabel {
    double weightValue = double.tryParse(weightEC.text) ?? 0.0;
    if (weightType == WeightType.lb) {
      return '${weightValue.toStringAsFixed(2)} Kg';
    } else {
      return '${weightValue.toStringAsFixed(2)} lb';
    }
  }

  double calculateIMC() {
    double weight = double.tryParse(weightEC.text) ?? 0.0;
    double heightCm = double.tryParse(centimetersEC.text) ?? 0.0;
    double heightM = heightCm / 100.0;

    if (height > 0) {
      return weight / pow(heightM, 2);
    } else {
      return 0.0;
    }
  }

  List<String> calcularPesoIdeal() {
    const double imcMinimo = 18.5;
    const double imcMaximo = 25.0;

    final double alturaAoQuadrado = height * height;

    double pesoMinimo = imcMinimo * alturaAoQuadrado;
    double pesoMaximo = imcMaximo * alturaAoQuadrado;

    double diferenca = 0;

    if (imcValue < 18.5) {
      diferenca = pesoMinimo - weight;
    } else if (imcValue > 25) {
      diferenca = weight - pesoMaximo;
    }

    return [parseKgLb(pesoMinimo), parseKgLb(pesoMaximo), parseKgLb(diferenca)];
  }

  String parseKgLb(double kg) {
    if (weightType == WeightType.kg) {
      return '${kg.toStringAsFixed(2)} Kg';
    } else {
      return '${(kg * 2.20462).toStringAsFixed(2)} lb';
    }
  }

  static create() => UserModel(
      weightEC: TextEditingController(text: '0'),
      centimetersEC: TextEditingController(text: '0'),
      feetEC: TextEditingController(text: '0'),
      incEC: TextEditingController(text: '0'),
      weightType: WeightType.kg,
      heightType: HeightType.cm,
      gender: GenderType.male,
      age: 23,
      date: DateTime.now(),
      turn: Turn.morning,
      isFirst: true);

  UserModel(
      {required this.weightEC,
      required this.centimetersEC,
      required this.feetEC,
      required this.incEC,
      required this.weightType,
      required this.heightType,
      required this.gender,
      required this.age,
      required this.turn,
      required this.date,
      required this.isFirst});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weightEC': weightEC.text,
      'centimetersEC': centimetersEC.text,
      'feetEC': feetEC.text,
      'incEC': incEC.text,
      'weightType': weightType.index,
      'heightType': heightType.index,
      'gender': gender.index,
      'age': age,
      'date': date.millisecondsSinceEpoch,
      'turn': turn.index,
      'imcValue': imcValue,
      'imcLevel': imcLevel.index
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      weightEC: TextEditingController(text: map['weightEC']),
      centimetersEC: TextEditingController(text: map['centimetersEC']),
      feetEC: TextEditingController(text: map['feetEC']),
      incEC: TextEditingController(text: map['incEC']),
      weightType: WeightType.values[map['weightType'] as int],
      heightType: HeightType.values[map['heightType'] as int],
      gender: GenderType.values[map['gender'] as int],
      age: map['age'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      turn: Turn.values[map['turn'] as int],
      isFirst: false,
    )
      ..imcValue = map['imcValue']
      ..imcLevel = IMCLevel.values[map['imcLevel']];
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
