import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/components/w.dart';
import 'package:benefits_brazil/app/core/models/check_list_model.dart';
import 'package:benefits_brazil/app/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';

class CheckList extends StatelessWidget {
  final List<CheckListModel> itens;
  const CheckList(this.itens, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          height: 1,
          color: const Color(0xFFCCCCCC),
        ),
        ...itens
            .map((e) => Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Icon(
                            e.icon,
                            color: const Color(0xFF1C44F9),
                            size: 26,
                          ),
                          const W(12),
                          Expanded(
                            child: Text(
                              e.label,
                              style: AppTheme.text.normal.base(const Color(0xFF474747)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 1,
                      color: const Color(0xFFCCCCCC),
                    ),
                  ],
                ))
            .toList(),
        const H(16)
      ],
    );
  }
}
