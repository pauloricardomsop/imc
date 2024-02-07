import 'package:flutter/material.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/enums/imc_level.dart';

class ImcListInfo extends StatelessWidget {
  final IMCLevel level;

  const ImcListInfo(this.level, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Column(
        children: IMCLevel.values.map((e) {
          final isSelected = e == level;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected ? e.color : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: isSelected ? Colors.white : e.color, shape: BoxShape.circle),
                ),
                const W(8),
                Expanded(
                    child: Text(
                  e.label,
                  style: TextStyle(
                      color: isSelected ? Colors.white : const Color.fromARGB(255, 64, 64, 64),
                      fontWeight: isSelected ? FontWeight.w900 : null),
                )),
                Text(
                  '${e.min} - ${e.max}'
                      .replaceAll('.0', '')
                      .replaceFirst('0 - 15.99', '<16')
                      .replaceFirst('40 - 100', '≥40.0')
                      .replaceAll('99', '9')
                      .replaceAll('49', '4'),
                  style: TextStyle(
                      color: isSelected ? Colors.white : const Color.fromARGB(255, 64, 64, 64),
                      fontWeight: isSelected ? FontWeight.w900 : null),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
