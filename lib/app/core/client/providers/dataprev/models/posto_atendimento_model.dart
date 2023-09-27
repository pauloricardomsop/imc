class PostoAtendimentoModel {
  int? id;
  String? numeroIbgeMunicipio;
  String? siglaUf;
  String? nomeMunicipio;
  String? latitude;
  String? longitude;
  String? nomePostoAtendimento;
  String? nomeBairro;
  TipoPostoAtendimento? tipoPostoAtendimento;
  String? enderecoCompleto;
  double? distanciaReferencia;

  PostoAtendimentoModel(
      {this.id,
      this.numeroIbgeMunicipio,
      this.siglaUf,
      this.nomeMunicipio,
      this.latitude,
      this.longitude,
      this.nomePostoAtendimento,
      this.nomeBairro,
      this.tipoPostoAtendimento,
      this.enderecoCompleto,
      this.distanciaReferencia});

  PostoAtendimentoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    numeroIbgeMunicipio = json['numeroIbgeMunicipio'] ?? '';
    siglaUf = json['siglaUf'] ?? '';
    nomeMunicipio = json['nomeMunicipio'] ?? '';
    latitude = json['latitude'] ?? '';
    longitude = json['longitude'] ?? '';
    nomePostoAtendimento = json['nomePostoAtendimento'] ?? '';
    nomeBairro = json['nomeBairro'] ?? '';
    tipoPostoAtendimento = json['tipoPostoAtendimento'] != null
        ? TipoPostoAtendimento.fromJson(json['tipoPostoAtendimento'])
        : null;
    enderecoCompleto = json['enderecoCompleto'] ?? '';
    distanciaReferencia = json['distanciaReferencia'] ?? 0.0;
  }

  static List<PostoAtendimentoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => PostoAtendimentoModel.fromJson(e)).toList();
  }
}

class TipoPostoAtendimento {
  int? codigo;
  String? nome;

  TipoPostoAtendimento({this.codigo, this.nome});

  TipoPostoAtendimento.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'] ?? 0;
    nome = json['nome'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['codigo'] = codigo;
    data['nome'] = nome;
    return data;
  }
}
