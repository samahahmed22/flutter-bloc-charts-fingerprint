import 'package:charts/features/charts/presentation/cubit/charts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/candle.dart';

class CandlesticksScreen extends StatelessWidget {
  late List<Candle> _chartData;
  late TrackballBehavior _trackballBehavior;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: Center(child: Container(child:
              BlocBuilder<ChartsCubit, ChartsState>(builder: (context, state) {
            if (state is CandlesLoaded) {
              _chartData = (state).candles;
              _trackballBehavior = TrackballBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
              );
              return Center(
                child: SfCartesianChart(
                    trackballBehavior: _trackballBehavior,
                    title: ChartTitle(text: "SPUS"),
                    legend: Legend(
                        isVisible: true, position: LegendPosition.bottom),
                    primaryXAxis: DateTimeAxis(
                        dateFormat: DateFormat.yMd(),
                        interval: 1,
                        majorGridLines: MajorGridLines(width: 0)),
                    series: <CandleSeries>[
                      CandleSeries<Candle, DateTime>(
                          name: 'SPUS',
                          showIndicationForSameValues: true,
                          dataSource: _chartData,
                          xValueMapper: (Candle data, _) => data.date,
                          highValueMapper: (Candle data, _) => data.high,
                          lowValueMapper: (Candle data, _) => data.low,
                          openValueMapper: (Candle data, _) => data.open,
                          closeValueMapper: (Candle data, _) => data.close)
                    ]),
              );
            }
            return Container();
          })))),
    );
  }
}
