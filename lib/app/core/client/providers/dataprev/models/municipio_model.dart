class MunicipioModel {
  String? codigoMunicipioIbge;
  String? nomeMunicipio;

  MunicipioModel({this.codigoMunicipioIbge, this.nomeMunicipio});

  MunicipioModel.fromJson(Map<String, dynamic> json) {
    codigoMunicipioIbge = json['codigoMunicipioIbge'] ?? '';
    nomeMunicipio = json['nomeMunicipio'] ?? '';
  }

  static List<MunicipioModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => MunicipioModel.fromJson(e)).toList();
  }
}
