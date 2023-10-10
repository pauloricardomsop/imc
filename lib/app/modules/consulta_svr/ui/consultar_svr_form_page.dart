import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/enums/consulta_valores_tipo.dart';
import 'package:svr/app/core/formatters/cnpj_input_formatter.dart';
import 'package:svr/app/core/formatters/cpf_input_formatter.dart';
import 'package:svr/app/core/formatters/date_input_formatter.dart';
import 'package:svr/app/modules/consulta_svr/consultar_svr_controller.dart';
import 'package:svr/app/modules/consulta_svr/consultar_svr_model.dart';

class ConsultarSVRFormPage extends AdStatefulWidget {
  final ConsultaValoresPessoaEstado estado;
  final ConsultaValoresPessoa tipo;
  ConsultarSVRFormPage(this.estado, this.tipo, {Key? key})
      : super(key: key, name: 'ConsultaValoresReceberFormPage');

  @override
  State<ConsultarSVRFormPage> createState() =>
      ConsultaValoresReceberFormPageState();
}

class ConsultaValoresReceberFormPageState extends State<ConsultarSVRFormPage> {
  final ConsultarSVRController _controller = ConsultarSVRController();

  @override
  void initState() {
    _controller.consultaValoresStream
        .add(ConsultarSVRModel(widget.tipo, widget.estado));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainer,
      bottom: Footer(
        AppButton(
          label: 'PRÓXIMO',
          icon: Symbols.trending_flat,
          onTap: () => _controller.onClickProximo(context),
        ),
      ),
      child: StreamOut<ConsultarSVRModel>(
        stream: _controller.consultaValoresStream.listen,
        child: (_, model) => AppListView(
          children: [
            Header.text(
              model.isFalecido
                  ? 'Consulte valores  de falecidos.'
                  : model.isPessoaFisica
                      ? 'Consulta valores pessoa física.'
                      : 'Consulta valores pessoa jurídica.',
              model.isFalecido
                  ? 'Descubra valores esquecidos por pessoas falecidas de sua família.'
                  : model.isPessoaFisica
                      ? 'Insira CPF e data de nascimento da pessoa desejada.'
                      : 'Insira CNPJ e data de abertura da empresa desejada.',
                      hasBanner: false,
            ),
            AppField(
              controller: model.identifier,
              label: model.isPessoaFisica ? 'CPF' : 'CNPJ',
              hint: model.isPessoaFisica
                  ? '000.000.000-00'
                  : '00.000.000/0000-00',
              onChanged: (e) => _controller.consultaValoresStream.update(),
              icon: Symbols.person_search,
              type: const TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              inputFormatters: [
                model.isPessoaFisica
                    ? CPFInputFormatter()
                    : CNPJInputFormatter()
              ],
            ),
            const H(12),
            AppField(
              controller: model.date,
              label: model.isPessoaFisica
                  ? 'Data de nascimeno'
                  : 'Data de abertura',
              hint: model.isPessoaFisica ? '00/00/0000' : '00/00/0000',
              onChanged: (e) => _controller.consultaValoresStream.update(),
              icon: Symbols.calendar_today,
              type: const TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              inputFormatters: [DateInputFormatter()],
            ),
            const H(12),
            if (model.isPessoaFisica && model.isFalecido) ...{
              const CardAlert(
                icon: AppIcon.info(
                  backgroundColor: Color(0xFFFED8AA),
                  iconColor: Color(0xFF441407),
                ),
                label: 'Para consultar valores de pessoas falecidas você precisa ser herdeiro, testamentário, inventariante ou procurador.',
                backgroundColor: Color(0xFFFFEDD5),
                borderColor: Color(0xFFFED8AA),
                textColor: Color(0xFF421407),
              ),
              const H(12),
            },
            const CardAlert.info('Para consultar valores de pessoas falecidas você precisa ser herdeiro, testamentário, inventariante ou procurador.'),
            const H(12),
            const BannerWidget(),
          ],
        ),
      ),
    );
  }
}
