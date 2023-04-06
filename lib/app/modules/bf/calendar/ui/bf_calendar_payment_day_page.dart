import 'package:benefits_brazil/app/core/ad/ad_banner_storage.dart';
import 'package:benefits_brazil/app/core/ad/ad_controller.dart';
import 'package:benefits_brazil/app/core/components/app_banner_ad.dart';
import 'package:benefits_brazil/app/core/components/app_scaffold.dart';
import 'package:benefits_brazil/app/core/components/back_header_benefit.dart';
import 'package:benefits_brazil/app/core/components/card_sm.dart';
import 'package:benefits_brazil/app/core/components/h.dart';
import 'package:benefits_brazil/app/core/enums/benefit_enum.dart';
import 'package:benefits_brazil/app/core/models/card_sm_model.dart';
import 'package:benefits_brazil/app/core/theme/app_theme.dart';
import 'package:benefits_brazil/app/core/utils/extensions.dart';
import 'package:benefits_brazil/app/core/utils/global_resource.dart';
import 'package:benefits_brazil/app/modules/bf/has_rights/ui/bf_has_rights_home_page.dart';
import 'package:benefits_brazil/app/modules/bf/how_register/bf_how_register_home_page.dart';
import 'package:benefits_brazil/app/modules/bf/how_work/bf_how_work_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../../../../core/components/section_header.dart';

class BfCalendarPaymentDay extends JourneyStatefulWidget {
  final int nis;
  final List<DateTime> days;
  final DateTime day;
  final int currentSemester;

  const BfCalendarPaymentDay(this.nis, this.days, this.day, this.currentSemester, {Key? key})
      : super(key: key, name: 'BfCalendarPaymentDay');

  @override
  State<BfCalendarPaymentDay> createState() => _BfCalendarPaymentDayState();
}

class _BfCalendarPaymentDayState extends State<BfCalendarPaymentDay> {
  BannerAd? banner;
  final ScrollController _scrollController = ScrollController();
  late PageController _pageController;
  late int currentSemester;

  final List<CardSmModel> _cardItens = [
    CardSmModel(
      title: 'Como funciona',
      subtitle: 'Entenda como funciona o Bolsa Família e quais são os valores do benefício.',
      page: const BfHowWorkHomePage(),
    ),
    CardSmModel(
      title: 'Tenho direito?',
      subtitle: 'Saiba se você tem direito ao benefício Bolsa Família.',
      page: const BfHasRightsHomePage(),
    ),
    CardSmModel(
      title: 'Como se cadastrar',
      subtitle: 'Aprenda como se cadastrar e como manter seu benefício Bolsa Família atualizado.',
      page: const BfHowRegisterHomePage(),
    ),
    CardSmModel(
      title: 'Últimas notícias',
      subtitle: 'Encontre as últimas notícias sobre o programa Bolsa Família.',
      page: Container(),
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.currentSemester);
    currentSemester = widget.currentSemester;
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.get(widget.name),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      active: AdController.adConfig.banner.active,
      behavior: AdBannerStorage.get(widget.name),
      body: _body(),
    );
  }

  ListView _body() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackHeaderBenefit(
                benefit: Benefit.bf,
              ),
              const H(16),
              _cardNextPayment(),
              const H(24),
              AppBannerAd(AdBannerStorage.get(widget.name)),
              const H(24),
              const SectionHeader('Calendário', '2023'),
              _titleSemester(),
              const H(16),
              SizedBox(
                width: double.maxFinite,
                height: 248,
                child: PageView(
                  onPageChanged: (i) {
                    setState(() {
                      currentSemester = i;
                    });
                  },
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    _tablePayment(context, widget.days.getRange(0, 6).toList()),
                    _tablePayment(context, widget.days.getRange(6, 12).toList()),
                  ],
                ),
              ),
              const H(16),
              ..._cardItens
                  .map((e) => CardSm(
                        onTap: () {
                          pops(context, 2);
                          push(context, e.page);
                        },
                        title: e.title,
                        subtitle: e.subtitle,
                      ))
                  .toList()
            ],
          ),
        )
      ],
    );
  }

  Row _titleSemester() {
    return Row(
      children: [
        IgnorePointer(
          ignoring: currentSemester == 0,
          child: InkWell(
            onTap: () {
              if (currentSemester == 1) {
                _pageController.previousPage(
                    duration: const Duration(milliseconds: 300), curve: Curves.ease);
              }
            },
            child: Icon(
              Icons.arrow_circle_left_outlined,
              size: 32,
              color: currentSemester == 1 ? const Color(0xFF1C44F9) : const Color(0xFFFFFFFF),
            ),
          ),
        ),
        Expanded(
          child: Center(
              child: Text(
            '${currentSemester + 1}º Semestre',
            style: AppTheme.text.normal.xl2(const Color(0xFF474747)),
          )),
        ),
        IgnorePointer(
          ignoring: currentSemester == 1,
          child: InkWell(
            onTap: () {
              if (currentSemester == 0) {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 300), curve: Curves.ease);
              }
            },
            child: Icon(
              Icons.arrow_circle_right_outlined,
              size: 32,
              color: currentSemester == 0 ? const Color(0xFF1C44F9) : const Color(0xFFFFFFFF),
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardNextPayment() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF1C44F9),
      ),
      child: Column(
        children: [
          Text(
            'O próximo pagamento em',
            style: AppTheme.text.normal.base(const Color(0xFFFFFFFF)),
          ),
          const H(4),
          Text(
            "${DateFormat(DateFormat.DAY, 'pt_BR').format(widget.day)} de ${DateFormat(DateFormat.MONTH, 'pt_BR').format(widget.day).capitalize()}",
            style: AppTheme.text.extra.xl2(const Color(0xFFFFFFFF)),
          ),
        ],
      ),
    );
  }

  Widget _tablePayment(_, List<DateTime> days) {
    return StaggeredGrid.count(
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      axisDirection: AxisDirection.down,
      children: days
          .map((e) => StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: _cellItem(_, e),
              ))
          .toList(),
    );
  }

  Widget _cellItem(_, DateTime date) {
    final bool current = date == widget.day;
    final bool inPast = date.month < widget.day.month;
    return Container(
      decoration: BoxDecoration(
        color: inPast
            ? const Color(0xFFE3E2E2)
            : (current ? const Color(0xFF1C44F9) : const Color(0xFFFFFFFF)),
        border: Border.all(
            color: !inPast || current ? const Color(0xFF1C44F9) : const Color(0xFFE3E2E2),
            width: 1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(DateFormat('MMM', 'pt_BR').format(date).toUpperCase(),
              style: AppTheme.text.normal.base(inPast
                  ? const Color(0xFFC7C6C6)
                  : (current ? const Color(0xFFFFFFFF) : const Color(0xFF1C44F9)))),
          const H(4),
          Text(DateFormat(DateFormat.DAY, 'pt_BR').format(date),
              style: AppTheme.text.extra.xl2(inPast
                  ? const Color(0xFFC7C6C6)
                  : (current ? const Color(0xFFFFFFFF) : const Color(0xFF1C44F9)))),
        ],
      ),
    );
  }
}
