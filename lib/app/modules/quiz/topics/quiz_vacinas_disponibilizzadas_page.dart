import 'package:ad_manager/ad_manager.dart';
import 'package:design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuizVacinasDisponibilizadasPage extends AdStatefulWidget {
  QuizVacinasDisponibilizadasPage({Key? key})
      : super(key: key, name: 'QuizVacinasDisponibilizadasPage');

  @override
  State<QuizVacinasDisponibilizadasPage> createState() => _QuizVacinasDisponibilizadasPageState();
}

class _QuizVacinasDisponibilizadasPageState extends State<QuizVacinasDisponibilizadasPage> {
  List<CheckListModel> get checklist => [
        CheckListModel(
          label: 'Covid-19',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'BCG',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Hepatite A',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Hepatite B',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Hepatite B',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Penta (DTP / Hib / Hep. B)',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Pneumocócica 10 valente',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Vacina Inativada Poliomelite (VIP)',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Vacina Oral Poliomelite (VOP)',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Vacina Rotavírus Humano (VRH)',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Meningocócica C (Conjugada)',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Febre amarela',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Tríplice viral',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Tetraviral',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'DTP (Tríplice bacteriana)',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Varicela',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'HPV quadrivalente',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'dT (dupla adulto)',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'dTpa (DTP adulto)',
          icon: Symbols.syringe,
        ),
        CheckListModel(
          label: 'Menigocócica ACWY',
          icon: Symbols.syringe,
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return AppScaffold(child: body(context));
  }

  Widget body(_) {
    return AppListView(
      children: [
        Header.light(
          top: HeaderTop(
            backgroundColor: AppColors.white,
            leading: AppIcon.exit(
              backgroundColor: AppColors.surfaceContainer,
              iconColor: AppColors.onSurface,
              onTap: () => Navigator.pop(context),
            ),
          ),
        ),
        const AppTitle('Vacinas disponibilizadas pelo SUS'),
        const H(16),
        const AppDesc(
            'Todas as pessoas podem procurar uma Unidade Básica de Saúde para atualizar a caderneta de vacinação e tirar dúvidas. \n\nManter o esquema vacinal atualizado também é critério para participação no Bolsa Família.'),
        const H(16),
        const BannerWidget(),
        const H(16),
        const AppTitle('Confira a lista completa de vacinas disponíveis no SUS:'),
        const H(16),
        CheckList(checklist)
      ],
    );
  }
}
