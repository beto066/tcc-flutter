import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final Color? inversePrimary;
  final Map<String, double> statistics;

  const Chart({super.key, this.inversePrimary, this.statistics = const {}});

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barChartGroups = [];
    List<String> labels = [];

    final maxValue =
        statistics.values.reduce((curr, next) => curr > next ? curr : next);
    final maxY = math.max(1, (maxValue * 1.4).ceil()).toDouble();
    final yInterval = math.max(1, (maxY / 4).ceil()).toDouble();

    statistics.forEach((key, value) {
      labels.add(key);

      barChartGroups.add(BarChartGroupData(x: barChartGroups.length, barRods: [
        BarChartRodData(
            borderRadius: BorderRadius.zero,
            width: 15,
            toY: value * 1.0,
            color: inversePrimary)
      ]));
    });

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        gridData: const FlGridData(
          drawVerticalLine: false,
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              interval: yInterval,
              maxIncluded: false,
              minIncluded: false,
              reservedSize: 30,
              showTitles: true,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                maxLines: 1,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= labels.length) {
                    return const SizedBox.shrink();
                  }
                  return SizedBox(
                    width: 48,
                    child: Text(
                      labels[value.toInt()],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  );
                }),
          ),
        ),
        borderData: FlBorderData(
          show: false,
          border: Border.all(color: Colors.grey),
        ),
        barGroups: barChartGroups,
      ),
    );
  }
}
