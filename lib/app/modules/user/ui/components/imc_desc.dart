import 'package:flutter/material.dart';
import 'package:svr/app/modules/user/user_model.dart';

class ImcDesc extends StatelessWidget {
  final UserModel user;
  const ImcDesc(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final precos = user.calcularPesoIdeal();
    return IntrinsicWidth(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFFf4f4f4),
        ),
        child: user.imcNormal
            ? const Text(
                '😎 Parabéns! Seu índice está ótimo no momento. Mantenha os seus hábitos saudávei para mater o seu peso saudável')
            : RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Peso normal para a sua altura (${user.weightLabel}):\n',
                        style: const TextStyle(
                            color: Color(0xFF000000), wordSpacing: 1.4, height: 1.3)),
                    TextSpan(
                        text: '${precos[0]} - ${precos[1]} ',
                        style: const TextStyle(
                            color: Color(0xFF000000), fontWeight: FontWeight.w900, height: 1.3)),
                    TextSpan(
                        text:
                            '(${double.parse(precos[1].split(' ').first).isNegative ? '-' : '+'} ${precos[1]})',
                        style: const TextStyle(
                            color: Color(0xFFd13a3a), fontWeight: FontWeight.w900, height: 1.3)),
                  ],
                ),
              ),
      ),
    );
  }
}
