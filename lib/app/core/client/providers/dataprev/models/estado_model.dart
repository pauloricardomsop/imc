class EstadoModel {
  String? codigoUfIbge;
  String? nomeUf;
  String? siglaUf;

  EstadoModel({this.codigoUfIbge, this.nomeUf, this.siglaUf});

  EstadoModel.fromJson(Map<String, dynamic> json) {
    codigoUfIbge = json['codigoUfIbge'] ?? '';
    nomeUf = json['nomeUf'] ?? '';
    siglaUf = json['siglaUf'] ?? '';
  }

  static List<EstadoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => EstadoModel.fromJson(e)).toList();
  }
}
