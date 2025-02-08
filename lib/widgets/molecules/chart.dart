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

    double maxValue = statistics.values.reduce((curr, next) => curr > next ? curr : next);

    statistics.forEach((key, value) {
      labels.add(key);

      barChartGroups.add(BarChartGroupData(x: barChartGroups.length, barRods: [
        BarChartRodData(borderRadius: BorderRadius.zero, width: 15, toY: value * 1.0, color: inversePrimary)
      ]));
    });
    
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxValue * 1.4,
        gridData: const FlGridData(
          drawVerticalLine: false,
        ),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(
              maxIncluded: false,
              minIncluded: false,
              reservedSize: 30,
              showTitles: true,
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
                if (value.toInt() >=  labels.length) {
                  return Text('$value');
                }
                return Text(labels[value.toInt()]);
              }
            ),
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