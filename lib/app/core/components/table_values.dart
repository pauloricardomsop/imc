// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:svr/app/core/components/divisor.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/theme/app_theme.dart';
import 'package:svr/app/modules/estatisticas/estatisticas_model.dart';

class TableValues extends StatelessWidget {
  final String left;
  final String right;
  final List<EstatisticaValorModel> models;
  final bool listable;

  const TableValues({
    required this.left,
    required this.right,
    required this.models,
    this.listable = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = models
        .map((e) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEFCFC),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              e.label,
                              style: AppTheme.text.semi.base(const Color(0xFF000C61)),
                            ),
                          ),
                          Text(
                            e.value,
                            style: AppTheme.text.semi.base(const Color(0xFF005231)),
                          ),
                        ],
                      ),
                      if (e.desc != null) const H(8),
                      if (e.desc != null)
                        Text(
                          e.desc!,
                          style: AppTheme.text.normal.sm(const Color(0xFF777777)),
                        ),
                    ],
                  ),
                ),
                const Divisor(),
              ],
            ))
        .toList();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE3E2E2),
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.maxFinite,
          child: Row(
            children: [
              Text(left),
              const Spacer(),
              Text(right),
            ],
          ),
        ),
        if (listable)
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: list,
            ),
          ),
        if (!listable) ...list
      ],
    );
  }
}
