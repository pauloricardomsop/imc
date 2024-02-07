import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/w.dart';

class IMCDateSelectionBottom extends StatefulWidget {
  const IMCDateSelectionBottom({super.key});

  @override
  State<IMCDateSelectionBottom> createState() => _IMCDateSelectionBottomState();
}

class _IMCDateSelectionBottomState extends State<IMCDateSelectionBottom> {
  final years = List.generate(23, (i) => DateTime.now().year - i).reversed.toList();
  final FixedExtentScrollController yearController = FixedExtentScrollController(initialItem: 22);

  final months = List.generate(12, (i) => DateTime(DateTime.now().year, i + 1));
  final FixedExtentScrollController monthController =
      FixedExtentScrollController(initialItem: DateTime.now().month - 1);

  final days = List.generate(31, (i) => i + 1);
  final FixedExtentScrollController dayController =
      FixedExtentScrollController(initialItem: DateTime.now().day - 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      width: double.maxFinite,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'date'.tr(),
              style:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 24),
            ),
            const H(8),
            Expanded(
              child: Row(
                children: [
                  const W(32),
                  _selectorMonthWidget(),
                  _selectorDayWidget(),
                  _selectorYearWidget(),
                ],
              ),
            ),
            const H(8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                          color: const Color(0xFFf1f1f1), borderRadius: BorderRadius.circular(24)),
                      child: Center(
                        child: Text(
                          'cancel'.tr(),
                          style: const TextStyle(
                              color: Color(0xFF010101), fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                const W(16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(
                        context,
                        DateTime(
                            years[yearController.selectedItem],
                            months[monthController.selectedItem].month,
                            days[dayController.selectedItem])),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                          color: const Color(0xFF3559cf), borderRadius: BorderRadius.circular(24)),
                      child: Center(
                        child: Text(
                          'save'.tr(),
                          style: const TextStyle(
                              color: Color(0xFFffffff), fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded _selectorMonthWidget() {
    return Expanded(
      child: SizedBox(
        height: 120,
        child: CupertinoPicker.builder(
          backgroundColor: Colors.white,
          diameterRatio: 1,
          selectionOverlay: Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.black, width: 0.5),
                    bottom: BorderSide(color: Colors.black, width: 0.5))),
          ),
          scrollController: monthController,
          childCount: months.length,
          itemExtent: 30,
          onSelectedItemChanged: (_) {},
          itemBuilder: (_, i) => Text(
            '${DateFormat(DateFormat.MONTH).format(months[i]).substring(0, 3)}.'.toLowerCase(),
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  Expanded _selectorDayWidget() {
    return Expanded(
      child: SizedBox(
        height: 120,
        child: CupertinoPicker.builder(
          backgroundColor: Colors.white,
          diameterRatio: 1,
          selectionOverlay: Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.black, width: 0.5),
                    bottom: BorderSide(color: Colors.black, width: 0.5))),
          ),
          scrollController: dayController,
          childCount: days.length,
          itemExtent: 30,
          onSelectedItemChanged: (_) {},
          itemBuilder: (_, i) => Text(
            days[i] < 10 ? days[i].toString().replaceAll('0', '') : days[i].toString(),
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  Expanded _selectorYearWidget() {
    return Expanded(
      child: SizedBox(
        height: 120,
        child: CupertinoPicker.builder(
          backgroundColor: Colors.white,
          diameterRatio: 1,
          selectionOverlay: Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.black, width: 0.5),
                    bottom: BorderSide(color: Colors.black, width: 0.5))),
          ),
          scrollController: yearController,
          childCount: years.length,
          itemExtent: 30,
          onSelectedItemChanged: (_) {},
          itemBuilder: (_, i) => Text(
            years[i].toString(),
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
