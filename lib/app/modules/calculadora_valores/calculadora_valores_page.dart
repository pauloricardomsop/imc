import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/modules/calculadora_valores/calculadora_valores_controller.dart';
import 'package:svr/app/modules/calculadora_valores/calculadora_valores_model.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class CalculadoraValoresPage extends AdStatefulWidget {
  CalculadoraValoresPage({Key? key})
      : super(key: key, name: 'CalculadoraValoresPage');

  @override
  State<CalculadoraValoresPage> createState() => _CalculadoraValoresPageState();
}

class _CalculadoraValoresPageState extends State<CalculadoraValoresPage> {
  final CalculadoraValoresController _controller =
      CalculadoraValoresController();

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: StreamOut<CalculadoraValoresModel>(
        stream: _controller.calValoresStream.listen,
        child: (_, model) => body(_, model),
      ),
    );
  }

  Widget body(_, CalculadoraValoresModel model) {
    return AppListView(
      children: [
        const Header(
          backgroundColor: AppColors.white,
          top: HeaderTop(
            backgroundColor: AppColors.white,
            leading: AppIcon.back(
              backgroundColor: AppColors.surfaceContainer,
              iconColor: AppColors.onSurface,
            ),
            child: AppDesc(
              'Calculadora de valores do Novo\nBolsa Família.',
              color: AppColors.onSurface,
            ),
          ),
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
                style: const TextStyle(color: AppColors.onSurface).labelLarge,
              ),
              Text(
                'R\$ ${_controller.rentaMedia.toStringAsFixed(2).replaceAll('.', ',')}',
                style: const TextStyle(color: AppColors.onSurface).displaySmall,
              ),
            ],
          ),
        ),
        const H(24),
        Text(
          'Quantas crianças de 0 a 6 anos moram em sua casa?',
          style: const TextStyle(color: AppColors.onSurface).labelLarge,
        ),
        const H(8),
        AppFieldCounter(
          onChanged: (e) {
            model.quantidadeFilhos0a6 = e;
            _controller.calValoresStream.update();
          },
        ),
        const H(24),
        Text(
          'Quantos gestantes moram em sua casa?',
          style: const TextStyle(color: AppColors.onSurface).labelLarge,
        ),
        const H(8),
        AppFieldCounter(
          onChanged: (e) {
            model.quantidadeGestantes = e;
            _controller.calValoresStream.update();
          },
        ),
        const H(24),
        Text(
          'Quantos adolescentes de 7 a 18 anos moram em sua casa?',
          style: const TextStyle(color: AppColors.onSurface).labelLarge,
        ),
        const H(8),
        AppFieldCounter(
          onChanged: (e) {
            model.quantidadeFilhos7a18 = e;
            _controller.calValoresStream.update();
          },
        ),
      ],
    );
  }
}
