import 'package:flutter/cupertino.dart';
import 'package:svr/app/core/components/app_item_carroussel.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/models/carroussel_model.dart';

class AppCarroussel extends StatefulWidget {
  final List<CarrousselModel> itens;

  const AppCarroussel(this.itens, {super.key});

  @override
  State<AppCarroussel> createState() => _AppCarrousselState();
}

class _AppCarrousselState extends State<AppCarroussel> {
  late CarrousselModel item;

  @override
  void initState() {
    item = widget.itens.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: 380,
          child: PageView(
            onPageChanged: (v) => setState(() => item = widget.itens[v]),
            children: widget.itens
                .map((e) => Container(
                    margin: EdgeInsets.only(
                        left: widget.itens.first == e ? 16 : 8,
                        right: widget.itens.last == e ? 16 : 8),
                    child: AppItemCarroussel(item)))
                .toList(),
          ),
        ),
        const H(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.itens
              .map((e) => Builder(builder: (context) {
                    bool current = e == item;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: current ? 50 : 30,
                      height: 6,
                      decoration: BoxDecoration(
                          color: current ? const Color(0xFF1C44F9) : const Color(0xFFDDE0FF),
                          borderRadius: BorderRadius.circular(12)),
                    );
                  }))
              .toList(),
        )
      ],
    );
  }
}
