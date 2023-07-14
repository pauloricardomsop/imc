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

class EstatisticasValores {
  EstatisticasCard? home;
  Estatisticas? estatisticas;

  static late EstatisticasValores estatisticasValores;

  static Map<String, dynamic> defaultMap = {
  "home": {
    "title": "Valores ainda não recebidos",
    "value": "R\$ 7.12 Bilhões",
    "desc": "VER COMO RECEBER"
  },
  "estatisticas": {
    "home": {
      "cardValores": {
        "title": "Valores ainda não recebidos",
        "value": "R\$ 7.12 Bilhões",
        "desc": "VER DETALHES"
      },
      "valoresDevolvidos": [
        {
          "anoMes": "2023 - MAIO",
          "valorDevolvido": "R\$ 232 Milhões"
        },
        {
          "anoMes": "2023 - ABRIL",
          "valorDevolvido": "R\$ 260 Milhões"
        },
        {
          "anoMes": "2023 - MARÇO",
          "valorDevolvido": "R\$ 505 Milhões"
        },
        {
          "anoMes": "2023 - FEVEREIRO",
          "valorDevolvido": "R\$ 151 Milhões"
        },
        {
          "anoMes": "2023 - JANEIRO",
          "valorDevolvido": "R\$ 176 Milhões"
        },
        {
          "anoMes": "2022 - DEZEMBRO",
          "valorDevolvido": "R\$ 150 Milhões"
        }
      ]
    },
    "proximasDivulgacoes": [
      {
        "data": "07 DE JUNHO",
        "horario": "14:30"
      },
      {
        "data": "07 DE JULHO",
        "horario": "14:30"
      },
      {
        "data": "07 DE AGOSTO",
        "horario": "14:30"
      },
      {
        "data": "08 DE SETEMBRO",
        "horario": "14:30"
      },
      {
        "data": "06 DE OUTUBRO",
        "horario": "14:30"
      },
      {
        "data": "08 DE NOVEMBRO",
        "horario": "14:30"
      },
      {
        "data": "07 DE DEZEMBRO",
        "horario": "14:30"
      }
    ],
    "detalhes": {
      "cardValoresReceber": {
        "title": "Total de valores a receber",
        "value": "R\$ 7.12 Bilhões",
        "desc": "R\$ 7.123.443.188,39"
      },
      "valoresReceber": [
        {
          "descricao": "PESSOA FÍSICA",
          "valor": "R\$ 5.72 Bilhões",
          "subtitle": "Quantidade de Beneficiários: 36.592.388"
        },
        {
          "descricao": "PESSOA JURÍDICA",
          "valor": "R\$ 1.4 Bilhões",
          "subtitle": "Quantidade de Beneficiários: 2.788.249"
        }
      ],
      "cardValoresDevolvidos": {
        "title": "Total de valores devolvidos",
        "value": "R\$ 4.16 Bilhões",
        "desc": "R\$ 4.168.218.597,18"
      },
      "valoresDevolvidos": [
        {
          "descricao": "PESSOA FÍSICA",
          "valor": "R\$ 3.11 Bilhões",
          "subtitle": "Quantidade de Beneficiários: 13.975.515"
        },
        {
          "descricao": "PESSOA JURÍDICA",
          "valor": "R\$ 1.05 Bilhões",
          "subtitle": "Quantidade de Beneficiários: 535.961"
        }
      ]
    }
  }
};

  EstatisticasValores({this.home, this.estatisticas});

  EstatisticasValores.fromJson(Map<String, dynamic> json) {
    home = json['home'] != null ? EstatisticasCard.fromJson(json['home']) : null;
    estatisticas =
        json['estatisticas'] != null ? Estatisticas.fromJson(json['estatisticas']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (home != null) {
      data['home'] = home!.toJson();
    }
    if (estatisticas != null) {
      data['estatisticas'] = estatisticas!.toJson();
    }
    return data;
  }
}

class Estatisticas {
  EstatisticasHome? home;
  List<ProximasDivulgacoes>? proximasDivulgacoes;
  Detalhes? detalhes;

  Estatisticas({this.home, this.proximasDivulgacoes, this.detalhes});

  Estatisticas.fromJson(Map<String, dynamic> json) {
    home = json['home'] != null ? EstatisticasHome.fromJson(json['home']) : null;
    if (json['proximasDivulgacoes'] != null) {
      proximasDivulgacoes = <ProximasDivulgacoes>[];
      json['proximasDivulgacoes'].forEach((v) {
        proximasDivulgacoes!.add(ProximasDivulgacoes.fromJson(v));
      });
    }
    detalhes = json['detalhes'] != null ? Detalhes.fromJson(json['detalhes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (home != null) {
      data['home'] = home!.toJson();
    }
    if (proximasDivulgacoes != null) {
      data['proximasDivulgacoes'] = proximasDivulgacoes!.map((v) => v.toJson()).toList();
    }
    if (detalhes != null) {
      data['detalhes'] = detalhes!.toJson();
    }
    return data;
  }
}

class EstatisticasHome {
  EstatisticasCard? cardValores;
  List<ValoresDevolvidos>? valoresDevolvidos;

  EstatisticasHome({this.cardValores, this.valoresDevolvidos});

  EstatisticasHome.fromJson(Map<String, dynamic> json) {
    cardValores =
        json['cardValores'] != null ? EstatisticasCard.fromJson(json['cardValores']) : null;
    if (json['valoresDevolvidos'] != null) {
      valoresDevolvidos = <ValoresDevolvidos>[];
      json['valoresDevolvidos'].forEach((v) {
        valoresDevolvidos!.add(ValoresDevolvidos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cardValores != null) {
      data['cardValores'] = cardValores!.toJson();
    }
    if (valoresDevolvidos != null) {
      data['valoresDevolvidos'] = valoresDevolvidos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ValoresDevolvidos {
  String? anoMes;
  String? valorDevolvido;

  ValoresDevolvidos({this.anoMes, this.valorDevolvido});

  ValoresDevolvidos.fromJson(Map<String, dynamic> json) {
    anoMes = json['anoMes'];
    valorDevolvido = json['valorDevolvido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['anoMes'] = anoMes;
    data['valorDevolvido'] = valorDevolvido;
    return data;
  }
}

class ProximasDivulgacoes {
  String? data;
  String? horario;

  ProximasDivulgacoes({this.data, this.horario});

  ProximasDivulgacoes.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    horario = json['horario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['horario'] = horario;
    return data;
  }
}

class Detalhes {
  EstatisticasCard? cardValoresReceber;
  List<EstatisticasValoresDetalhes>? valoresReceber;
  EstatisticasCard? cardValoresDevolvidos;
  List<EstatisticasValoresDetalhes>? valoresDevolvidos;

  Detalhes(
      {this.cardValoresReceber,
      this.valoresReceber,
      this.cardValoresDevolvidos,
      this.valoresDevolvidos});

  Detalhes.fromJson(Map<String, dynamic> json) {
    cardValoresReceber = json['cardValoresReceber'] != null
        ? EstatisticasCard.fromJson(json['cardValoresReceber'])
        : null;
    if (json['valoresReceber'] != null) {
      valoresReceber = <EstatisticasValoresDetalhes>[];
      json['valoresReceber'].forEach((v) {
        valoresReceber!.add(EstatisticasValoresDetalhes.fromJson(v));
      });
    }
    cardValoresDevolvidos = json['cardValoresDevolvidos'] != null
        ? EstatisticasCard.fromJson(json['cardValoresDevolvidos'])
        : null;
    if (json['valoresDevolvidos'] != null) {
      valoresDevolvidos = <EstatisticasValoresDetalhes>[];
      json['valoresDevolvidos'].forEach((v) {
        valoresDevolvidos!.add(EstatisticasValoresDetalhes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cardValoresReceber != null) {
      data['cardValoresReceber'] = cardValoresReceber!.toJson();
    }
    if (valoresReceber != null) {
      data['valoresReceber'] = valoresReceber!.map((v) => v.toJson()).toList();
    }
    if (cardValoresDevolvidos != null) {
      data['cardValoresDevolvidos'] = cardValoresDevolvidos!.toJson();
    }
    if (valoresDevolvidos != null) {
      data['valoresDevolvidos'] = valoresDevolvidos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EstatisticasValoresDetalhes {
  String? descricao;
  String? valor;
  String? subtitle;

  EstatisticasValoresDetalhes({this.descricao, this.valor, this.subtitle});

  EstatisticasValoresDetalhes.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    valor = json['valor'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['valor'] = valor;
    data['subtitle'] = subtitle;
    return data;
  }
}

class EstatisticasCard {
  String? title;
  String? value;
  String? desc;

  EstatisticasCard({this.title, this.value, this.desc});

  EstatisticasCard.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['value'] = value;
    data['desc'] = desc;
    return data;
  }
}
