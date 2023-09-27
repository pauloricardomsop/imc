import 'package:ad_manager/ad_manager.dart';
import 'package:svr/app/core/services/notification_service.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/calendario/ui/calendario_pagamentos_page.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class CalendarioHomePage extends AdStatefulWidget {
  CalendarioHomePage({Key? key}) : super(key: key, name: 'CalendarioHomePage');

  @override
  State<CalendarioHomePage> createState() => _CalendarioHomePageState();
}

class _CalendarioHomePageState extends State<CalendarioHomePage> {
  int? nisSelected;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottom: nisSelected == null
          ? null
          : Footer(
              AppButton(
                onTap: () {
                  if (nisSelected == null) {
                    NotificationService.negative('Selecione um NIS');
                    return;
                  }
                  AdManager.showRewarded(
                      onDispose: () => push(
                            context,
                            CalendarioPagamentosPage(nisSelected!),
                          ));
                },
                label: 'VER CALENDARIO NIS ${nisSelected ?? ''}',
                icon: const AdIcon(),
              ),
            ),
      child: body(context),
    );
  }

  Widget body(_) {
    return AppListView(
      children: [
        const Header(
          top: HeaderTop(),
          title: 'Calendário de\nPagamentos',
          desc: 'Selecione o último número do seu NIS para ver datas.',
        ),
        CardsSelect(
          cards: [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
              .map(
                (e) => CardSelect(
                  title: 'Final do\nNIS',
                  label: e.toString(),
                  selected: e == nisSelected,
                  onTap: () => setState(() => nisSelected = e),
                ),
              )
              .toList(),
          count: 3,
        ),
      ],
    );
  }
}
