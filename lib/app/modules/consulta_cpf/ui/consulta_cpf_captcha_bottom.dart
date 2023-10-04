import 'dart:typed_data';
import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/client/cpf_captcha/models/cpf_captcha_situacao_model.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/models/api_response_model.dart';
import 'package:svr/app/modules/consulta_cpf/consulta_cpf_controller.dart';
import 'package:svr/app/modules/consulta_cpf/consulta_cpf_model.dart';

Future<ApiResponse<CPFCaptchaSituacaoModel>?> showConsultaCPFCaptchaBottom(_) async =>
    await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        context: _,
        builder: (_) => const ConsulteSeusValoresCaptchaBottom());

class ConsulteSeusValoresCaptchaBottom extends StatefulWidget {
  const ConsulteSeusValoresCaptchaBottom({super.key});

  @override
  State<ConsulteSeusValoresCaptchaBottom> createState() => _ConsulteSeusValoresCaptchaBottomState();
}

class _ConsulteSeusValoresCaptchaBottomState extends State<ConsulteSeusValoresCaptchaBottom> {
  final ConsultaCPFController _controller = ConsultaCPFController();

  @override
  Widget build(BuildContext context) {
    return StreamOutResponse<ApiResponse<Uint8List>, Uint8List>(
      loading: _shimmer(),
      stream: _controller.cpfAdapter.captchaResponse.listen,
      child: (_, image) => StreamOut<ConsultaCPFModel>(
        loading: _shimmer(),
        stream: _controller.consultaStream.listen,
        child: (_, model) => Padding(
          padding: EdgeInsets.only(
              left: 16, right: 16, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const H(8),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 33,
                height: 7,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const H(16),
              Image.memory(
                image,
                height: MediaQuery.of(context).size.width * 0.3,
                width: double.maxFinite,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  _controller.getCaptcha();
                  return AppShimmer(
                      child: Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.width * 0.3,
                    color: Colors.grey,
                  ));
                },
              ),
              const H(16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppField(
                      controller: model.captchaEC,
                      label: 'Digite o texto da imagem acima',
                      autoFocus: true,
                    ),
                  ),
                  const W(8),
                  Center(
                    child: InkWell(
                      onTap: () => _controller.getCaptcha(),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(top: 32),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Symbols.cached,
                          color: AppColors.onSurface,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const H(16),
              AppButton(
                label: 'CONSULTAR VALORES',
                onTap: () => _controller.onClickConsultar(context),
                icon: const AdIcon(),
              ),
              const H(16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shimmer() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const H(8),
          AppShimmer(
              child: Container(
            width: 500,
            height: 200,
            color: Colors.grey,
          )),
          const H(16),
          AppShimmer(
              child: Container(
            width: double.maxFinite,
            height: 50,
            color: Colors.grey,
          )),
          const H(16),
          AppShimmer(
              child: Container(
            width: double.maxFinite,
            height: 50,
            color: Colors.grey,
          )),
          const H(16),
        ],
      ),
    );
  }
}