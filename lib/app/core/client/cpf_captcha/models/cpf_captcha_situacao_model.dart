// ignore_for_file: public_member_api_docs, sort_constructors_first
class CPFCaptchaSituacaoModel {
  final String cpf;
  final String nome;
  final String dataNascimento;
  final String situacaoCadastral;
  final String dataInscricao;
  final String digitoVerificador;
  final String comprovanteEmitido;
  final String codigoControleComprovante;

  CPFCaptchaSituacaoModel({
    required this.cpf,
    required this.nome,
    required this.dataNascimento,
    required this.situacaoCadastral,
    required this.dataInscricao,
    required this.digitoVerificador,
    required this.comprovanteEmitido,
    required this.codigoControleComprovante,
  });

  bool get isSituacaoRegular => situacaoCadastral.toLowerCase().contains('regular');
  
}
