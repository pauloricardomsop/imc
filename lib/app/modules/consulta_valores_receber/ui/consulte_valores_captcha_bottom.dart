import 'dart:convert';

import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/client/valores_receber/models/valores_receber_captcha_model.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/models/api_response_model.dart';
import 'package:svr/app/modules/consulta_valores_receber/consulta_valores_controller.dart';

Future<ApiResponse<bool>?> showConsultaValoresCaptchaBottom(_) async => await showModalBottomSheet(
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
  final ConsulteValoresController _controller = ConsulteValoresController();

  @override
  void initState() {
    _controller.fetchValoresReceberCaptcha();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamOutResponse<ApiResponse<ValoresReceberCaptcha>, ValoresReceberCaptcha>(
      loading: _shimmer(),
      stream: _controller.captchaResponseStream.listen,
      child: (_, captcha) => StreamOut(
        loading: _shimmer(),
        stream: _controller.consultaValoresStream.listen,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.memory(
                    height: MediaQuery.of(context).size.width * 0.4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    fit: BoxFit.cover,
                    base64Decode(captcha.imagemBase64!),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => _controller.fetchValoresReceberCaptcha(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C44F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Symbols.cached, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ],
              ),
              const H(16),
              AppField(
                controller: model.captcha,
                label: 'Digite o texto da imagem acima',
              ),
              const H(16),
              AppButton(
                label: 'CONSULTAR VALORES',
                onTap: () {
                  _controller.consultaValoresStream.update();
                  _controller.onClickConsultarValores(_);
                },
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

//   Widget appTextCaptcha() {
//     var controller = _controller.consulteController.value.captcha;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Digite o texto da imagem acima',
//           style: AppTheme.text.semi.base(const Color(0xFF474747)),
//         ),
//         const H(8),
//         TextFormField(
//           controller: controller,
//           style: AppTheme.text.normal.lg(const Color(0xFF777777)),
//           cursorColor: const Color(0xFF777777),
//           onChanged: (value) {},
//           decoration: InputDecoration(
//               hintText: 'Digite aqui...',
//               border: _fieldBorder,
//               errorBorder: _fieldBorder,
//               enabledBorder: _fieldBorder,
//               focusedBorder: _fieldBorder,
//               disabledBorder: _fieldBorder,
//               focusedErrorBorder: _fieldBorder,
//               prefixIcon: const Padding(
//                 padding: EdgeInsets.only(left: 20, right: 10),
//                 child: Icon(
//                   Symbols.password,
//                   weight: 800,
//                   color: Color(0xFF777777),
//                 ),
//               )),
//         ),
//       ],
//     );
//   }
