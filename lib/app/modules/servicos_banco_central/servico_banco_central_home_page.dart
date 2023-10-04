import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/servicos_banco_central/topics/chave_pix.dart';
import 'package:svr/app/modules/servicos_banco_central/topics/contas_relacionamentos_page.dart';
import 'package:svr/app/modules/servicos_banco_central/topics/emprestimos_financiamentos_pasge.dart';

class ServicoBancoCentralHomePage extends AdStatefulWidget {
  ServicoBancoCentralHomePage({Key? key})
      : super(key: key, name: 'ServicoBancoCentralHomePage');

  @override
  State<ServicoBancoCentralHomePage> createState() =>
      _ServicoBancoCentralHomePageState();
}

class _ServicoBancoCentralHomePageState
    extends State<ServicoBancoCentralHomePage> {
  List<CardFeature> get cardFeatureFullItens => [
        CardFeature.full(
          label: 'Empréstimos e\nFinanciamentos',
          prefix: Symbols.currency_exchange,
          sufix: const AppIcon.frontLight(),
          onTap: () => push(context, EmprestimosFinanciamentosPage()),
        ),
        CardFeature.full(
          label: 'Contas e\nRelacionamentos',
          prefix: Symbols.account_balance,
          sufix: const AppIcon.frontLight(),
          onTap: () => push(context, ContasRelacionamentosPage()),
        ),
        CardFeature.full(
          label: 'Chaves PIX registradas\nem seu nome.',
          prefix: Icons.pix,
          sufix: const AppIcon.frontLight(),
          onTap: () => push(context, ChavePixPage()),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: AppColors.surfaceContainer,
      child: AppListView(
        children: [
          const Header.text(
            'Registrato Banco\nCentral',
            'No site do Banco Central você vai encontrar os serviços abaixo, saiba mais sobre cada um deles.',
          ),
          const AppTitle('Opções de consulta'),
          const H(24),
          CardFeatures.full(cardFeatureFullItens),
        ],
      ),
    );
  }
}
