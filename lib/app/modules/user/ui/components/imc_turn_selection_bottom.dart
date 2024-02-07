import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/enums/turns.dart';

class IMCTurnSelectionBottom extends StatefulWidget {
  const IMCTurnSelectionBottom({super.key});

  @override
  State<IMCTurnSelectionBottom> createState() => _IMCTurnSelectionBottomState();
}

class _IMCTurnSelectionBottomState extends State<IMCTurnSelectionBottom> {
  final FixedExtentScrollController turnController = FixedExtentScrollController(initialItem: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      width: double.maxFinite,
      height: 270,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'time'.tr(),
              style:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 24),
            ),
            const H(8),
            _selectorMonthWidget(),
            const H(20),
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
                    onTap: () => Navigator.pop(context, Turn.values[turnController.selectedItem]),
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

  Widget _selectorMonthWidget() {
    return Center(
      child: SizedBox(
        height: 120,
        width: 100,
        child: CupertinoPicker.builder(
          backgroundColor: Colors.white,
          diameterRatio: 1,
          selectionOverlay: Container(
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.black, width: 0.5),
                    bottom: BorderSide(color: Colors.black, width: 0.5))),
          ),
          scrollController: turnController,
          childCount: Turn.values.length,
          itemExtent: 30,
          onSelectedItemChanged: (_) {},
          itemBuilder: (_, i) => Text(
            Turn.values[i].label,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
