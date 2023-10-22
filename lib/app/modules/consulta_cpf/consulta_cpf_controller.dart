import 'package:ad_manager/ad_manager.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:request_manager/request_manager.dart';
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

  AppStreamResponse<ConsultaCPFAdapterModel> consultaCPFStream =
      AppStreamResponse<ConsultaCPFAdapterModel>();
  ConsultaCPFAdapterModel get consultaCPF => consultaCPFStream.value;

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
    AdManager.showRewarded(
        onDispose: () {
          if (consultaCPFStream.controller.value.hasData) {
            return push(_, ConsultaCPFSuccessPage(consultaCPF));
          } else {}
        },
        loadingPage: LoadingPage(
          'Realizando Consulta',
          'Após o resultado você verá um anúncio.',
          (_) async {
            await ConsultaCPFAdapter.getConsultaCPF(
                    consulta.cpfEC.text, consulta.dataNascimentoEC.text)
                .then((response) {
              consultaCPFStream.add(response);
              Navigator.pop(_);
            });
          },
        ));
  }
}
