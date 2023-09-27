class ErrorModel {
  List<Detalhes>? detalhes;
  ErrorModel({this.detalhes});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    if (json['detalhes'] != null) {
      detalhes = <Detalhes>[];
      json['detalhes'].forEach((v) {
        detalhes!.add(Detalhes.fromJson(v));
      });
    }
  }
}

class Detalhes {
  MensagemErro? mensagemErro;
  String? detalhes;

  Detalhes({this.mensagemErro, this.detalhes});

  Detalhes.fromJson(Map<String, dynamic> json) {
    mensagemErro = json['mensagemErro'] != null
        ? MensagemErro.fromJson(json['mensagemErro'])
        : null;
    detalhes = json['detalhes'];
  }
}

class MensagemErro {
  String? descricao;
  String? codigo;

  MensagemErro({this.descricao, this.codigo});

  MensagemErro.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    codigo = json['codigo'];
  }
}
