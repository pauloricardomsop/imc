import 'package:ad_manager/ad_manager.dart';

import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/utils/formatters.dart';
import 'package:svr/app/modules/calculadora_renda/calculadora_renda_controller.dart';
import 'package:svr/app/modules/calculadora_renda/calculadora_renda_model.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CalculadoraRendaPage extends AdStatefulWidget {
  CalculadoraRendaPage({Key? key})
      : super(key: key, name: 'CalculadoraRendaPage');

  @override
  State<CalculadoraRendaPage> createState() => _CalculadoraRendaPageState();
}

class _CalculadoraRendaPageState extends State<CalculadoraRendaPage> {
  final CalculadoraRendaController _controller = CalculadoraRendaController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: StreamOut<CalculadoraRendaModel>(
        stream: _controller.calcRendaStream.listen,
        child: (_, model) => body(context, model),
      ),
    );
  }

  Widget body(_, CalculadoraRendaModel model) {
    return AppListView(
      children: [
        const Header(
          top: HeaderTop(),
          title: 'Calculadora de Renda',
          desc:
              'Com esta calculadora você poderá informar o total da renda familiar e o número total de pessoas que moram em sua residência, e assim a renda por pessoa será exibido.',
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                'Valor do Benefício',
                //TOODO AJUSTE TESTE
                style: const TextStyle(color: AppColors.onSurface).labelLarge,
              ),
              Text(
                _controller.rentaMedia,
                //TOODO AJUSTE TESTE
                style: const TextStyle(color: AppColors.onSurface).displaySmall,
              ),
            ],
          ),
        ),
        const H(24),
        Text(
          'Qual a soma total da renda de todas as pessoas que moram em sua residência?',
          style: const TextStyle(color: AppColors.onSurface).labelLarge,
        ),
        AppField(
          controller: model.rendaFamiliar,
          label: '',
          hint: 'R\$ 0,00',
          inputFormatters: [CurrencyInputFormatter()],
          onChanged: (e) => _controller.calcRendaStream.update(),
          icon: Symbols.attach_money,
          type: const TextInputType.numberWithOptions(
              decimal: false, signed: false),
        ),
        const H(8),
        const AppDesc('Se ninguém possui renda, deixe em branco.'),
        const H(8),
        Text(
          'Qual a soma total da renda de todas as pessoas que moram em sua residência?',
          style: const TextStyle(color: AppColors.onSurface).labelLarge,
        ),
        const H(24),
        AppFieldCounter(
          onChanged: (e) {
            model.quantidadePessoas = e;
            _controller.calcRendaStream.update();
          },
        ),
      ],
    );
  }
}
