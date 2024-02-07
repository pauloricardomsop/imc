import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:isoweek/isoweek.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/enums/app_page.dart';
import 'package:svr/app/core/enums/stats_date_type.dart';
import 'package:svr/app/modules/home/home_controller.dart';
import 'package:svr/app/modules/user/user_controller.dart';
import 'package:svr/app/modules/user/user_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserStatsPage extends StatefulWidget {
  const UserStatsPage({super.key});

  @override
  State<UserStatsPage> createState() => _UserStatsPageState();
}

class _UserStatsPageState extends State<UserStatsPage> {
  final UserController _controller = UserController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      background: const Color(0xFFeaeaee),
      body: StreamOut<StatsDateType>(
        stream: _controller.statsTypeStream.listen,
        child: (_, type) => StreamOut<List<UserModel>>(
          stream: _controller.usersStream.listen,
          child: (_, users) => Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'statistics'.tr(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
              ),
              _dateSelectorWidget(type),
              _cartesianChart(users, type, true),
              _cartesianChart(users, type, false),
            ],
          ),
        ),
      ),
    );
  }

  Column _cartesianChart(List<UserModel> users, StatsDateType type, bool imc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const H(16),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  imc ? 'bmi'.tr() : 'weight'.tr(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              InkWell(
                onTap: () => changePage(AppPage.calculator),
                child: Text(
                  'update'.tr(),
                  style: const TextStyle(color: Color(0xFF375acf)),
                ),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Builder(builder: (context) {
            DateTime minX = users.map((e) => e.date).reduce((min, e) => e.isBefore(min) ? e : min);
            DateTime maxX = users.map((e) => e.date).reduce((min, e) => e.isAfter(min) ? e : min);
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.maxFinite,
                height: 250,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: imc ? const Color(0xFF446bed) : const Color(0xFFff8a2e)),
                child: Center(
                  child: SfCartesianChart(
                    margin: const EdgeInsets.all(16),
                    borderWidth: 0,
                    plotAreaBorderWidth: 0,
                    zoomPanBehavior: ZoomPanBehavior(
                      zoomMode: ZoomMode.x,
                      maximumZoomLevel: 0.04,
                      enablePanning: true,
                      enableDoubleTapZooming: false,
                      enableMouseWheelZooming: false,
                      enablePinching: true,
                      enableSelectionZooming: true,
                    ),
                    trackballBehavior: TrackballBehavior(
                        activationMode: ActivationMode.singleTap,
                        shouldAlwaysShow: true,
                        lineColor: Colors.white.withOpacity(0.5),
                        lineWidth: 0.5,
                        enable: true,
                        builder: (_, details) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: const Color(0xFF2b2b2e),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                (imc
                                        ? users[details.seriesIndex ?? 0].imcValue
                                        : users[details.seriesIndex ?? 0].weight)
                                    .toStringAsFixed(1),
                                style: const TextStyle(color: Colors.white),
                              ),
                            )),
                    backgroundColor: imc ? const Color(0xFF446bed) : const Color(0xFFff8a2e),
                    primaryYAxis: NumericAxis(
                      associatedAxisName: 'y',
                      axisBorderType: AxisBorderType.withoutTopAndBottom,
                      labelStyle: const TextStyle(color: Colors.white),
                      axisLine: const AxisLine(width: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                      minorGridLines: const MinorGridLines(width: 0),
                      majorTickLines: const MajorTickLines(width: 0),
                      minorTickLines: const MinorTickLines(width: 0),
                      axisLabelFormatter: (axis) {
                        final parse = double.parse(axis.text);
                        return ChartAxisLabel(
                            parse > 10 ? parse.toStringAsFixed(1) : parse.toStringAsFixed(0), null);
                      },
                    ),
                    primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat('dd-MM-yyyy'),
                      minimum: minX.subtract(const Duration(days: 60)),
                      maximum: maxX.add(const Duration(days: 60)),
                      initialZoomFactor: 0.04,
                      initialZoomPosition: 0.48,
                      associatedAxisName: 'x',
                      axisLine: const AxisLine(width: 0),
                      labelStyle: const TextStyle(color: Colors.white),
                      interval:
                          type == StatsDateType.day ? 1 : (type == StatsDateType.week ? 7 : 30),
                      axisLabelFormatter: (axis) {
                        final date = DateFormat('dd-MM-yyyy').parse(axis.text);
                        if (type == StatsDateType.day) {
                          return ChartAxisLabel(
                              date.day >= 10
                                  ? date.day.toString()
                                  : date.day.toString().replaceAll('0', ''),
                              null);
                        } else if (type == StatsDateType.week) {
                          return ChartAxisLabel(Week.fromDate(date).weekNumber.toString(), null);
                        } else {
                          return ChartAxisLabel(date.month.toString(), null);
                        }
                      },
                    ),
                    series: <LineSeries<UserModel, DateTime>>[
                      LineSeries<UserModel, DateTime>(
                        dataSource: users,
                        color: Colors.white,
                        onCreateShader: (ShaderDetails details) {
                          return ui.Gradient.linear(
                            details.rect.topCenter,
                            details.rect.bottomCenter,
                            <Color>[Colors.white, Colors.transparent],
                          );
                        },
                        markerSettings: MarkerSettings(
                          isVisible: true,
                          color: imc ? const Color(0xFFd3333b) : Colors.white,
                          borderColor: const Color(0xFFfdf7f8),
                          borderWidth: 1,
                        ),
                        yValueMapper: (UserModel data, _) => imc ? data.imcValue : data.weight,
                        xValueMapper: (UserModel data, _) =>
                            DateTime(data.date.year, data.date.month, data.date.day),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Container _dateSelectorWidget(StatsDateType type) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration:
          BoxDecoration(color: const Color(0xFFf6f6f8), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: StatsDateType.values.map(
          (e) {
            final isSelected = type == e;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  _controller.statsTypeStream.add(e);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                      color: isSelected ? Colors.white : const Color(0xFFf6f6f8),
                      borderRadius: BorderRadius.circular(18)),
                  child: Center(
                      child: Text(
                    e.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: isSelected ? Colors.black : const Color(0xFF505050)),
                  )),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
