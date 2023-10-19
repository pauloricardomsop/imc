import 'package:ad_manager/ad_manager.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:request_manager/request_manager.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/consulta_cpf/consulta_cpf_view_model.dart';
import 'package:svr/app/modules/consulta_cpf/ui/consulta_cpf_success_page.dart';
import 'package:validators/validators.dart';

class ConsultaCPFController {
  static final ConsultaCPFController _instance = ConsultaCPFController._();

  ConsultaCPFController._();

  factory ConsultaCPFController() => _instance;

  AppStream<ConsultaCPFViewModel> consultaStream =
      AppStream<ConsultaCPFViewModel>.seed(ConsultaCPFViewModel());
  ConsultaCPFViewModel get consulta => consultaStream.value;

  Future<void> onClickConsultar(_) async {
    if (!CPFValidator.isValid(consulta.cpfEC.text)) {
      consulta.cpfFC.requestFocus();
      throw Exception('CPF inválido');
    }

    if (!isDate(consulta.dateFormatted)) {
      consulta.dataNascimentoFC.requestFocus();
      throw Exception('Data inválida');
    }
    FocusScope.of(_).unfocus();
    final response =
        await ConsultaCPFAdapter.getConsultaCPF(consulta.cpfEC.value.text, consulta.dateFormatted);
    if (response.hasData) {
      AdManager.showRewarded(
          onDispose: () => push(_, ConsultaCPFSuccessPage(response.data)));
    } else {
      NotificationService.negative(response.error.toString());
    }
  }
} 