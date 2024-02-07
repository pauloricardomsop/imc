import 'package:flutter/material.dart';
import 'package:svr/app/core/enums/imc_level.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class IMCChart extends StatefulWidget {
  final double imc;

  const IMCChart(this.imc, {super.key});

  @override
  State<IMCChart> createState() => _IMCChartState();
}

class _IMCChartState extends State<IMCChart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 100,
              showLabels: false,
              labelsPosition: ElementsPosition.outside,
              startAngle: 180,
              endAngle: 0,
              ranges: IMCLevel.values
                  .map((e) => GaugeRange(
                        startValue: e.minChart,
                        endValue: e.maxChart,
                        color: e.color,
                        endWidth: 90,
                        startWidth: 90,
                      ))
                  .toList(),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: getAngle(),
                  needleColor: const Color(0xFF2b2b2e),
                  needleLength: 0.50,
                ),
              ],
              annotations: const <GaugeAnnotation>[],
            )
          ],
        ),
        Positioned(
          bottom: 177,
          left: 26,
          child: Transform.rotate(
            angle: 11,
            child: const Text(
              '16',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Positioned(
          bottom: 201,
          left: 28.5,
          child: Transform.rotate(
            angle: 11.18,
            child: const Text(
              '17',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Positioned(
          bottom: 240,
          left: 34.5,
          child: Transform.rotate(
            angle: 11.40,
            child: const Text(
              '18.5',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Positioned(
          bottom: 322,
          left: 116,
          child: Transform.rotate(
            angle: 12.1,
            child: const Text(
              '25',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Positioned(
          bottom: 339,
          left: 229,
          child: Transform.rotate(
            angle: 12.75,
            child: const Text(
              '30',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Positioned(
          bottom: 285,
          left: 328,
          child: Transform.rotate(
            angle: 13.5,
            child: const Text(
              '35',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Positioned(
          bottom: 183,
          left: 372,
          child: Transform.rotate(
            angle: 14,
            child: const Text(
              '40',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ],
    );
  }

  double getAngle() {
    if (widget.imc < 16) return 0.6;
    if (widget.imc == 16) return 1.8;
    if (widget.imc > 16 && widget.imc < 17) return 3.8;
    if (widget.imc == 17) return 5.9;
    if (widget.imc > 17 && widget.imc < 18.5) return 9.5;
    if (widget.imc == 18.5) return 13;
    if (widget.imc > 18.5 && widget.imc < 25) return 22;
    if (widget.imc == 25) return 34;
    if (widget.imc > 25 && widget.imc < 30) return 45;
    if (widget.imc == 30) return 55.5;
    if (widget.imc > 30 && widget.imc < 35) return 67;
    if (widget.imc == 35) return 76.5;
    if (widget.imc > 35 && widget.imc < 40) return 88;
    if (widget.imc == 40) return 97.5;

    return 99;
  }
}
