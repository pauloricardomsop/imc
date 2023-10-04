import 'package:uuid/uuid.dart';

class CPFToken {
  String? mensagem;
  String? exceO;

  CPFToken({this.mensagem, this.exceO});

  CPFToken.fromJson(Map<String, dynamic> json) {
    mensagem = json['mensagem'];
    exceO = json['Exceção'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mensagem'] = mensagem;
    data['Exceção'] = exceO;
    return data;
  }
}

class CPFTokenPayload {
  static String sandbox = 'false';
  static String aplicativo = 'pessoafisica';
  static String idNuvem = const Uuid().v1();
  static String so = 'ios';

  static Map<String, dynamic> toJson() => {
        'sandbox': sandbox,
        'aplicativo': aplicativo,
        'idNuvem': idNuvem,
        'so': so,
      };
}
