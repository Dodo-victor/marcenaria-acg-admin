import 'package:acg_admin/utilis/colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatiscScreen extends StatelessWidget {
  const StatiscScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Estatisticas"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: LineChart(
                LineChartData(
                  // Configurações do gráfico aqui
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: ColorsApp.primaryTheme, width: 1),
                  ),

                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 6,

                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(1, 1),
                        const FlSpot(2, 4),
                        const FlSpot(3, 2),
                        const FlSpot(4, 5),
                        const FlSpot(5, 3),
                      ],

                      isCurved: true,
                      preventCurveOverShooting: true,
                      // colors: [Colors.blue],
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
                curve: Curves.linearToEaseOut,
                duration: const Duration(milliseconds: 150),
              ),
            )
          ],
        ));
  }
}
