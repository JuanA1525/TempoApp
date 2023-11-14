import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SleepTable extends StatelessWidget {
  final List<Sleep> sleepList;

  const SleepTable({super.key, required this.sleepList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ... (Tabla de sueños)

        // Gráfico de barras
        Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 12,
              minY: 0,
              groupsSpace: 12,
              barGroups: sleepList.asMap().entries.map((entry) {
                int index = entry.key;
                Sleep sleep = entry.value;

                return BarChartGroupData(
                  x: index.toInt(),
                  barRods: [
                    BarChartRodData(
                      toY: sleep.duration,
                      color: Colors.blue,
                      width: 16,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class Sleep {
  final DateTime sDate;
  final double duration;

  Sleep({required this.sDate, required this.duration});
}

class Sleeps extends StatelessWidget {
  const Sleeps({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Tabla y Gráfico de Sueños')),
        body: SleepTable(
          sleepList: [
            Sleep(sDate: DateTime(2023, 10, 1), duration: 7.5),
            Sleep(sDate: DateTime(2023, 10, 2), duration: 8.0),
            // Agrega más sueños según tu lista
          ],
        ),
      ),
    );
  }
}
