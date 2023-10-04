import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/enums/consulta_valores_tipo.dart';
import 'package:svr/app/core/formatters/cnpj_input_formatter.dart';
import 'package:svr/app/core/formatters/cpf_input_formatter.dart';
import 'package:svr/app/core/formatters/date_input_formatter.dart';
import 'package:svr/app/modules/consulta_svr/consultar_svr_controller.dart';

class ConsultaValoresFormPage extends AdStatefulWidget {
  final ConsultaValoresPessoa tipo;
  ConsultaValoresFormPage(this.tipo, {Key? key})
      : super(key: key, name: 'ConsultaValoresReceberFormPage');

  @override
  State<ConsultaValoresFormPage> createState() => ConsultaValoresReceberFormPageState();
}

class ConsultaValoresReceberFormPageState extends State<ConsultaValoresFormPage> {
  final ConsulteValoresController _controller = ConsulteValoresController();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainer,
      child: AppListView(
        children: [
          Header.text(
              widget.tipo == ConsultaValoresPessoa.juridica
                  ? 'Consulta valores pessoa jurídica.'
                  : 'Consulta valores pessoa física.',
              widget.tipo == ConsultaValoresPessoa.juridica
                  ? 'Insira CNPJ e data de abertura da empresa desejada.'
                  : 'Insira CPF e data de nascimento da pessoa desejada.'),
          AppField(
            controller: TextEditingController(),
            label: widget.tipo == ConsultaValoresPessoa.juridica ? 'CNPJ' : 'CPF',
            hint: widget.tipo == ConsultaValoresPessoa.juridica
                ? '00.000.000/0000-00'
                : '000.000.000-00',
            onChanged: (e) => _controller.consultaValoresStream.update(),
            icon: Symbols.person_search,
            type: const TextInputType.numberWithOptions(decimal: false, signed: false),
            inputFormatters: [
              widget.tipo == ConsultaValoresPessoa.juridica
                  ? CNPJInputFormatter()
                  : CPFInputFormatter()
            ],
          ),
          const H(12),
          AppField(
            controller: TextEditingController(),
            label: widget.tipo == ConsultaValoresPessoa.juridica
                ? 'Data de abertura'
                : 'Data de nascimento',
            hint: widget.tipo == ConsultaValoresPessoa.juridica ? '00/00/0000' : '00/00/0000',
            onChanged: (e) => _controller.consultaValoresStream.update(),
            icon: Symbols.calendar_today,
            type: const TextInputType.numberWithOptions(decimal: false, signed: false),
            inputFormatters: [DateInputFormatter()],
          ),
          const H(12),
          // CardAlert(
          //   icon: AppIcon.info(),
          //   backgroundColor: Color(0xFFFFEDD5),
          //   borderColor: ,
          // ),
          const H(12),
          const CardAlert.info(
              'Para consultar valores de pessoas falecidas você precisa ser herdeiro, testamentário, inventariante ou procurador.'),
        ],
      ),
    );
  }
}
